import 'package:bloc/bloc.dart';
import 'package:finwallet_app/common/constants/currencies.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'account_form_state.dart';

class AccountFormCubit extends Cubit<AccountFormState> {
  AccountFormCubit() : super(AccountFormInitial());

  void setName(String? name){
    emit(state.copyWith(name: name));
  }

  void setAmount(double? amount){
    emit(state.copyWith(amount: amount));
  }

  void setCurrency(Currency? currency){
    emit(state.copyWith(currency: currency));
  }

  void setHexColor(Color? color){
    emit(state.copyWith(color: color));
  }

}
