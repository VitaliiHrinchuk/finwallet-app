

import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/domain/account_repository_contract.dart';
import 'package:finwallet_app/app/account/dto/create_account_dto.dart';
import 'package:finwallet_app/app/account/dto/update_account_dto.dart';

import '../../../common/contracts.dart';

class RemoveAccount extends Interactor<Future<void>, RemoveAccountParams> {

  final AccountRepositoryContract accounts;
  final ValidatorContract validator;

  RemoveAccount(this.accounts, this.validator);

  @override
  Future<void> call(RemoveAccountParams params) {
    try {
      this.validate(params);

      return this.accounts.remove(params.id);
    } catch (error) {
      rethrow;
    }

  }

  @override
  void validate(RemoveAccountParams params) {
    this.validator.setValues({
      "id": params.id,
    });
    this.validator.setRules({
      "id": "required",
    });


    this.validator.validate();
  }

}

class RemoveAccountParams extends Params {

  final String id;

  RemoveAccountParams({ required this.id });

  @override
  List<Object?> get props => [id];



}