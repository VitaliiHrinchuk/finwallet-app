import 'package:flutter/material.dart';

class TransactionTypeToggler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).colorScheme.primary;
    Color secondary = Colors.white;
    return Container(
      width: 300,
      height: 35,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          border: Border.all(color: primary),
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        child: Row(
          children: [
            Expanded(
                child: Container(
              color: primary,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Income",
                  style: TextStyle(color: secondary),
                ),
              ),
            )),
            Expanded(
                child: TextButton(onPressed: () {}, child: Text("Outcome")))
          ],
        ),
      ),
    );
  }
}
