import 'package:finwallet_app/app/account/pages/account_edit.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:flutter/material.dart';

class AccountListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Account"),
      subtitle: Text("30 USD"),
      onTap: () {
        Navigator.of(context).pushNamed(ACCOUNTS_EDIT_ROUTE, arguments: AccountEditScreenArguments(id: '1'));
      },
    );
  }
}
