import 'package:finwallet_app/app/account/cubit/list/accounts_list_cubit.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/pages/widgets/create_account_form.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:finwallet_app/common/utils/snackbar.dart';
import '../../../common/widgets/layout/content_container.dart';
import '../../../common/widgets/drawer/drawer_nav.dart';
import '../../../common/widgets/app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/account/account_bloc.dart';

class AccountEdit extends StatelessWidget {
  final AccountEntity? entity;
  final AccountBloc _accountBLoc =  di<AccountBloc>();

  bool get isEdit => this.entity != null;

  AccountEdit({
    this.entity
  });

  @override
  Widget build(BuildContext context) {
    Widget removeBtn = this.isEdit
        ? IconButton(
              onPressed: () => this._showDeleteModal(context, this.entity!.id),
              icon: Icon(Icons.delete)
          )
        : Container();

    return BlocProvider(
      create: (_) => _accountBLoc,
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: MainAppBar(
            title: this.isEdit ? 'Edit Account' : 'Create An Account',
            actions: [
              removeBtn
            ],
            canGoBack: true
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            child: ContentContainer(
              child: BlocListener<AccountBloc, AccountState>(
                listener: (context, state) {
                  if (state is AccountError) {
                    showFloatSnackBar(context, state.error ?? "Unknown error");
                  } else if (state is AccountLoaded || state is AccountRemoved) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(HOME_ROUTE, (Route<dynamic> route) => false);
                    BlocProvider.of<AccountsListCubit>(context).loadAccounts();
                  }
                },
                child: CreateAccountForm(
                  amount: entity?.amount,
                  currency: entity?.currency,
                  name: entity?.name,
                  hexColor: entity?.hexColor,
                  isEdit: isEdit,
                  id: entity?.id
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteModal(context, String id) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Account'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are you sure you want to remove this account?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Submit'),
              onPressed: () {
                _accountBLoc.add(AccountRemove(id: id));
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}


