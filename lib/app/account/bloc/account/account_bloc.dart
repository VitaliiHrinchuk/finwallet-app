import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/account/dto/create_account_dto.dart';
import 'package:finwallet_app/app/account/usecases/create_account.dart';
import 'package:finwallet_app/common/http_client/exceptions.dart';
import 'package:meta/meta.dart';

import '../../../../common/error/exceptions.dart';
import '../../domain/account_entity.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final CreateAccount createAccount;

  AccountBloc(this.createAccount) : super(AccountInitial()) {
    on<AccountCreate>(_onCreateAccount);
  }


  void _onCreateAccount(AccountCreate event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    try {
      print('hex ${event.hexColor}');
      AccountEntity account = await this.createAccount(
          CreateAccountParams(dto: CreateAccountDto(
            name: event.name,
            currency: event.currency,
            amount: event.amount,
            hexColor: event.hexColor
          ))
      );
      print("acc");
      emit(AccountLoaded(account));
    } on ValidationException catch (error) {
      emit(AccountValidationError(errors: error.messages));
    } on HttpException catch (error) {
      emit(AccountError(error: error.message));
    } catch (error) {
      print(error);
      emit(AccountError(error: error.toString()));
    }
  }
}
