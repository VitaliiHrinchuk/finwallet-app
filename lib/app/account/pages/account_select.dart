import 'package:finwallet_app/app/account/bloc/account/account_bloc.dart';
import 'package:finwallet_app/app/account/cubit/list/accounts_list_cubit.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/pages/widgets/account_list_item.dart';
import 'package:finwallet_app/common/widgets/app_bar/main_app_bar.dart';
import 'package:finwallet_app/common/widgets/drawer/drawer_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MainDrawer(),
      appBar: MainAppBar(
        title: 'Select Account',
        canGoBack: true,
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
          child: BlocBuilder<AccountsListCubit, AccountsListState>(
            builder: (context, state) {
              print(state);
              if (state.loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: state.entities.length,
                itemBuilder: (context, i) {
                  AccountEntity entity = state.entities[i];
                  return AccountListItem(
                    name: entity.name,
                    amount: entity.amount,
                    currency: entity.currency,
                    onTap: () {
                      Navigator.pop(context, entity.id);
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
          )
      ),
    );
  }
}
