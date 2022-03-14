import 'package:finwallet_app/app/auth/data/auth_data_provider.dart';
import 'package:finwallet_app/app/auth/domain/auth_repository_contract.dart';
import 'package:finwallet_app/app/auth/domain/auth_user_entity.dart';
import 'package:finwallet_app/app/auth/domain/credentials.dart';
import 'package:finwallet_app/common/constants/local_storage_keys.dart';

import 'package:rules/rules.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository extends AuthRepositoryContract {

  final AuthDataProvider dataProvider;

  AuthRepository(this.dataProvider) {}

  @override
  Future<bool> check() async {
    String? token = await this.getAuthToken();

    if (token != null) {
      this.dataProvider.setAuthToken(token);

      return true;
    } else {
      return false;
    }

  }

  @override
  Future<String> singInWithCredentials(Credentials credentials) async {
    String token = await this.dataProvider.signInWithCredentials(credentials);
    final prefs = await SharedPreferences.getInstance();

    prefs.setString(AUTH_TOKEN_KEY, token);

    this.dataProvider.setAuthToken(token);

    return token;
  }

  @override
  Future<void> singOut() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(AUTH_TOKEN_KEY);

    this.dataProvider.signOut();
  }

  @override
  Future<bool> singUpWithCredentials(Credentials credentials) {
    return this.dataProvider.signUpWithCredentials(credentials);
  }

  @override
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(AUTH_TOKEN_KEY);
  }

 
}
