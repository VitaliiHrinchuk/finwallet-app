import 'package:finwallet_app/app/category/domain/category_repository_contract.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/http_client/pagination.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';

import '../domain/category_entity.dart';

class ListCategory extends Interactor<Future<Pagination<CategoryEntity>>, ListCategoryParams> {

  final CategoryRepositoryContract categories;

  ListCategory(this.categories);

  @override
  Future<Pagination<CategoryEntity>> call(ListCategoryParams params) {
    try {
      this.validate(params);
      return this.categories.browse(params.query.getParams());
    } catch (error) {
      print(error);
      rethrow;
    }

  }

  @override
  void validate(ListCategoryParams params) {

  }

}

class ListCategoryParams extends Params {
  final QueryParams query;

  ListCategoryParams({
    required this.query
  });

  @override
  List<Object?> get props => [query];
}