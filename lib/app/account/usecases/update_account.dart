

import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/domain/account_repository_contract.dart';
import 'package:finwallet_app/app/account/dto/create_account_dto.dart';
import 'package:finwallet_app/app/account/dto/update_account_dto.dart';

import '../../../common/contracts.dart';

class UpdateAccount extends Interactor<Future<AccountEntity>, UpdateAccountParams> {

  final AccountRepositoryContract accounts;
  final ValidatorContract validator;

  UpdateAccount(this.accounts, this.validator);

  @override
  Future<AccountEntity> call(UpdateAccountParams params) {
    try {
      this.validate(params);

      return this.accounts.update(params.dto);
    } catch (error) {
      rethrow;
    }

  }

  @override
  void validate(UpdateAccountParams params) {
    this.validator.setValues({
      "name": params.dto.name,
      "hexColor": params.dto.hexColor,
    });
    this.validator.setRules({
      "name": "required",
    });

    // if (params.dto.hexColor != null) {
    //   this.validator.addRule("hexColor", "length:6");
    // }

    this.validator.validate();
  }

}

class UpdateAccountParams extends Params {

  final UpdateAccountDto dto;

  UpdateAccountParams({ required this.dto });

  @override
  List<Object?> get props => [dto];



}