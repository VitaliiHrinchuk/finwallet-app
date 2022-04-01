import 'package:finwallet_app/app/category/domain/category_entity.dart';

import '../../../common/http_client/pagination.dart';
import '../dto/create_category_dto.dart';


abstract class CategoryRepositoryContract {
  Future<CategoryEntity> find(String id);
  Future<CategoryEntity> update(CategoryEntity entity);
  Future<CategoryEntity> create(CreateCategoryDto dto);
  Future<Pagination<CategoryEntity>> browse(Map<String, dynamic> query);
}