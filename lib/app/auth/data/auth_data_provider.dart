import 'dart:convert';

import 'package:finwallet_app/app/auth/domain/auth_user_entity.dart';
import 'package:finwallet_app/app/auth/domain/credentials.dart';
import 'package:finwallet_app/common/contracts.dart';
import '../../../common/http_client/http_client.dart';
import 'package:http/http.dart';

class AuthDataProvider extends AbstractHttpDataProvider {
  @override
  String path = 'auth';

  AuthDataProvider(HttpClient client) : super(baseUrl: '10.0.2.2', client: client);


  @override
  fromJSON(Map<String, dynamic> json) {
    // TODO: implement fromJSON
    throw UnimplementedError();
  }

  Future<bool> signUpWithCredentials(Credentials credentials) async {
    Map<String, dynamic> body = {};
    Uri uri = this.generateUri(path: this.path + '/register');

    body['email'] = credentials.email;
    body['password'] = credentials.password;

    await this.client.post(uri, body: body);

    return true;
  }

  Future<String> signInWithCredentials(Credentials credentials) async {
    Map<String, dynamic> body = {};
    Uri uri = this.generateUri(path: this.path + '/login');
    print("uri ${uri}");
    body['email'] = credentials.email;
    body['password'] = credentials.password;

    Map<String, dynamic> result = await this.client.post(uri, body: body);

    return result['access_token'];
  }
  
  void signOut() {
    this.client.removeAuthToken();
  }

  void setAuthToken(String token) {
    this.client.setAuthToken(token);
  }
}
