import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/domain/account_repository_contract.dart';
import 'package:finwallet_app/app/account/dto/create_account_dto.dart';

import 'account_data_provider.dart';

class AccountRepository implements AccountRepositoryContract {
  final AccountDataProvider dataProvider;

  AccountRepository(this.dataProvider);

  @override
  Future<AccountEntity> create(CreateAccountDto dto) {
    return this.dataProvider.create(dto.toJson());
  }

  @override
  Future<AccountEntity> find(String id) {
    return this.dataProvider.read(id);
  }

  @override
  Future<AccountEntity> update(AccountEntity entity) {
    return this.dataProvider.update(entity.id, entity.toJson());
  }
}