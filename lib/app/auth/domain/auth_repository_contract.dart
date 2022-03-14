
import 'auth_user_entity.dart';
import 'credentials.dart';

abstract class AuthRepositoryContract {
  Future<String> singInWithCredentials(Credentials credentials);
  Future<bool> singUpWithCredentials(Credentials credentials);
  Future<void> singOut();
  Future<String?> getAuthToken();
  Future<bool> check();
}