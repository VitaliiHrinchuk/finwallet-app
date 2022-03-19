import 'package:finwallet_app/app/user/domain/user_entity.dart';
import 'package:finwallet_app/app/user/domain/user_repository_contract.dart';
import 'package:finwallet_app/common/contracts.dart';

class SetupUser extends Interactor<Future<UserEntity>, SetupUserParams> {

  final UserRepositoryContract users;
  final ValidatorContract validator;

  SetupUser(this.users, this.validator);

  @override
  Future<UserEntity> call(SetupUserParams params) {

    this.users.setup(params.baseCurrency);

    return this.users.iam();
  }

  @override
  void validate(SetupUserParams params) {
    this.validator.setValues({
      "baseCurrency": params.baseCurrency
    });
    this.validator.setRules({
      "baseCurrency": "required|length:3"
    });

    this.validator.validate();
  }

}

class SetupUserParams extends Params {

  final String baseCurrency;

  SetupUserParams({ required this.baseCurrency });

  @override
  List<Object?> get props => [baseCurrency];



}