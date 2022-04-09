import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/domain/account_repository_contract.dart';
import 'package:finwallet_app/app/account/dto/create_account_dto.dart';
import 'package:finwallet_app/app/category/data/category_data_provider.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/category/domain/category_repository_contract.dart';
import 'package:finwallet_app/app/tag/data/tag_data_provider.dart';
import 'package:finwallet_app/app/tag/domain/tag_entity.dart';
import 'package:finwallet_app/app/tag/domain/tag_repository_contract.dart';
import '../../../common/http_client/pagination.dart';


class TagRepository implements TagRepositoryContract {
  final TagDataProvider dataProvider;

  TagRepository(this.dataProvider);

  @override
  Future<TagEntity> create(String name) {
    return this.dataProvider.create({"name": name});
  }

  @override
  Future<TagEntity> find(String id) {
    return this.dataProvider.read(id);
  }

  @override
  Future<TagEntity> update(TagEntity entity) {
    return this.dataProvider.update(entity.id, entity.toJson());
  }

  @override
  Future<Pagination<TagEntity>> browse(Map<String, dynamic> query) {
    return this.dataProvider.browse(query);
  }
}