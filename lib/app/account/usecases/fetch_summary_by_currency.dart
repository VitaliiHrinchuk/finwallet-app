import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/domain/account_repository_contract.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/category_node_model.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/currency_node_model.dart';
import 'package:finwallet_app/app/account/dto/create_account_dto.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import '../../../common/http_client/pagination.dart';

import '../../../common/contracts.dart';

class FetchSummaryByCurrency extends Interactor<Future<List<CurrencyNodeModel>>, QueryParams> {

  final AccountRepositoryContract accounts;

  FetchSummaryByCurrency(this.accounts);

  @override
  Future<List<CurrencyNodeModel>> call(QueryParams params) {
    try {
      this.validate(params);
      return this.accounts.fetchSummaryByCurrency(params.getParams());
    } catch (error) {
      print(error);
      rethrow;
    }

  }

  @override
  void validate(QueryParams params) {

  }

}
