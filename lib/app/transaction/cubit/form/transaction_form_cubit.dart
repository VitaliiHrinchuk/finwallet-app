import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/common/constants/currencies.dart';
import 'package:meta/meta.dart';

part 'transaction_form_state.dart';

class TransactionFormCubit extends Cubit<TransactionFormState> {
  TransactionFormCubit() : super(TransactionFormInitial());


  void init(Currency currency) {
    print("=== init");
    emit(state.copyWith(currency: currency));
  }

  void setCurrency(Currency currency) {
    emit(state.copyWith(currency: currency));
  }

  void setAccount(AccountEntity account) {
    emit(state.copyWith(account: account));
  }

  void setCategory(CategoryEntity category) {
    emit(state.copyWith(category: category));
  }

  void setType(TransactionType type) {
    emit(state.copyWith(type: type));
  }

  void setDate(DateTime date) {
    emit(state.copyWith(transactionDate: date));
  }
}
