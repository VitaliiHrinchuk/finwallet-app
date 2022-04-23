import 'dart:io';

import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/category/domain/category_repository_contract.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_repository_contract.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/utils/enum_to_string.dart';


class ImportTransactions extends Interactor<Future<void>, ImportTransactionsParams> {

  final TransactionRepositoryContract transactions;

  ImportTransactions(this.transactions);

  @override
  Future<void> call(ImportTransactionsParams params) {
    try {
      this.validate(params);
      return this.transactions.import(
          params.account.id,
          enumToShortString(params.type.toString()),
          params.file
      );
    } catch (error) {
      print(error);
      rethrow;
    }

  }

  @override
  void validate(ImportTransactionsParams params) {

  }

}

class ImportTransactionsParams extends Params {

  final File file;
  final AccountEntity account;
  final TransactionType type;

  ImportTransactionsParams({
    required this.file,
    required this.account,
    required this.type
  });

  @override
  List<Object?> get props => [file];
}