import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/domain/account_repository_contract.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/category_node_model.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/currency_node_model.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/date_node_model.dart';
import 'package:finwallet_app/app/account/dto/create_account_dto.dart';
import 'package:finwallet_app/app/account/dto/update_account_dto.dart';
import 'package:finwallet_app/app/account/usecases/update_account.dart';
import '../../../common/http_client/pagination.dart';

import 'account_data_provider.dart';

class AccountRepository implements AccountRepositoryContract {
  final AccountDataProvider dataProvider;

  AccountRepository(this.dataProvider);

  @override
  Future<AccountEntity> create(CreateAccountDto dto) {
    return this.dataProvider.create(dto.toJson());
  }

  @override
  Future<AccountEntity> find(String id) {
    return this.dataProvider.read(id);
  }

  @override
  Future<void> remove(String id) {
    return this.dataProvider.remove(id);
  }

  @override
  Future<AccountEntity> update(UpdateAccountDto dto) {
    print(dto.toJson());
    return this.dataProvider.update(dto.id, dto.toJson());
  }

  @override
  Future<Pagination<AccountEntity>> browse(Map<String, dynamic> query) {
    return this.dataProvider.browse(query);
  }

  @override
  Future<List<CategoryNodeModel>> fetchSummaryByCategory(Map<String, dynamic> query) async {
    Map<String, dynamic> params = {
      ...query,
      'type': 'category'
    };
    Map<String, dynamic> result = await this.dataProvider.fetchAnalytics(params);
    print(result);
    List<dynamic> data = result['data'];
    List<CategoryNodeModel> models = data.map((e) => CategoryNodeModel(
        name: e['name'],
        sum: double.parse(e['sum'].toString()),
        slug: e['slug'])
    ).toList();

    return models;
  }

  @override
  Future<List<CurrencyNodeModel>> fetchSummaryByCurrency(Map<String, dynamic> query) {
    // TODO: implement fetchSummaryByCurrency
    throw UnimplementedError();
  }

  @override
  Future<List<DateNodeModel>> fetchSummaryByDate(Map<String, dynamic> query) async {
      Map<String, dynamic> params = {
        ...query,
        'type': 'date'
      };
      Map<String, dynamic> result = await this.dataProvider.fetchAnalytics(params);

      List<dynamic> data = result['data'];
      List<DateNodeModel> models = data.map((e) => DateNodeModel(
          date: DateTime.parse(e['date']),
          sum: double.parse(e['sum'].toString()))
      ).toList();

      return models;
  }
}