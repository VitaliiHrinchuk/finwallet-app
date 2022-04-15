import 'package:finwallet_app/app/account/bloc/account/account_bloc.dart';
import 'package:finwallet_app/app/account/cubit/analytics/analytics_cubit.dart';
import 'package:finwallet_app/app/account/cubit/list/accounts_list_cubit.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/category_node_model.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/date_node_model.dart';
import 'package:finwallet_app/app/account/pages/accounts_list.dart';
import 'package:finwallet_app/app/account/pages/widgets/accounts_horizontal_list.dart';
import 'package:finwallet_app/app/account/pages/widgets/app_bar/account_app_bar.dart';
import 'package:finwallet_app/app/account/pages/widgets/transactions_by_category_chart.dart';
import 'package:finwallet_app/app/account/pages/widgets/transactions_by_range_chart.dart';
import 'package:finwallet_app/app/transaction/pages/add_transaction.dart';
import 'package:finwallet_app/app/transaction/pages/list_transactions.dart';
import 'package:finwallet_app/common/constants/colors.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:finwallet_app/common/widgets/loading_spinner.dart';
import '../../../common/widgets/drawer/drawer_nav.dart';
import '../../../common/widgets/app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/account_home_button.dart';
import 'widgets/section_container.dart';

class AccountsHome extends StatelessWidget {
  final AccountsListCubit _accountsListCubit = di<AccountsListCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // drawer: MainDrawer(),
      // appBar: MainAppBar(
      //   title: "Home",
      // ),
      body: CustomScrollView(
        // padding: EdgeInsets.only(left: 10, right: 10),
        slivers: [
          SliverAppBar(
            // title: Container(child: Text("test"),),
            elevation: 0,
            // pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              background: AccountAppBap(),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    child: Row(
                      children: [
                        AccountHomeButton(
                          title: 'Accounts',
                          icon: Icons.account_balance_wallet,
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (childContext) {
                                return AccountsList();
                              }),
                            );
                          },
                        ),
                        AccountHomeButton(
                          title: 'New Record',
                          icon: Icons.add,
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (childContext) {
                                return AddTransaction();
                              }),

                            );
                          },
                        ),
                        AccountHomeButton(
                          title: 'Import',
                          icon: Icons.import_export,
                          onTap: (){

                          },
                        ),
                        AccountHomeButton(
                          title: 'Export',
                          icon: Icons.picture_as_pdf,
                          onTap: (){},
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                    ),
                    padding: EdgeInsets.all(20),

                  ),
                  Divider(),
                  SectionContainer(
                      child: BlocProvider(
                        create: (context) => di<AnalyticsCubit<CategoryNodeModel>>()..fetch(),
                        child: BlocBuilder<AnalyticsCubit<CategoryNodeModel>, AnalyticsState<CategoryNodeModel>>(
                          builder: (context, state) {
                            if (state.loading) {
                              return LoadingSpinner();
                            } else {
                              return TransactionsByCategoryChart(state.models);
                            }

                          },
                        ),
                      ),
                      title: "Spending this month"
                  ),
                  SectionContainer(
                      child: BlocProvider(
                        create: (context) => di<AnalyticsCubit<DateNodeModel>>()..fetch(),
                        child: BlocBuilder<AnalyticsCubit<DateNodeModel>, AnalyticsState<DateNodeModel>>(
                          builder: (context, state) {
                            if (state.loading) {
                              return LoadingSpinner();
                            } else {
                              print(state.models);
                              return TransactionsByRangeChart(state.models);
                            }

                          },
                        ),
                      ),
                      title: "Spending this month"
                  ),

                  // SectionContainer(
                  //     child: TransactionsByRangeChart(),
                  //     title: "Spending this month"),
                ]
              )
          )
        ]
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.of(context).pushNamed(TRANSACTION_ADD_ROUTE);
      //   },
      //   child: const Icon(Icons.add),
      //   backgroundColor: Theme
      //       .of(context)
      //       .colorScheme
      //       .primary,
      // ),
    );
  }
}
