part of 'account_bloc.dart';

@immutable
abstract class AccountEvent {}

class AccountCreate extends AccountEvent {
  final double? amount;
  final String? currency;
  final String? name;
  final String? hexColor;

  AccountCreate({
    this.amount,
    this.name,
    this.currency,
    this.hexColor
  });
}


class AccountFetch extends AccountEvent {}