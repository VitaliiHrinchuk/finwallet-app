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

  void load() async {
    try {

      DateTime startDate = this._getStartDateOfMonth(DateTime.now().subtract(Duration(days: 31)));
      DateTime endDate = this._getEndDateOfMonth(DateTime.now().subtract(Duration(days: 31)));
      print(startDate.toIso8601String());
      print(endDate.toIso8601String());
      emit(state.copyWith(loading: true));
      Pagination<TransactionEntity> result = await this._query(
          QueryTransactionsParams(
              query: QueryParams({
                // 'type': type.toString().split('.').last,
                'startDate': startDate.toIso8601String(),
                'endDate': endDate.toIso8601String(),
                'limit': '999'
              })
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

  DateTime _getStartDateOfMonth(DateTime date) {
    return DateTime.utc(date.year, date.month, 1);
  }

  DateTime _getEndDateOfMonth(DateTime date) {
    return DateTime.utc(date.year,date.month+1,).subtract(Duration(days: 1));
  }
}
