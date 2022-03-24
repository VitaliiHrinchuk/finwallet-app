import 'package:finwallet_app/app/account/domain/account_entity.dart';
import '../../../common/http_client/pagination.dart';

import '../dto/create_account_dto.dart';

abstract class AccountRepositoryContract {
  Future<AccountEntity> find(String id);
  Future<AccountEntity> update(AccountEntity entity);
  Future<AccountEntity> create(CreateAccountDto dto);
  Future<Pagination<AccountEntity>> browse(Map<String, dynamic> query);
}