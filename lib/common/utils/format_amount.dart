import 'package:finwallet_app/common/constants/currencies.dart';

String formatAmount(double amount, Currency currency) {
  return amount.toStringAsFixed(2) + " " + currency.code;
}