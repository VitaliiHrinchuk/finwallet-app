import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/common/constants/currencies.dart';

class CreateTransactionDto {
  final AccountEntity account;
  final TransactionType type;
  final CategoryEntity category;
  final double amount;
  final String? note;
  final Currency currency;

  CreateTransactionDto({
    required this.account,
    required this.type,
    required this.category,
    required this.amount,
    required this.currency,
    this.note
  });

}