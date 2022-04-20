import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/domain/account_repository_contract.dart';
import 'package:finwallet_app/app/account/dto/create_account_dto.dart';
import 'package:finwallet_app/app/category/data/category_data_provider.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/category/domain/category_repository_contract.dart';
import 'package:finwallet_app/app/transaction/data/transaction_data_provider.dart';
import '../../../common/http_client/pagination.dart';
import '../domain/transaction_entity.dart';
import '../domain/transaction_repository_contract.dart';
import '../dto/create_transaction_dto.dart';


class TransactionRepository implements TransactionRepositoryContract {
  final TransactionDataProvider dataProvider;

  TransactionRepository(this.dataProvider);

  @override
  Future<TransactionEntity> create(Map<String, dynamic> transaction) {
    return this.dataProvider.create(transaction);
  }

  // @override
  // Future<TransactionEntity> find(String id) {
  //   return this.dataProvider.read(id);
  // }
  //
  // @override
  // Future<TransactionEntity> update(TransactionEntity entity) {
  //   return this.dataProvider.update(entity.id, entity.toJson());
  // }

  @override
  Future<Pagination<TransactionEntity>> browse(Map<String, dynamic> query) {
    return this.dataProvider.browse(query);
  }

  @override
  Future<void> remove(TransactionEntity entity) {
    return this.dataProvider.remove(entity.id);
  }
}