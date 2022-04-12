import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/category_node_model.dart';
import 'package:finwallet_app/app/account/usecases/fetch_summary_by_category.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import 'package:meta/meta.dart';

import '../../../../common/http_client/exceptions.dart';

part 'analytics_state.dart';

class AnalyticsCubit<T> extends Cubit<AnalyticsState<T>> {
  final FetchSummaryByCategory _fetchSummaryByCategory;

  AnalyticsCubit(this._fetchSummaryByCategory) : super(AnalyticsInitial<T>());

  void fetch() async {
    try {
      print(T.runtimeType);
      // if (typeOf(T) == CategoryNodeModel) {
        print("TTT");
        print(T);
        print(T is CategoryNodeModel);
        emit(state.copyWith(loading: true));
      print("fetching");
        List<CategoryNodeModel> models = await this._fetchSummaryByCategory(
            QueryParams({
              "startDate": DateTime.utc(2022, 3, 1).toIso8601String(),
              "endDate": DateTime.utc(2022, 4, 1).toIso8601String(),
              "transactionType": "CRE"
            })
        );
        print("fetched");
        print(models);
        emit(state.copyWith(loading: false, models: models, loaded: true));
      // }

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
}
