import 'package:finwallet_app/app/account/pages/account_edit.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:flutter/material.dart';

class AccountListItem extends StatelessWidget {

  final String name;
  final double amount;
  final String currency;
  final Function onTap;

  AccountListItem({
    required this.name,
    required this.amount,
    required this.currency,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(amount.toStringAsFixed(2) + " " + currency),
      onTap: () => onTap(),
    );
  }
}
