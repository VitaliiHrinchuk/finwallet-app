import 'package:finwallet_app/app/transaction/cubit/list/transactions_list_cubit.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/filters/category_filter.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/filters/date_filter.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/filters/type_filter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/filters/filters_section.dart';
import 'package:finwallet_app/common/widgets/app_bar/main_app_bar.dart';
import 'package:finwallet_app/common/widgets/input/main_input_decoration.dart';
import 'package:flutter/material.dart';

class TransactionFilters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Filters',
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FiltersSection(
                child:
                BlocBuilder<TransactionsListCubit, TransactionsListState>(
                  builder: (context, state) {
                    return DateFilter(
                      startDate: state.filters.startDate ?? DateTime.now(),
                      endDate: state.filters.endDate ?? DateTime.now(),
                      onEndDateChange: (date) =>
                          context
                              .read<TransactionsListCubit>()
                              .setFilterEndDate(date),
                      onStartDateChange: (date) =>
                          context
                              .read<TransactionsListCubit>()
                              .setFilterStartDate(date),
                    );
                  },
                ),
                title: 'Date',
              ),
              FiltersSection(
                child:
                BlocBuilder<TransactionsListCubit, TransactionsListState>(
                  builder: (context, state) {
                    return TypeFilter(
                      type: state.filters.type,
                      onChange: (type) =>
                          context
                              .read<TransactionsListCubit>()
                              .setType(type),
                    );
                  },
                ),
                title: "Type",
              ),
              FiltersSection(
                child: BlocBuilder<TransactionsListCubit, TransactionsListState>(
                  builder: (context, state) {
                    return CategoryFilter(
                      values: state.filters.categories ?? [],
                      onChange: (categories) => context
                          .read<TransactionsListCubit>()
                          .setCategories(categories),
                    );
                  },
                ),
                title: "Categories",
              ),

              Expanded(child: Container()),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                      context.read<TransactionsListCubit>().fetch();
                      Navigator.of(context).pop();
                    },
                    child: Text("Submit Filters")
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
