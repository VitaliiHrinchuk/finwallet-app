import 'package:finwallet_app/app/category/domain/category_repository_contract.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_repository_contract.dart';
import 'package:finwallet_app/app/transaction/dto/create_transaction_dto.dart';
import 'package:finwallet_app/common/contracts.dart';
import 'package:finwallet_app/common/http_client/pagination.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import 'package:finwallet_app/common/utils/enum_to_string.dart';

import '../domain/transaction_entity.dart';

class CreateTransaction extends Interactor<Future<TransactionEntity>, CreateTransactionParams> {

  final TransactionRepositoryContract transactions;

  CreateTransaction(this.transactions);

  @override
  Future<TransactionEntity> call(CreateTransactionParams params) {
    try {
      this.validate(params);
      print("tags");
      print(params.dto.tags.map((e) => e.slug).toList());
      return this.transactions.create({
        "categorySlug": params.dto.category.slug,
        "accountId": params.dto.account.id,
        "type": enumToShortString(params.dto.type.toString()),
        "amount": params.dto.amount,
        "currency": params.dto.currency.code,
        "note": params.dto.note,
        "tags": params.dto.tags.map((e) => e.slug).toList()
      });
    } catch (error) {
      print(error);
      rethrow;
    }

  }

  @override
  void validate(CreateTransactionParams params) {

  }

}

class CreateTransactionParams extends Params {
  final CreateTransactionDto dto;

  CreateTransactionParams({
    required this.dto
  });

  @override
  List<Object?> get props => [dto];
}