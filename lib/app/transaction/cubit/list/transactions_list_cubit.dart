import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/app/transaction/usecases/query_transactions.dart';
import 'package:finwallet_app/common/http_client/pagination.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import 'package:meta/meta.dart';

import '../../../../common/http_client/exceptions.dart';

part 'transactions_list_state.dart';

class TransactionsListCubit extends Cubit<TransactionsListState> {
  final QueryTransactions _query;

  TransactionsListCubit(this._query) : super(TransactionsListInitial());

  void load(TransactionType type) async {
    try {
      emit(state.copyWith(loading: true));
      Pagination<TransactionEntity> result = await this._query(
          QueryTransactionsParams(
              query: QueryParams()
          )
      );

      emit(state.copyWith(loading: false, entities: result.data, loaded: true));
    } on HttpException catch (error) {
      emit(state.copyWith(loading: false, error: error));
    } catch (error) {
      print(error);
      emit(state.copyWith(loading: false, error: error.toString()));
    }
  }
}
