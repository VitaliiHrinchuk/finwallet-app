import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/domain/account_repository_contract.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/category_node_model.dart';
import 'package:finwallet_app/app/account/dto/create_account_dto.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import '../../../common/http_client/pagination.dart';

import '../../../common/contracts.dart';
import '../domain/analytics_models/date_node_model.dart';

class FetchSummaryByDate extends Interactor<Future<List<DateNodeModel>>, QueryParams> {

  final AccountRepositoryContract accounts;

  FetchSummaryByDate(this.accounts);

  @override
  Future<List<DateNodeModel>> call(QueryParams params) {
    try {
      this.validate(params);
      return this.accounts.fetchSummaryByDate(params.getParams());
    } catch (error) {
      print(error);
      rethrow;
    }

  }

  @override
  void validate(QueryParams params) {

  }

}
