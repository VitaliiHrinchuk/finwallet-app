

import 'package:finwallet_app/app/auth/domain/auth_repository_contract.dart';
import 'package:finwallet_app/app/auth/domain/auth_user_entity.dart';
import 'package:finwallet_app/app/user/domain/user_entity.dart';
import 'package:finwallet_app/app/user/domain/user_repository_contract.dart';
import 'package:finwallet_app/common/contracts.dart';

class CheckUser implements Interactor<Future<UserEntity?>, EmptyParams> {
  final AuthRepositoryContract auth;
  final UserRepositoryContract users;

  CheckUser(this.auth, this.users);

  @override
  Future<UserEntity?> call(EmptyParams params) async {
    bool authenticated = await this.auth.check();

    if (authenticated) {
      UserEntity user = await this.users.iam();
      return user;
    } else {
      return null;
    }
  }

  @override
  void validate(EmptyParams params) {
    throw UnimplementedError();
  }
}
