part of 'transaction_form_cubit.dart';

class TransactionFormState {
  final double amount;
  final AccountEntity? account;
  final CategoryEntity? category;

  //final TagsEntity[]
  final DateTime transactionDate;
  final Currency currency;
  final TransactionType type;

  TransactionFormState({
      required this.amount,
      this.account,
      required this.transactionDate,
      required this.currency,
      this.category,
      required this.type
  });

  TransactionFormState copyWith({amount, account, transactionDate, currency, category, type}) =>
      TransactionFormState(
          amount: amount ?? this.amount,
          account: account ?? this.account,
          transactionDate: transactionDate ?? this.transactionDate,
          currency: currency ?? this.currency,
          category: category ?? this.category,
          type: type ?? this.type);
}

class TransactionFormInitial extends TransactionFormState {
  TransactionFormInitial()
      : super(
            amount: 0,
            transactionDate: DateTime.now(),
            currency: Currency(code: "USD", name: "United States Dollar"),
            type: TransactionType.CRE
  );
}
