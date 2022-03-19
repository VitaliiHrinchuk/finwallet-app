import 'package:finwallet_app/app/user/data/user_data_provider.dart';
import 'package:finwallet_app/app/user/domain/user_entity.dart';
import 'package:finwallet_app/app/user/domain/user_repository_contract.dart';

class UserRepository implements UserRepositoryContract {
  final UserDataProvider provider;

  UserRepository(this.provider);

  @override
  Future<UserEntity> iam() {
    return this.provider.iam();
  }

  @override
  Future<UserEntity> setup(String baseCurrency) {
    return this.provider.setup(baseCurrency);
  }
}