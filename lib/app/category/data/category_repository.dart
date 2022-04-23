import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/domain/account_repository_contract.dart';
import 'package:finwallet_app/app/account/dto/create_account_dto.dart';
import 'package:finwallet_app/app/category/data/category_data_provider.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/category/domain/category_repository_contract.dart';
import '../../../common/http_client/pagination.dart';
import '../dto/create_category_dto.dart';


class CategoryRepository implements CategoryRepositoryContract {
  final CategoryDataProvider dataProvider;

  CategoryRepository(this.dataProvider);

  @override
  Future<CategoryEntity> create(String name, String type) {
    return this.dataProvider.create({
      "name": name,
      "type": type
    });
  }

  @override
  Future<CategoryEntity> find(String id) {
    return this.dataProvider.read(id);
  }

  @override
  Future<CategoryEntity> update(CategoryEntity entity) {
    return this.dataProvider.update(entity.id, entity.toJson());
  }

  @override
  Future<Pagination<CategoryEntity>> browse(Map<String, dynamic> query) {
    return this.dataProvider.browse(query);
  }
}