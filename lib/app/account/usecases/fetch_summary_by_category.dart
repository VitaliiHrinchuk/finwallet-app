import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/domain/account_repository_contract.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/category_node_model.dart';
import 'package:finwallet_app/app/account/dto/create_account_dto.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import '../../../common/http_client/pagination.dart';

import '../../../common/contracts.dart';

class FetchSummaryByCategory extends Interactor<Future<List<CategoryNodeModel>>, QueryParams> {

  final AccountRepositoryContract accounts;

  FetchSummaryByCategory(this.accounts);

  @override
  Future<List<CategoryNodeModel>> call(QueryParams params) {
    try {
      this.validate(params);
      return this.accounts.fetchSummaryByCategory(params.getParams());
    } catch (error) {
      print(error);
      rethrow;
    }

  }

  @override
  void validate(QueryParams params) {

  }

}
