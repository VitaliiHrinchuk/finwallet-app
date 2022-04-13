import 'package:finwallet_app/app/transaction/cubit/form/transaction_form_cubit.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionTypeToggler extends StatelessWidget {
  final Map<String, TransactionType> types = {
    'Income': TransactionType.DEB,
    'Outcome': TransactionType.CRE
  };

  @override
  Widget build(BuildContext context) {


    return Container(
      width: 300,
      height: 35,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        child: Row(
          children: types.entries.map((e) => _buildButton(context, e.key, e.value))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String name, TransactionType type) {
    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
          builder: (context, state) {
            return Expanded(
                child: Container(
                    color: type == state.type ? Colors.black : null,
                    child: TextButton(
                      onPressed: () {
                        BlocProvider.of<TransactionFormCubit>(context).setType(type);
                      },
                      child: Text(
                          name,
                          style: type == state.type ? TextStyle(color: Colors.white) : TextStyle(color: Colors.black),
                    )
                )
            ));
      },
    );
  }
}
