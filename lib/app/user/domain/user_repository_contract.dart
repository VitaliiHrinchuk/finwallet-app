import 'package:finwallet_app/app/user/domain/user_entity.dart';

abstract class UserRepositoryContract {
  Future<UserEntity> iam();
  Future<UserEntity> setup(String baseCurrency);
}