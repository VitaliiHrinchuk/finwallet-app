import 'package:finwallet_app/app/category/domain/category_repository_contract.dart';
import 'package:finwallet_app/app/tag/domain/tag_entity.dart';
import 'package:finwallet_app/app/tag/domain/tag_repository_contract.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/http_client/pagination.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import 'package:finwallet_app/common/utils/enum_to_string.dart';


class CreateTag extends Interactor<Future<TagEntity>, CreateTagParams> {

  final TagRepositoryContract categories;

  CreateTag(this.categories);

  @override
  Future<TagEntity> call(CreateTagParams params) {
    try {
      this.validate(params);
      return this.categories.create(params.name);
    } catch (error) {
      print(error);
      rethrow;
    }

  }

  @override
  void validate(CreateTagParams params) {

  }

}

class CreateTagParams extends Params {
  final String name;

  CreateTagParams({
    required this.name
  });

  @override
  get props => [name];
}