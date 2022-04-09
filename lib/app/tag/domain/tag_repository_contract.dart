import 'package:finwallet_app/app/tag/domain/tag_entity.dart';
import '../../../common/http_client/pagination.dart';

abstract class TagRepositoryContract {
  Future<TagEntity> find(String id);
  Future<TagEntity> update(TagEntity entity);
  Future<TagEntity> create(String name);
  Future<Pagination<TagEntity>> browse(Map<String, dynamic> query);
}