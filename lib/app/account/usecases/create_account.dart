

import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/domain/account_repository_contract.dart';
import 'package:finwallet_app/app/account/dto/create_account_dto.dart';

import '../../../common/contracts.dart';

class CreateAccount extends Interactor<Future<AccountEntity>, CreateAccountParams> {

  final AccountRepositoryContract accounts;
  final ValidatorContract validator;

  CreateAccount(this.accounts, this.validator);

  @override
  Future<AccountEntity> call(CreateAccountParams params) {
    try {
      this.validate(params);

      return this.accounts.create(params.dto);
    } catch (error) {
      rethrow;
    }

  }

  @override
  void validate(CreateAccountParams params) {
    this.validator.setValues({
      "name": params.dto.name,
      "currency": params.dto.currency,
      "amount": params.dto.amount.toString(),
      "hexColor": params.dto.hexColor,
    });
    this.validator.setRules({
      "name": "required",
      "currency": "required|length:3",
      "amount": "required",
    });

    if (params.dto.hexColor != null) {
      this.validator.addRule("hexColor", "length:6");
    }

    this.validator.validate();
  }

}

class CreateAccountParams extends Params {

  final CreateAccountDto dto;

  CreateAccountParams({ required this.dto });

  @override
  List<Object?> get props => [dto];



}