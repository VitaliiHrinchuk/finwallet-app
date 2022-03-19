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


}