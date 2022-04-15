part of 'account_form_cubit.dart';

class AccountFormState {
  final String? name;
  final double? amount;
  final Currency? currency;
  final Color? color;

  AccountFormState({
    this.name,
    this.amount,
    this.currency,
    this.color,
  });

  AccountFormState copyWith({name, amount, currency, color}) =>
      AccountFormState(
          name: name ?? this.name,
          amount: amount ?? this.amount,
          currency: currency ?? this.currency,
          color: color ?? this.color
      );
}

class AccountFormInitial extends AccountFormState {
  AccountFormInitial() : super();
}
