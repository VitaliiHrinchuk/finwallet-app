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
      // decoration: BoxDecoration(
      //   border: Border(bottom: BorderSide(color: Colors.black))
      // ),
      padding: EdgeInsets.only(top: 10, bottom: 10),
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leadingTitle,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 14
            ),
          ),
          Text(
            trailingTitle,
              style: TextStyle(
                  // fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 14
              ),
          ),
        ],
      ),
    );
  }
}
