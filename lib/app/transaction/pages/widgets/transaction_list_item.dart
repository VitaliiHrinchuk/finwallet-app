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
    Color color = entity.transactionType == TransactionType.DEB ? Color(0xFF3FAE2B) : Color(0xFFDD7A78);
    String tags = entity.tags.map((e) => e.name).join(', ');
    String prefix = entity.transactionType == TransactionType.DEB ? '+' : '-';
    return ListTile(
      dense: true,
      minVerticalPadding: 0,
      leading: CategoryIcon(slug: entity.category.slug),
      title: Row(
        children: [
          Text(entity.category.name),
          SizedBox(width: 5,),
          Text(
            tags,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 12,
                color: Colors.grey
            ),
          ),
        ],
      ),
      subtitle: Text(entity.account.name),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            prefix + formatAmount(entity.amount, entity.currency),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14
            ),
          ),
          Text(
            prefix + formatAmount(entity.accountCurrencyAmount, entity.account.currency),
            style: TextStyle(
                color: color,
                fontSize: 12
            ),
          ),
        ],
      ),
    );
  }
}
