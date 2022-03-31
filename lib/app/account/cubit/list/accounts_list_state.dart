part of 'accounts_list_cubit.dart';


class AccountsListState {
  final bool loading;
  final List<AccountEntity> entities;
  final String? error;
  final bool loaded;

  AccountsListState({
    required this.entities,
    required this.loading,
    this.loaded = false,
    this.error
  });

  AccountsListState copyWith({entities, loading, error, loaded}) =>
      AccountsListState(
          entities: entities ?? this.entities,
          loading: loading ?? this.loading,
          error: error ?? this.error,
          loaded: loaded ?? this.loaded
      );
}

class AccountsListInitial extends AccountsListState {
  AccountsListInitial() : super(
    loading: false,
    entities: [],
  );
}
//
// class AccountsListLoading extends AccountsListState {}
//
// class AccountsListLoaded extends AccountsListState {}
//
// class AccountsListError extends AccountsListState {
//   final String message;
//
//   AccountsListError(this.message);
// }
