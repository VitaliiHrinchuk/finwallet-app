part of 'transactions_list_cubit.dart';

class TransactionsListState {
  final bool loading;
  final List<TransactionEntity> entities;
  final String? error;
  final bool loaded;
  final TransactionsListFilters filters;

  TransactionsListState({
    required this.entities,
    required this.loading,
    this.loaded = false,
    required this.filters,
    this.error
  });

  TransactionsListState copyWith({entities, loading, error, loaded, filters}) =>
      TransactionsListState(
          entities: entities ?? this.entities,
          loading: loading ?? this.loading,
          error: error ?? this.error,
          loaded: loaded ?? this.loaded,
          filters: filters ?? this.filters
      );
}

class TransactionsListInitial extends TransactionsListState {
  TransactionsListInitial() : super(
      entities: [],
      loading: false,
      filters: TransactionsListFilters()
  );
}
