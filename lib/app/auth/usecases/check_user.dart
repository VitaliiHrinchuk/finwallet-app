

import 'package:finwallet_app/app/auth/domain/auth_repository_contract.dart';
import 'package:finwallet_app/app/auth/domain/auth_user_entity.dart';
import 'package:finwallet_app/common/contracts.dart';

class CheckUser implements Interactor<Future<bool>, EmptyParams> {
  final AuthRepositoryContract auth;

  CheckUser(this.auth);

  @override
  Future<bool> call(EmptyParams params) {
    return this.auth.check();
  }

  @override
  void validate(EmptyParams params) {
    throw UnimplementedError();
  }
}
