import 'package:finwallet_app/app/user/domain/user_entity.dart';
import 'package:finwallet_app/app/user/domain/user_repository_contract.dart';
import 'package:finwallet_app/common/contracts.dart';

class FetchUser extends Interactor<Future<UserEntity>, EmptyParams> {

  final UserRepositoryContract users;

  FetchUser(this.users);

  @override
  Future<UserEntity> call(EmptyParams params) {
    return this.users.iam();
  }

  @override
  void validate(EmptyParams params) {
    // TODO: implement validate
  }

}