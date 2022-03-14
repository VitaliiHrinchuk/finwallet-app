

import 'package:finwallet_app/app/auth/domain/auth_repository_contract.dart';
import 'package:finwallet_app/app/auth/domain/credentials.dart';
import 'package:finwallet_app/common/contracts.dart';

class SignupUser implements Interactor<Future<bool>, SignupUserParams> {
  final AuthRepositoryContract auth;
  final ValidatorContract validator;

  SignupUser(this.auth, this.validator);

  @override
  Future<bool> call(SignupUserParams params) async {
    this.validate(params);

    try {
      await this.auth.singUpWithCredentials(Credentials(params.email, params.password));
      return true;
    }  catch (error) {
      print(error);
      throw error;
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
