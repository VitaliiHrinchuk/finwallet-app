import 'package:finwallet_app/app/account/cubit/analytics/analytics_cubit.dart';
import 'package:finwallet_app/app/account/cubit/list/accounts_list_cubit.dart';
import 'package:finwallet_app/app/account/domain/analytics_models/currency_node_model.dart';
import 'package:finwallet_app/app/account/pages/widgets/balance_by_account_chart.dart';
import 'package:finwallet_app/app/account/pages/widgets/balance_by_currency_chart.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:finwallet_app/common/widgets/loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/app_bar/statistics_app_bar.dart';
import 'widgets/section_container.dart';

class AccountStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: StatisticsAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                SectionContainer(
                    child: BlocBuilder<AccountsListCubit, AccountsListState>(
                      builder: (context, state) {
                        return BalanceByAccountChart(state.entities);
                      },
                    ),
                    title: "Balance By Account"
                ),
                BlocProvider(
                  create: (context) => di<AnalyticsCubit<CurrencyNodeModel>>()..fetch(),
                  child: SectionContainer(
                      child: BlocBuilder<
                          AnalyticsCubit<CurrencyNodeModel>,
                          AnalyticsState<CurrencyNodeModel>>(
                        builder: (context, state) {
                          if (state.loading) {
                            return LoadingSpinner();
                          } else {
                            return BalanceByCurrencyChart(state.models);
                          }
                        },
                      ),
                      title: "Balance By Currency"
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );;
  }
}
