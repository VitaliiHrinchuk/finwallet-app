import 'dart:collection';

import 'package:finwallet_app/app/auth/bloc/auth/auth_bloc.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/transaction/cubit/list/transactions_list_cubit.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/empty_transaction_list_placeholder.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/transaction_list_item.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/transaction_list_separator.dart';
import 'package:finwallet_app/common/constants/currencies.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:finwallet_app/common/utils/format_amount.dart';
import 'package:finwallet_app/common/widgets/app_bar/main_app_bar.dart';
import 'package:finwallet_app/common/widgets/drawer/drawer_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ListTransactions extends StatelessWidget {
  final bool isIncome;

  ListTransactions({required this.isIncome});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                elevation: 0,
                centerTitle: true,
                titleTextStyle: Theme.of(context).textTheme.titleMedium,
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  labelColor: Theme.of(context).colorScheme.primary,
                  indicatorColor: Theme.of(context).colorScheme.primary,
                  tabs: [
                    Tab(text: 'By Date'),
                    Tab(text: 'By Category'),
                  ],
                ),
                title: isIncome ? Text('Incomes') : Text('Outcomes'),
                backgroundColor: Colors.white,
              ),
            ];
          },
          body: BlocProvider<TransactionsListCubit>(
            create: (context) => di<TransactionsListCubit>()..load(isIncome ? TransactionType.DEB : TransactionType.CRE),
            child: SafeArea(
              child: BlocBuilder<TransactionsListCubit, TransactionsListState>(
                builder: (context, state) {
                  return TabBarView(
                    children: [
                      this._buildList(context, this._buildListByDate(context, state.entities)),
                      this._buildList(context, this._buildListByCategory(context, state.entities)),
                    ],
                  );
                },
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
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Widget> children) {
    if (children.length == 0) {
      return EmptyTransactionsListPlaceholder();
    } else {
      return ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: children.length,
        itemBuilder: (context, int index) {
          return children[index];
        },

      );
    }

  }

  List<Widget> _buildListByDate(context, List<TransactionEntity> entities) {
    List<Widget> result = [];
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    List<String> existedDates = [];
    Currency? baseCurrency = this._getBaseCurrency(context);

    entities.forEach((TransactionEntity entity) {
      String formattedDate = dateFormat.format(entity.transactionDate);

      if (existedDates.contains(formattedDate)) {
        result.add(TransactionListItem(entity: entity));
      } else {
        double totalByMonth = _countTotalAmountByDate(entity.transactionDate, entities);
        result.add(TransactionListSeparator(
          leadingTitle: formattedDate,
          trailingTitle: formatAmount(totalByMonth, baseCurrency!),
        ));
        result.add(TransactionListItem(entity: entity));
        existedDates.add(formattedDate);
      }
    });

    return result;
  }

  List<Widget> _buildListByCategory(context, List<TransactionEntity> entities) {
    List<Widget> result = [];
    Currency? baseCurrency = this._getBaseCurrency(context);
    Map<String, double> categoryGroups = {};


    entities.forEach((TransactionEntity entity) {
      if (!categoryGroups.containsKey(entity.category.name)) {
        categoryGroups[entity.category.name] = _countTotalAmountByCategory(entity.category.slug, entities);
      }
    });

    Map<String, double> sortedByTotal = Map.fromEntries(
        categoryGroups.entries.toList()
          ..sort((e1, e2) => e2.value.compareTo(e1.value)));

    sortedByTotal.forEach((key, value) {
          result.add(TransactionListSeparator(
            leadingTitle: key,
            trailingTitle: formatAmount(value, baseCurrency!),
          ));

          entities.forEach((entity) {
            if (entity.category.name == key) {
               result.add(TransactionListItem(entity: entity));
            }
          });
    });

    return result;
  }

  double _countTotalAmountByDate(DateTime date, List<TransactionEntity> entities) {
    DateFormat dateFormat = DateFormat("MM-dd");
    String formattedDate = dateFormat.format(date);
    double sum = 0;

    entities.forEach((TransactionEntity entity) {
      String transactionFormattedDate = dateFormat.format(entity.transactionDate);

      if (formattedDate == transactionFormattedDate) {
        sum += entity.baseCurrencyAmount;
      }

    });

    return sum;
  }

  double _countTotalAmountByCategory(String slug, List<TransactionEntity> entities) {
    double sum = 0;

    entities.forEach((TransactionEntity entity) {
      if (entity.category.slug == slug) {
        sum += entity.baseCurrencyAmount;
      }
    });

    return sum;
  }

  Currency? _getBaseCurrency(BuildContext context) {
    AuthState state = BlocProvider.of<AuthBloc>(context).state;

    if (state is AuthAuthenticated) {
      return state.user.baseCurrency;
    }

    return null;
  }
}
