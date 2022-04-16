import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/transaction_list_item.dart';
import 'package:flutter/material.dart';

class LatestTransactions extends StatelessWidget {

  final List<TransactionEntity> entities;

  LatestTransactions(this.entities);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: this.entities.map((e) => TransactionListItem(entity: e)).toList()
      ),
    );
  }
}
