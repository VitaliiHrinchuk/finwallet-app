import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/app/transaction/dto/create_transaction_dto.dart';
import '../../../common/http_client/pagination.dart';



abstract class TransactionRepositoryContract {
  Future<void> remove(TransactionEntity entity);
  Future<TransactionEntity> create(Map<String, dynamic> transaction);
  Future<Pagination<TransactionEntity>> browse(Map<String, dynamic> query);
}