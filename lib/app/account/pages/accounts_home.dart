import 'package:finwallet_app/app/account/bloc/account/account_bloc.dart';
import 'package:finwallet_app/app/account/pages/widgets/accounts_horizontal_list.dart';
import 'package:finwallet_app/app/account/pages/widgets/transactions_by_category_chart.dart';
import 'package:finwallet_app/app/account/pages/widgets/transactions_by_range_chart.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:finwallet_app/common/widgets/drawer_nav.dart';
import 'package:finwallet_app/common/widgets/main_app_bar.dart';
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
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
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

                // Container(
                //
                //   padding: EdgeInsets.only(left: 10, right: 10),
                //   decoration: BoxDecoration(
                //       color: Colors.white,
                //     borderRadius: BorderRadius.circular(15)
                //   ),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Text(
                //             "Accounts",
                //             style: Theme.of(context).textTheme.titleMedium,
                //           ),
                //           IconButton(
                //               onPressed: () {},
                //               icon: Icon(
                //                 Icons.settings,
                //               )
                //           )
                //         ],
                //       ),
                //       SizedBox(height: 10,),
                //       Container(
                //           height: 140,
                //           child: AccountsHorizontalList()
                //       )
                //     ],
                //   ),
                // )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
