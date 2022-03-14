abstract class HttpException implements Exception {
  final String title;

  final String? description;

  final Map<String, dynamic>? body;

  String get message {
    if (this.description != null) {
      return this.description!;
    } else {
      return this.title;
    }

  }

  HttpException({
      required this.title,
      this.description,
      this.body
  });
}

class NetworkException extends HttpException {
  NetworkException({ String? message }) : super(
      title: "The remote resource can't be reached",
      body: null,
      description: message
  );
}

class NotFoundException extends HttpException {
  NotFoundException({ String? message }) : super(
      title: "Not Found",
      body: null,
      description: message
  );
}

class BadRequestException extends HttpException {
  BadRequestException({ String? message, List<dynamic>? errors }) : super(
      title: "Bad Request",
      body:  {
        "errors": errors
      },
      description: message
  );
}

class InternalServerException extends HttpException {
  InternalServerException({ String? message, Map<String, dynamic>? body }) : super(
      title: "Internal Server Error",
      body: body,
      description: message
  );
}

class UnauthorizedException extends HttpException {
  UnauthorizedException() : super(
      title: "Unauthorized"
  );
}

