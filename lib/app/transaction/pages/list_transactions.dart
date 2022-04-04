import 'package:finwallet_app/app/transaction/cubit/list/transactions_list_cubit.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/transaction_list_item.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/transaction_list_separator.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:finwallet_app/common/dependencies.dart';
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
        drawer: MainDrawer(),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.titleMedium,
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
        extendBodyBehindAppBar: true,
        body: BlocProvider<TransactionsListCubit>(
          create: (context) => di<TransactionsListCubit>()..load(TransactionType.CRE),
          child: SafeArea(
            child: BlocBuilder<TransactionsListCubit, TransactionsListState>(
              builder: (context, state) {
                return TabBarView(
                  children: [
                    this._buildList(context, this._buildListByDate(state.entities)),
                    this._buildList(context, []),
                  ],
                );
              },
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
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: children.length,
      itemBuilder: (context, int index) {
        return children[index];
      },
    );
  }

  List<Widget> _buildListByDate(List<TransactionEntity> entities) {
    List<Widget> result = [];
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    List<String> existedDates = [];

    entities.forEach((TransactionEntity entity) {
      String formattedDate = dateFormat.format(entity.transactionDate);

      if (existedDates.contains(formattedDate)) {
        result.add(TransactionListItem(entity: entity));
      } else {
        result.add(TransactionListSeparator(
          leadingTitle: formattedDate,
          trailingTitle: '300 USd',
        ));
        result.add(TransactionListItem(entity: entity));
        existedDates.add(formattedDate);
      }
    });

    return result;
  }
}
