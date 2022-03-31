import 'package:finwallet_app/app/transaction/cubit/form/transaction_form_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          TextButton(
              onPressed: () {},
              child: Text(
                "Add Tags",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400
                ),
              )
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
    return date.toString();
  }
}
