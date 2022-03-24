

import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/domain/account_repository_contract.dart';
import 'package:finwallet_app/app/account/dto/create_account_dto.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import '../../../common/http_client/pagination.dart';

import '../../../common/contracts.dart';

class ListAccount extends Interactor<Future<Pagination<AccountEntity>>, ListAccountParams> {

  final AccountRepositoryContract accounts;

  ListAccount(this.accounts);

  @override
  Future<Pagination<AccountEntity>> call(ListAccountParams params) {
    try {
      this.validate(params);

      return this.accounts.browse(params.query.getParams());
    } catch (error) {
      rethrow;
    }

  }

  @override
  void validate(ListAccountParams params) {

  }

}

class ListAccountParams extends Params {
  final QueryParams query;

  ListAccountParams({
    required this.query
  });

  @override
  List<Object?> get props => [query];
}