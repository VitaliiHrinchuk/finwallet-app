import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/http_client/http_client.dart';

import '../domain/account_entity.dart';

class AccountDataProvider extends AbstractHttpDataProvider<AccountEntity> {
  @override
  String path = 'accounts';

  AccountDataProvider(HttpClient client) : super(client: client);

  @override
  fromJSON(Map<String, dynamic> json) {
    return AccountEntity.fromJSON(json);
  }

  Future<Map<String, dynamic>> fetchAnalytics(Map<String, dynamic> params) async {
    Uri uri = this.generateUri(path: this.path + '/analytics', query: params);

    Map<String, dynamic> result = await this.client.get(uri);

    return result;
  }

}