import 'package:finwallet_app/app/account/bloc/account/account_bloc.dart';
import 'package:finwallet_app/app/account/cubit/analytics/analytics_cubit.dart';
import 'package:finwallet_app/app/account/cubit/list/accounts_list_cubit.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/category_node_model.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/date_node_model.dart';
import 'package:finwallet_app/app/account/pages/accounts_list.dart';
import 'package:finwallet_app/app/account/pages/widgets/accounts_horizontal_list.dart';
import 'package:finwallet_app/app/account/pages/widgets/app_bar/account_app_bar.dart';
import 'package:finwallet_app/app/account/pages/widgets/latest_transactions.dart';
import 'package:finwallet_app/app/account/pages/widgets/transactions_by_category_chart.dart';
import 'package:finwallet_app/app/account/pages/widgets/transactions_by_range_chart.dart';
import 'package:finwallet_app/app/transaction/cubit/list/transactions_list_cubit.dart';
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
  final TransactionsListCubit _transactionsListCubit = di<TransactionsListCubit>();
  final AnalyticsCubit<CategoryNodeModel> _categoryAnalyticsCubit = di<AnalyticsCubit<CategoryNodeModel>>();
  final AnalyticsCubit<DateNodeModel> _dateAnalyticsCubit = di<AnalyticsCubit<DateNodeModel>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      // drawer: MainDrawer(),
      // appBar: MainAppBar(
      //   title: "Home",
      // ),
      body:  MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => _dateAnalyticsCubit..fetch()),
          BlocProvider(create: (context) => _categoryAnalyticsCubit..fetch()),
          BlocProvider(create: (context) {
            _transactionsListCubit.setLimit(3);
            _transactionsListCubit.fetch();

            return _transactionsListCubit;
          })
        ],
        child: CustomScrollView(
          // padding: EdgeInsets.only(left: 10, right: 10),
          slivers: [
            SliverAppBar(
              // title: Container(child: Text("test"),),
              elevation: 0,
              // pinned: true,
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                background: AccountAppBap(
                  onAccountSelect: (AccountEntity? account) {
                    _transactionsListCubit.setAccount(account);
                    _dateAnalyticsCubit.setAccount(account);
                    _categoryAnalyticsCubit.setAccount(account);
                    _transactionsListCubit.fetch();
                    _dateAnalyticsCubit.fetch();
                    _categoryAnalyticsCubit.fetch();
                  },
                ),
              ),
            ),
           SliverList(
                  delegate: SliverChildListDelegate.fixed(
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
                          child: BlocBuilder<TransactionsListCubit, TransactionsListState>(
                            builder: (context, state) {
                              if (state.loading) {
                                return LoadingSpinner();
                              } else {
                                return LatestTransactions(state.entities);
                              }

                            },
                          ),
                          title: "Latest Transactions"
                      ),
                      SectionContainer(
                          child: BlocBuilder<AnalyticsCubit<CategoryNodeModel>, AnalyticsState<CategoryNodeModel>>(
                            builder: (context, state) {
                              if (state.loading) {
                                return LoadingSpinner();
                              } else {
                                if (state.models.length == 0) {
                                  return LoadingSpinner();
                                }
                                return TransactionsByCategoryChart(state.models);
                              }

                            },
                          ),
                          title: "Spending this month"
                      ),
                      SectionContainer(
                          child: BlocBuilder<AnalyticsCubit<DateNodeModel>, AnalyticsState<DateNodeModel>>(
                            builder: (context, state) {
                              if (state.loading) {
                                return LoadingSpinner();
                              } else {

                                return TransactionsByRangeChart(state.models);
                              }

                            },
                          ),
                          title: "Spending this month"
                      ),

                    ]
                  )
              ),
          ]
        ),
      ),
    );
  }
}
