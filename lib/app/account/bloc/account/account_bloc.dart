import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/account/dto/create_account_dto.dart';
import 'package:finwallet_app/app/account/usecases/create_account.dart';
import 'package:finwallet_app/app/account/usecases/list_account.dart';
import 'package:finwallet_app/common/http_client/exceptions.dart';
import 'package:finwallet_app/common/http_client/pagination.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import 'package:meta/meta.dart';

import '../../../../common/error/exceptions.dart';
import '../../domain/account_entity.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final CreateAccount createAccount;
  final ListAccount listAccount;

  AccountBloc(this.createAccount, this.listAccount) : super(AccountInitial()) {
    on<AccountCreate>(_onCreateAccount);
    on<AccountFetch>(_onFetchAccount);
  }


  void _onCreateAccount(AccountCreate event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    try {
      AccountEntity account = await this.createAccount(
          CreateAccountParams(dto: CreateAccountDto(
            name: event.name,
            currency: event.currency,
            amount: event.amount,
            hexColor: event.hexColor
          ))
      );
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

  void _onFetchAccount(AccountFetch event, Emitter<AccountState> emit) async {
    emit(AccountLoading());
    try {

      Pagination<AccountEntity> pagination = await this.listAccount(
          ListAccountParams(query: new QueryParams({}))
      );
      print("fetched");
      print(pagination.data);
      emit(AccountFetched(accounts: pagination.data));
    }  on HttpException catch (error) {
      emit(AccountError(error: error.message));
    } catch (error) {
      print(error);
      emit(AccountError(error: error.toString()));
    }
  }
}
