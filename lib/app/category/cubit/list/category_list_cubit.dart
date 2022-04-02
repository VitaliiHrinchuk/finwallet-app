import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/usecases/list_account.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/category/usecases/list_category.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/common/http_client/pagination.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import 'package:finwallet_app/common/utils/enum_to_string.dart';
import 'package:meta/meta.dart';

import '../../../../common/http_client/exceptions.dart';

part 'category_list_state.dart';

class CategoryListCubit extends Cubit<CategoryListState> {
  final ListCategory _fetch;

  CategoryListCubit(this._fetch) : super(CategoryListInitial());

  void load(TransactionType type) async {
    try {
      emit(state.copyWith(loading: true));
      Pagination<CategoryEntity> result = await this._fetch(
          ListCategoryParams(
              query: QueryParams()..setParam('categoryType', enumToShortString(type.toString()))
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
