part of 'account_form_cubit.dart';

class AccountFormState {
  final String? name;
  final double? amount;
  final Currency? currency;
  final String? hexColor;

  AccountFormState({
    this.name,
    this.amount,
    this.currency,
    this.hexColor,
  });

  AccountFormState copyWith({name, amount, currency, hexColor}) =>
      AccountFormState(
          name: name ?? this.name,
          amount: amount ?? this.amount,
          currency: currency ?? this.currency,
          hexColor: hexColor ?? this.hexColor
      );
}

class AccountFormInitial extends AccountFormState {
  AccountFormInitial() : super();
}
