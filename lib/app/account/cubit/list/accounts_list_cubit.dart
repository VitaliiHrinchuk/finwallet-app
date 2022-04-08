import 'package:bloc/bloc.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/usecases/list_account.dart';
import 'package:finwallet_app/common/http_client/pagination.dart';
import 'package:finwallet_app/common/http_client/query_params.dart';
import 'package:meta/meta.dart';

import '../../../../common/http_client/exceptions.dart';

part 'accounts_list_state.dart';

class AccountsListCubit extends Cubit<AccountsListState> {
  final ListAccount _listAccount;

  AccountsListCubit(this._listAccount) : super(AccountsListInitial());

  void loadAccounts() async {
    try {
      emit(state.copyWith(loading: true));
      Pagination<AccountEntity> result = await this._listAccount(ListAccountParams(query: QueryParams({})));
      emit(state.copyWith(loading: false, entities: result.data, loaded: true));
    } on HttpException catch (error) {
      emit(state.copyWith(loading: false, error: error));
    } catch (error) {
      emit(state.copyWith(loading: false, error: error.toString()));
    }
  }
}
