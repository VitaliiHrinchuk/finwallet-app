part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthChecked extends AuthEvent {}

class AuthAttempt extends AuthEvent {
  final String email;
  final String password;

  AuthAttempt(this.email, this.password);

}

class AuthErrorEvent extends AuthEvent {
  final String? error;

  AuthErrorEvent({
    this.error
  });
}

class AuthSetUser extends AuthEvent{
  final AuthUserEntity user;

  AuthSetUser({
    required this.user
  });
}

class AuthAttemptSignup extends AuthEvent {
  final String email;
  final String password;
  final String confirmPassword;

  AuthAttemptSignup(this.email, this.password, this.confirmPassword);

}

class AuthLogout extends AuthEvent{}
