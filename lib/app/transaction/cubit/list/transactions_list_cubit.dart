import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/app/transaction/usecases/query_transactions.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/http_client/pagination.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import 'package:meta/meta.dart';

import '../../../../common/http_client/exceptions.dart';
import 'transactions_list_filters.dart';

part 'transactions_list_state.dart';

class TransactionsListCubit extends Cubit<TransactionsListState> {
  final QueryTransactions _query;

  TransactionsListCubit(this._query) : super(TransactionsListInitial());

  void fetch() async {
    try {

      if (state.filters.startDate == null) {
        DateTime startDate = this._getStartDateOfMonth(DateTime.now());
        this.setFilterStartDate(startDate);
      }

      if (state.filters.endDate == null) {
        DateTime endDate = this._getEndDateOfMonth(DateTime.now());
        this.setFilterEndDate(endDate);
      }

      state.copyWith(loading: true);
    print(state.filters.toJson());
      Pagination<TransactionEntity> result = await this._query(
          QueryTransactionsParams(
              query: QueryParams(state.filters.toJson())
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

  void setFilterStartDate(DateTime startDate) {
    emit(state.copyWith(
      filters: state.filters.copyWith(
        startDate: startDate
      )
    ));
  }

  void setFilterEndDate(DateTime endDate) {
    emit(state.copyWith(
        filters: state.filters.copyWith(
            endDate: endDate
        )
    ));
  }

  void setLimit(int limit) {
    emit(state.copyWith(
        filters: state.filters.copyWith(
            limit: limit
        )
    ));
  }

  void setAccount(AccountEntity? account) {
    emit(state.copyWith(
        filters: state.filters.copyWith(
            account: Optional<AccountEntity>(account)
        )
    ));
  }


  DateTime _getStartDateOfMonth(DateTime date) {
    return DateTime.utc(date.year, date.month, 1);
  }

  DateTime _getEndDateOfMonth(DateTime date) {
    return DateTime.utc(date.year,date.month+1,).subtract(Duration(days: 1));
  }


}
