import 'package:finwallet_app/app/account/cubit/list/accounts_list_cubit.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/pages/account_edit.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/widgets/drawer/drawer_nav.dart';
import '../../../common/widgets/app_bar/main_app_bar.dart';
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
          child: BlocBuilder<AccountsListCubit, AccountsListState>(
            builder: (context, state) {

              return ListView.builder(
                itemCount: state.entities.length,
                itemBuilder: (context, i) {
                  AccountEntity entity = state.entities[i];

                  return AccountListItem(
                    name: entity.name,
                    amount: entity.amount,
                    currency: entity.currency.code,
                    hexColor: entity.hexColor,
                    onTap: () {
                      // Navigator.of(context).pushNamed(ACCOUNTS_EDIT_ROUTE, arguments: AccountEditScreenArguments(id: '1'));
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (childContext) {
                          return AccountEdit(entity: entity);
                        }),
                      );
                    },
                  );
                  // return ListTile(
                  //   title: Text(entity.name),
                  //   subtitle: Text(entity.amount.toStringAsFixed(2) + " " + entity.currency),
                  //   onTap: () {
                  //     Navigator.pop(context, entity.id);
                  //   },
                  // );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).pushNamed(ACCOUNTS_CREATE_ROUTE);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (childContext) {
              return AccountEdit();
            }),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
      ),
    );
  }
}
