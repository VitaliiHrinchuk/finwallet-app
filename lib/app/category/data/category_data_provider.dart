import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/http_client/http_client.dart';

class CategoryDataProvider extends AbstractHttpDataProvider<CategoryEntity> {
  @override
  String path = 'category';

  CategoryDataProvider(HttpClient client) : super(client: client);

  @override
  fromJSON(Map<String, dynamic> json) {
    return CategoryEntity.fromJSON(json);
  }


}