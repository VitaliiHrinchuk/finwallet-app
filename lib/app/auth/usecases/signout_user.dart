

import 'package:finwallet_app/app/auth/domain/auth_repository_contract.dart';
import 'package:finwallet_app/common/contracts.dart';

class SignoutUser implements Interactor<Future<void>, EmptyParams> {
  final AuthRepositoryContract auth;

  SignoutUser(this.auth);

  @override
  Future<void> call(EmptyParams params) async {
    return await this.auth.singOut();
  }

  @override
  void validate(EmptyParams params) {
    throw UnimplementedError();
  }
}
