part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class UserFetch extends UserEvent {}

class UserSetError extends UserEvent {
  final String? error;

  UserSetError({
    this.error
  });
}

class UserSetup extends UserEvent {
  final String baseCurrency;

  UserSetup({
    required this.baseCurrency
  });
}

