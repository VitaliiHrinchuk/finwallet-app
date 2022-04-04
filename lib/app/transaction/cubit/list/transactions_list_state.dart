part of 'transactions_list_cubit.dart';

class TransactionsListState {
  final bool loading;
  final List<TransactionEntity> entities;
  final String? error;
  final bool loaded;

  TransactionsListState({
    required this.entities,
    required this.loading,
    this.loaded = false,
    this.error
  });

  TransactionsListState copyWith({entities, loading, error, loaded}) =>
      TransactionsListState(
          entities: entities ?? this.entities,
          loading: loading ?? this.loading,
          error: error ?? this.error,
          loaded: loaded ?? this.loaded
      );
}

class TransactionsListInitial extends TransactionsListState {
  TransactionsListInitial() : super(entities: [], loading: false);
}
