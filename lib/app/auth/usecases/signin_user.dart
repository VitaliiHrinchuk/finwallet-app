

import 'package:finwallet_app/app/auth/domain/auth_repository_contract.dart';
import 'package:finwallet_app/app/auth/domain/credentials.dart';
import 'package:finwallet_app/common/contracts.dart';

class SigninUser implements Interactor<Future<String>, SigninUserParams> {
  final AuthRepositoryContract auth;
  final ValidatorContract validator;

  SigninUser(this.auth, this.validator);

  @override
  Future<String> call(SigninUserParams params) async {
    this.validate(params);
    String token = await this.auth.singInWithCredentials(Credentials(params.email, params.password));

    return token;
  }

  @override
  void validate(SigninUserParams params) {
    this.validator.setValues({"email": params.email, "password": params.password});
    this.validator.setRules({"email": "required|email", "password": "required"});
    this.validator.validate();
  }
}

class SigninUserParams implements Params {
  final String email;
  final String password;

  SigninUserParams({ required this.email, required this.password });

  @override
  List<Object> get props => [email, password];

  @override
  bool? get stringify => true;
}
