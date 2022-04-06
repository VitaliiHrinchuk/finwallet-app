import 'package:flutter/material.dart';

class EmptyTransactionsListPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Oops, looks there is no transactions yet in the selected month"
      ),
    );
  }
}
