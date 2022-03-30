import 'package:finwallet_app/app/account/bloc/account/account_bloc.dart';
import 'package:finwallet_app/app/account/pages/widgets/accounts_horizontal_list.dart';
import 'package:finwallet_app/app/account/pages/widgets/transactions_by_category_chart.dart';
import 'package:finwallet_app/app/account/pages/widgets/transactions_by_range_chart.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:finwallet_app/common/dependencies.dart';
import '../../../common/widgets/drawer/drawer_nav.dart';
import '../../../common/widgets/app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/section_container.dart';

class AccountsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: MainDrawer(),
      appBar: MainAppBar(
        title: "Home",
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => di<AccountBloc>()..add(AccountFetch()),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                SectionContainer(
                  title: "List of Accounts",
                  leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(ACCOUNTS_LIST_ROUTE);
                      },
                      icon: Icon(
                        Icons.settings,

                      )
                  ),
                  child: Container(
                      height: 120,
                      child: AccountsHorizontalList()
                  ),
                ),
                SectionContainer(
                    child: TransactionsByRangeChart(),
                    title: "Spending this month"
                ),
                SectionContainer(
                    child: TransactionsByCategoryChart(),
                    title: "Spending this month"
                )


              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(TRANSACTION_ADD_ROUTE);
        },
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
