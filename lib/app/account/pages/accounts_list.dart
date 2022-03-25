import 'package:finwallet_app/app/account/pages/account_edit.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:finwallet_app/common/widgets/drawer_nav.dart';
import 'package:finwallet_app/common/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';

import 'widgets/account_list_item.dart';

class AccountsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: MainAppBar(
          title: 'Accounts',
          canGoBack: true
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: ListView(
            children: ListTile.divideTiles(context: context,
              tiles: [
                AccountListItem(),
                AccountListItem()
              ]
            ).toList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(ACCOUNTS_CREATE_ROUTE);
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
