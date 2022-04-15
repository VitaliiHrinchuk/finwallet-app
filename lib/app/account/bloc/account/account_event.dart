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

class AccountUpdate extends AccountEvent {
  final String? name;
  final String id;
  final String? hexColor;

  AccountUpdate({
    this.name,
    required this.id,
    this.hexColor
  });
}

class AccountRemove extends AccountEvent {
  final String id;

  AccountRemove({
    required this.id,
  });
}


class AccountFetch extends AccountEvent {}