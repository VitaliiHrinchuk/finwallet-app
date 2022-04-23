import 'package:finwallet_app/app/category/domain/category_repository_contract.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/http_client/pagination.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import 'package:finwallet_app/common/utils/enum_to_string.dart';

import '../domain/category_entity.dart';

class CreateCategory extends Interactor<Future<CategoryEntity>, CreateCategoryParams> {

  final CategoryRepositoryContract categories;

  CreateCategory(this.categories);

  @override
  Future<CategoryEntity> call(CreateCategoryParams params) {
    try {
      this.validate(params);
      return this.categories.create(params.name, enumToShortString(params.type.toString()));
    } catch (error) {
      print(error);
      rethrow;
    }

  }

  @override
  void validate(CreateCategoryParams params) {

  }

}

class CreateCategoryParams extends Params {
  final String name;
  final CategoryType type;

  CreateCategoryParams({
    required this.name,
    required this.type
  });

  @override
  get props => [name, type];
}