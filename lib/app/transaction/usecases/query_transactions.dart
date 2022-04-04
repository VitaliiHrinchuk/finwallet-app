import 'package:finwallet_app/app/category/domain/category_repository_contract.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_repository_contract.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/http_client/pagination.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';

import '../domain/transaction_entity.dart';

class QueryTransactions extends Interactor<Future<Pagination<TransactionEntity>>, QueryTransactionsParams> {

  final TransactionRepositoryContract transactions;

  QueryTransactions(this.transactions);

  @override
  Future<Pagination<TransactionEntity>> call(QueryTransactionsParams params) {
    try {
      this.validate(params);
      return this.transactions.browse(params.query.getParams());
    } catch (error) {
      print(error);
      rethrow;
    }

  }

  @override
  void validate(QueryTransactionsParams params) {

  }

}

class QueryTransactionsParams extends Params {
  final QueryParams query;

  QueryTransactionsParams({
    required this.query
  });

  @override
  List<Object?> get props => [query];
}