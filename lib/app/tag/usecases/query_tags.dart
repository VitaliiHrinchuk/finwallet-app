import 'package:finwallet_app/app/category/domain/category_repository_contract.dart';
import 'package:finwallet_app/app/tag/domain/tag_entity.dart';
import 'package:finwallet_app/app/tag/domain/tag_repository_contract.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/http_client/pagination.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';

class QueryTags extends Interactor<Future<Pagination<TagEntity>>, QueryTagsParams> {

  final TagRepositoryContract tags;

  QueryTags(this.tags);

  @override
  Future<Pagination<TagEntity>> call(QueryTagsParams params) {
    try {
      this.validate(params);
      return this.tags.browse(params.query?.getParams() ?? {});
    } catch (error) {
      print(error);
      rethrow;
    }

  }

  @override
  void validate(QueryTagsParams params) {

  }

}

class QueryTagsParams extends Params {
  final QueryParams? query;

  QueryTagsParams({
    this.query
  });

  @override
  List<Object?> get props => [query];
}