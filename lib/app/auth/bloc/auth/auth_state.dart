part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {

  AuthAuthenticated();
}

class AuthError extends AuthState {
  final String error;

  AuthError({
    this.error = "Unknown error"
  });

}

class AuthValidationError extends AuthState {
  final Map<String, String> errors;

  AuthValidationError({
    required this.errors
  });

}

class AuthValidationErrorState extends AuthState {
  final Map<String, String> errors;

  AuthValidationErrorState({
    required this.errors
  });
}

class AuthSignedUp extends AuthState {}



