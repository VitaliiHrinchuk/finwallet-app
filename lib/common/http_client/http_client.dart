import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:finwallet_app/common/constants/local_storage_keys.dart';
import 'package:finwallet_app/common/http_client/exceptions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpClient {
  final scheme = 'http';
  final String baseUrl;

  final http.Client client;
  final Function(int status, String message) errorInterceptor;

  Map<String, String>? _headers = {
    "content-type": "application/json",
  };

  HttpClient({required this.client, required this.errorInterceptor, required this.baseUrl});

  Future<Map<String, dynamic>> get(Uri uri) async {
    try {
      Response response = await this.client.get(uri, headers: this._headers);
      return _processResponse(response);
    } on SocketException {
      throw NetworkException();
    }
  }

  Future<Map<String, dynamic>> delete(Uri uri) async {
    try {
      Response response = await this.client.delete(uri, headers: this._headers);
      return _processResponse(response);
    } on SocketException {
      throw NetworkException();
    }
  }

  Future<Map<String, dynamic>> post(Uri uri, {Object? body}) async {
    try {
      Response response = await this.client.post(uri, headers: this._headers, body: json.encode(body));
      return _processResponse(response);
    } on SocketException {
      throw NetworkException();
    }
  }

  Future<Map<String, dynamic>> patch(Uri uri, {Object? body}) async {
    try {
      Response response = await this.client.patch(uri, headers: this._headers, body: json.encode(body));
      return _processResponse(response);
    } on SocketException {
      throw NetworkException();
    }
  }

  Future<Map<String, dynamic>> put(Uri uri, {Object? body}) async {
    try {
      Response response = await this.client.put(uri, headers: this._headers, body: json.encode(body));
      return _processResponse(response);
    } on SocketException {
      throw NetworkException();
    }
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    print(response.body);
    Map<String, dynamic> responseJson = response.body.length > 0 ? json.decode(response.body.toString()) : {};
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
      case 203:
      case 204:
        return responseJson;
      case 400:
        print(responseJson);
        throw BadRequestException(
            message: responseJson["message"] is List ? "Bad Request" : responseJson["message"] ,
            errors: responseJson["message"] is List ? responseJson["message"] : null
        );
      case 401:
      case 403:
        this.errorInterceptor(response.statusCode, responseJson["message"]);
        throw UnauthorizedException();
      case 404:
        throw NotFoundException();
      case 500:
        throw InternalServerException(body: jsonDecode(response.body));
      default:
        throw NetworkException(
          message: 'Error occured while Communication with Server with StatusCode: ${response.statusCode}'
        );
    }
  }

  Uri generateUri(
      {String path = '',
      Map<String, dynamic> query = const {},
      required String baseUrl}) {
    return new Uri(
      scheme: this.scheme,
      host: baseUrl,
      port: kDebugMode ? 3000 : null,
      path: path,
      queryParameters: query,
    );
  }

  void setAuthToken(String value) {
    this.setHeader("Authorization", "Bearer " + value);
  }

  void removeAuthToken() {
    this.removeHeader('Authorization');
  }

  void setHeader(String key, String value) {
    this._headers?[key] = value;
  }

  String? getHeader(String key) {
    return this._headers?[key];
  }

  void removeHeader(String key) {
    this._headers?.remove(key);
  }
}
