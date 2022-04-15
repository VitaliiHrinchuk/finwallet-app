import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/category_node_model.dart';
import 'package:finwallet_app/app/account/dto/update_account_dto.dart';
import '../../../common/http_client/pagination.dart';

import '../dto/create_account_dto.dart';
import 'analytics_models/currency_node_model.dart';
import 'analytics_models/date_node_model.dart';

abstract class AccountRepositoryContract {
  Future<AccountEntity> find(String id);
  Future<void> remove(String id);
  Future<AccountEntity> update(UpdateAccountDto dto);
  Future<AccountEntity> create(CreateAccountDto dto);
  Future<Pagination<AccountEntity>> browse(Map<String, dynamic> query);
  Future<List<CategoryNodeModel>> fetchSummaryByCategory(Map<String, dynamic> query);
  Future<List<DateNodeModel>> fetchSummaryByDate(Map<String, dynamic> query);
  Future<List<CurrencyNodeModel>> fetchSummaryByCurrency(Map<String, dynamic> query);
}