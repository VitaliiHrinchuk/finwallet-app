import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/tag/domain/tag_entity.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/app/transaction/dto/create_transaction_dto.dart';
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

  void setAmount(double amount) {
    emit(state.copyWith(amount: amount));
  }

  void setTags(List<TagEntity> tags) {
    emit(state.copyWith(tags: tags));
  }
  
  CreateTransactionDto? toDTO() {
    if(state.account == null) {
      emit(state.copyWith(error: "Please select account"));
      return null;
    } else if (state.category == null ) {
      emit(state.copyWith(error: "Please select category"));
      return null;
    } else {
      return CreateTransactionDto(
          account: state.account!,
          type: state.type,
          category: state.category!,
          amount: state.amount,
          currency: state.currency,
          tags: state.tags
      );
    }

  }
}
