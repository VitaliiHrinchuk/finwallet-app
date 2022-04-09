import 'package:finwallet_app/app/tag/domain/tag_entity.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/http_client/http_client.dart';

class TagDataProvider extends AbstractHttpDataProvider<TagEntity> {
  @override
  String path = 'tag';

  TagDataProvider(HttpClient client) : super(client: client);

  @override
  fromJSON(Map<String, dynamic> json) {
    return TagEntity.fromJSON(json);
  }


}