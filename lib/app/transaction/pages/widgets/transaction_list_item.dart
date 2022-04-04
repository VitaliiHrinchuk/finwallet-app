import 'package:finwallet_app/app/category/pages/widgets/category_icon.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/common/utils/format_amount.dart';
import 'package:flutter/material.dart';

class TransactionListItem extends StatelessWidget {

  final TransactionEntity entity;

  TransactionListItem({
    required this.entity
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minVerticalPadding: 0,
      leading: CategoryIcon(slug: entity.category.slug),
      title: Text(entity.category.name),
      subtitle: Text(entity.account.name),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formatAmount(entity.amount, entity.currency),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14
            ),
          ),
          Text(
            formatAmount(entity.accountCurrencyAmount, entity.account.currency),
            style: TextStyle(
                fontSize: 12
            ),
          ),
        ],
      ),
    );
  }
}
