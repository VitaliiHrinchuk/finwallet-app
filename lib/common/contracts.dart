import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'http_client/http_client.dart';
import 'package:http/http.dart';

abstract class Interactor<Type, Params> {
  Type call(Params params);
  void validate(Params params);
}

abstract class Params extends Equatable {}

class EmptyParams extends Params {
  List<Object> get props => [];

  @override
  bool? get stringify => true;
}

abstract class ValidatorContract  {

  ValidatorContract();

  void validate();
  void setRules(Map<String, String> rules);
  void setValues(Map<String, dynamic> values);
  void addRule(String field, String rule);
}

abstract class Model {
  Model.fromJSON(Map<String, dynamic> json);
  Map<String, dynamic> toJSON();
}

abstract class AbstractHttpDataProvider<T> {
  late final String path;

  final scheme = 'http';

  final HttpClient client;

  T fromJSON(Map<String, dynamic> json);

  AbstractHttpDataProvider({required this.client});

  Future<List<T>> browse(Map<String, dynamic> query) async {
    Uri uri = this.client.generateUri(baseUrl: this.client.baseUrl, query: query);

    Map<String, dynamic> result = await this.client.get(uri);

    return result['data'].map((key, value) => fromJSON(value));
  }

  Future<T> read(String id) async {
    Uri uri = this.generateUri(path: this.path + id);

    Map<String, dynamic> result = await this.client.get(uri);

    return fromJSON(result);
  }

  Future<T> update(String id, Map<String, dynamic> body) async {
    Uri uri = this.generateUri(path: this.path + id);

    Map<String, dynamic> result = await this.client.patch(uri, body: body);

    return fromJSON(result);
  }

  Future<T> create(Map<String, dynamic> body) async {
    Uri uri = this.generateUri(path: this.path);
    print(uri);
    Map<String, dynamic> result = await this.client.post(uri, body: body);

    return fromJSON(result);
  }

  Future<void> remove(String id) async {
    Uri uri = this.generateUri(path: this.path + id);

    await this.client.delete(uri);
  }

  Uri generateUri({String path = '', Map<String, dynamic> query = const {}}) {
    return this.client.generateUri(baseUrl: this.client.baseUrl, path: path, query: query);
  }


}