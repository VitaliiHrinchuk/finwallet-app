import 'package:finwallet_app/app/user/domain/user_entity.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/http_client/http_client.dart';

class UserDataProvider extends AbstractHttpDataProvider {
  @override
  String path = 'user';

  UserDataProvider(HttpClient client) : super(client: client);

  Future<UserEntity> iam() async {
    Uri uri = this.generateUri(path: this.path + '/iam');
    
    Map<String, dynamic> result = await this.client.get(uri);

    return this.fromJSON(result);
  }

  Future<UserEntity> setup(String baseCurrency) async {
    Uri uri = this.generateUri(path: this.path + '/setup');
    Map<String, dynamic> body = {};
    body['baseCurrency'] = baseCurrency;

    Map<String, dynamic> result = await this.client.post(uri, body: body);

    return this.fromJSON(result);
  }


  @override
  fromJSON(Map<String, dynamic> json) {
    return UserEntity.fromJSON(json);
  }
}