class DomainException implements Exception {
  final String message;

  DomainException(this.message);

  @override
  String toString() => message;
}

class ValidationException implements DomainException {
  final String message = 'Validation error';
  final Map<String,String> messages;

  ValidationException(this.messages);

  @override
  String toString() => messages.toString();
}
