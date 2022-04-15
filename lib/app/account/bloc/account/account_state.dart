part of 'account_bloc.dart';

@immutable
abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountRemoved extends AccountState {}

class AccountLoaded extends AccountState {
  final AccountEntity account;

  AccountLoaded(this.account);
}

class AccountError extends AccountState {
  final String? error;

  AccountError({
    this.error = "Unknown error"
  });

}

class AccountValidationError extends AccountState {
  final Map<String, String> errors;

  AccountValidationError({
    required this.errors
  });
}

class AccountFetched extends AccountState {
  final List<AccountEntity> accounts;

  AccountFetched({ required this.accounts });
}
