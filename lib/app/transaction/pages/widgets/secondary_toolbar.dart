import 'package:finwallet_app/app/tag/domain/tag_entity.dart';
import 'package:finwallet_app/app/tag/pages/tag_select.dart';
import 'package:finwallet_app/app/transaction/cubit/form/transaction_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SecondaryToolbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     border:
      //     Border(top: BorderSide(width: 1, color: Colors.grey.shade200))),
      padding: EdgeInsets.only(left: 5),
      child: Row(
        children: [
          BlocBuilder<TransactionFormCubit, TransactionFormState>(
            builder: (context, state) {
              return TextButton(
                  onPressed: () => _showDatePicker(context),
                  child: Text(
                    dateToString(state.transactionDate),
                    style: TextStyle(
                        color: Colors.grey
                    ),
                  )
              );
            },
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Icon(
              Icons.circle,
              size: 5,
              color: Colors.grey.shade300,
            ),
          ),
          BlocBuilder<TransactionFormCubit, TransactionFormState>(
            builder: (context, state) {
              String title = "Add Tags";
              if (state.tags.length > 0) {
                title = state.tags.map((e) => e.name).toList().join(', ');
              }
              return Flexible(
                child: TextButton(
                    onPressed: () {
                      _navigateAndSelectTags(context);
                    },
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w400
                      ),
                    )
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101)
    );

    if (picked != null) {
      context
          .read<TransactionFormCubit>()
          .setDate(picked);
    }
  }

  String dateToString(DateTime date) {
    // if (date.)
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String nowFormatted = dateFormat.format(DateTime.now());
    String yesterdayFormatted = dateFormat.format(
        DateTime.now().subtract(Duration(days: 1)));
    String selectedDateFormatted = dateFormat.format(date);

    if (nowFormatted == selectedDateFormatted) {
      return "Today";
    } else if (yesterdayFormatted == selectedDateFormatted) {
      return "Yesterday";
    }
    return selectedDateFormatted;
  }


  void _navigateAndSelectTags(BuildContext context) async {
    TransactionFormCubit cubit = BlocProvider.of<TransactionFormCubit>(context);
    List<TagEntity> initialValue = cubit.state.tags;
    final List<TagEntity>? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (childContext) {
        return TagSelect(initialValue: initialValue);
      }),
    );

    if (result != null) {
    cubit.setTags(result);
    }
  }
}
