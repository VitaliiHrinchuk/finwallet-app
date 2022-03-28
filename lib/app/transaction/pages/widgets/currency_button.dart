
import 'package:flutter/material.dart';

class CurrencyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: FittedBox(
        child: TextButton(
          onPressed: () {  },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary
              )
            ),
            padding: EdgeInsets.all(20),
          ),
          child: Text(
            "UAH",
          ),
        ),
      ),
    );
  }
}
