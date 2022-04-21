import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/account/cubit/analytics/analytics_filters.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/category_node_model.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/currency_node_model.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/date_node_model.dart';
import 'package:finwallet_app/app/account/domain/analytics_type.dart';
import 'package:finwallet_app/app/account/usecases/fetch_summary_by_category.dart';
import 'package:finwallet_app/app/account/usecases/fetch_summary_by_currency.dart';
import 'package:finwallet_app/app/account/usecases/fetch_summary_by_date.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import 'package:meta/meta.dart';

import '../../../../common/http_client/exceptions.dart';

part 'analytics_state.dart';

class AnalyticsCubit<T> extends Cubit<AnalyticsState<T>> {
  final FetchSummaryByCategory _fetchSummaryByCategory;
  final FetchSummaryByDate _fetchSummaryByDate;
  final FetchSummaryByCurrency _fetchSummaryByCurrency;
  final AnalyticsType type;

  AnalyticsCubit(
      this.type,
      this._fetchSummaryByCategory,
      this._fetchSummaryByDate,
      this._fetchSummaryByCurrency
      ) : super(AnalyticsInitial<T>());

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

      if (this.type == AnalyticsType.category) {
        await this._fetchByCategory();
      } else if (this.type == AnalyticsType.date) {
        await this._fetchByDate();
      } else if (this.type == AnalyticsType.currency) {
        await this._fetchByCurrency();
      }

    } on HttpException catch (error) {
      print(error);
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

  Future<void> _fetchByCategory() async {
    emit(state.copyWith(loading: true));

    List<CategoryNodeModel> models = await this._fetchSummaryByCategory(
        QueryParams(state.filters.toJson())
    );

    emit(state.copyWith(loading: false, models: models, loaded: true));
  }

  Future<void> _fetchByDate() async {
    emit(state.copyWith(loading: true));

    List<DateNodeModel> models = await this._fetchSummaryByDate(
        QueryParams(state.filters.toJson())
    );

    emit(state.copyWith(loading: false, models: models, loaded: true));
  }

  Future<void> _fetchByCurrency() async {
    emit(state.copyWith(loading: true));

    List<CurrencyNodeModel> models = await this._fetchSummaryByCurrency(
        QueryParams(state.filters.toJson())
    );

    emit(state.copyWith(loading: false, models: models, loaded: true));
  }
}
