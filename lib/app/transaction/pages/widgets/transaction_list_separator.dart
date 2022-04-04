import 'package:flutter/material.dart';

class TransactionListSeparator extends StatelessWidget {

  final String leadingTitle;
  final String trailingTitle;

  TransactionListSeparator({
    required this.trailingTitle,
    required this.leadingTitle
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Color(0xFFB6E0F9),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leadingTitle,
            style: TextStyle(
                fontWeight: FontWeight.bold,
              // color: Colors.grey.shade400,
                fontSize: 12
            ),
          ),
          Text(
            trailingTitle,
              style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  // color: Colors.grey.shade400,
                fontSize: 12
              ),
          ),
        ],
      ),
    );
  }
}
