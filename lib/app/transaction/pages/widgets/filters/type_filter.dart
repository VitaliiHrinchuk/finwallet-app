import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:flutter/material.dart';

class TypeFilter extends StatelessWidget {

  final TransactionType? type;
  final Function(TransactionType? type) onChange;

  TypeFilter({
    required this.type,
    required this.onChange
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile<TransactionType?>(
          contentPadding: EdgeInsets.zero,
          title: const Text('All'),
          value: null,
          groupValue: type,
          onChanged: this.onChange,
        ),
        RadioListTile<TransactionType>(
          contentPadding: EdgeInsets.zero,
          title: const Text('Expenses'),
          value: TransactionType.CRE,
          groupValue: type,
          onChanged: this.onChange,
        ),
        RadioListTile<TransactionType>(
          contentPadding: EdgeInsets.zero,
          title: const Text('Incomes'),
          value: TransactionType.DEB,
          groupValue: type,
          onChanged: this.onChange,
        )
      ],
    );
  }
}
