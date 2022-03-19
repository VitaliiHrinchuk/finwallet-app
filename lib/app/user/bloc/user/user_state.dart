part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserNotConfigured extends UserState {}

class UserIsSetup extends UserState {}

class UserLoaded extends UserState {
  final UserEntity user;

  UserLoaded(this.user);
}

class UserError extends UserState {
  final String? error;

  UserError({
    this.error = "Unknown error"
  });

}

class UserValidationError extends UserState {
  final Map<String, String> errors;

  UserValidationError({
    required this.errors
  });
}
