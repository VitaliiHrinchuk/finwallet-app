

import 'package:finwallet_app/app/auth/domain/auth_repository_contract.dart';
import 'package:finwallet_app/app/auth/domain/credentials.dart';
import 'package:finwallet_app/app/user/domain/user_entity.dart';
import 'package:finwallet_app/app/user/domain/user_repository_contract.dart';
import 'package:finwallet_app/common/contracts.dart';

class SignupUser implements Interactor<Future<UserEntity>, SignupUserParams> {
  final AuthRepositoryContract auth;
  final UserRepositoryContract users;
  final ValidatorContract validator;

  SignupUser(this.auth, this.users, this.validator);

  @override
  Future<UserEntity> call(SignupUserParams params) async {
    this.validate(params);

    try {
      await this.auth.singUpWithCredentials(Credentials(params.email, params.password));
      await this.auth.singInWithCredentials(Credentials(params.email, params.password));
      UserEntity user = await this.users.iam();
      return user;
    }  catch (error) {
      // print(error);
      rethrow;
    }
  }

  @override
  void validate(SignupUserParams params) {
    this.validator.setValues({
      "email": params.email,
      "password": params.password,
      "confirmPassword": params.confirmPassword
    });
    this.validator.setRules({
      "email": "required|email",
      "password": "required",
      "confirmPassword": "required|shouldMatch:${params.password}:password",
    });
    this.validator.validate();
  }
}

class SignupUserParams implements Params {
  final String email;
  final String password;
  final String confirmPassword;

  SignupUserParams({ required this.email, required this.password, required this.confirmPassword });

  @override
  List<Object> get props => [email, password, confirmPassword];

  @override
  bool? get stringify => true;
}
