import 'package:finwallet_app/app/category/domain/category_repository_contract.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/http_client/pagination.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import 'package:finwallet_app/common/utils/enum_to_string.dart';

import '../domain/category_entity.dart';

class UpdateCategory extends Interactor<Future<CategoryEntity>, UpdateCategoryParams> {

  final CategoryRepositoryContract categories;

  UpdateCategory(this.categories);

  @override
  Future<CategoryEntity> call(UpdateCategoryParams params) {
    try {
      this.validate(params);
      return this.categories.update(params.entity);
    } catch (error) {
      print(error);
      rethrow;
    }

  }

  @override
  void validate(UpdateCategoryParams params) {

  }

}

class UpdateCategoryParams extends Params {
  final CategoryEntity entity;

  UpdateCategoryParams({
    required this.entity
  });

  @override
  get props => [entity];
}