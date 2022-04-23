import 'package:finwallet_app/app/category/domain/category_repository_contract.dart';
import 'package:finwallet_app/app/tag/domain/tag_entity.dart';
import 'package:finwallet_app/app/tag/domain/tag_repository_contract.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/http_client/pagination.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import 'package:finwallet_app/common/utils/enum_to_string.dart';

class UpdateTag extends Interactor<Future<TagEntity>, UpdateTagParams> {

  final TagRepositoryContract categories;

  UpdateTag(this.categories);

  @override
  Future<TagEntity> call(UpdateTagParams params) {
    try {
      this.validate(params);
      return this.categories.update(params.entity);
    } catch (error) {
      print(error);
      rethrow;
    }

  }

  @override
  void validate(UpdateTagParams params) {

  }

}

class UpdateTagParams extends Params {
  final TagEntity entity;

  UpdateTagParams({
    required this.entity
  });

  @override
  get props => [entity];
}