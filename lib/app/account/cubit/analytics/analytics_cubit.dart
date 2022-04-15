import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/category_node_model.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/date_node_model.dart';
import 'package:finwallet_app/app/account/domain/analytics_type.dart';
import 'package:finwallet_app/app/account/usecases/fetch_summary_by_category.dart';
import 'package:finwallet_app/app/account/usecases/fetch_summary_by_date.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import 'package:meta/meta.dart';

import '../../../../common/http_client/exceptions.dart';

part 'analytics_state.dart';

class AnalyticsCubit<T> extends Cubit<AnalyticsState<T>> {
  final FetchSummaryByCategory _fetchSummaryByCategory;
  final FetchSummaryByDate _fetchSummaryByDate;
  final AnalyticsType type;

  AnalyticsCubit(
      this.type,
      this._fetchSummaryByCategory,
      this._fetchSummaryByDate
      ) : super(AnalyticsInitial<T>());

  void fetch() async {
    try {


      if (this.type == AnalyticsType.category) {
        await this._fetchByCategory();
      } else if (this.type == AnalyticsType.date) {
        await this._fetchByDate();
      }

    } on HttpException catch (error) {
      print(error);
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

  Future<void> _fetchByCategory() async {
    emit(state.copyWith(loading: true));

    List<CategoryNodeModel> models = await this._fetchSummaryByCategory(
        QueryParams({
          "startDate": _getStartDateOfMonth(DateTime.now()).toIso8601String(),
          "endDate": _getEndDateOfMonth(DateTime.now()).toIso8601String(),
          "transactionType": "CRE"
        })
    );

    emit(state.copyWith(loading: false, models: models, loaded: true));
  }

  Future<void> _fetchByDate() async {
    emit(state.copyWith(loading: true));

    List<DateNodeModel> models = await this._fetchSummaryByDate(
        QueryParams({
          "startDate": _getStartDateOfMonth(DateTime.now()).toIso8601String(),
          "endDate": _getEndDateOfMonth(DateTime.now()).toIso8601String(),
          "transactionType": "CRE"
        })
    );

    emit(state.copyWith(loading: false, models: models, loaded: true));
  }
}
