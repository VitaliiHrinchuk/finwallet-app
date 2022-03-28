import 'package:flutter/material.dart';

class NumPadValue extends StatelessWidget {

  final String value;

  NumPadValue(this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      child: FittedBox(
        alignment: Alignment.centerRight,
        fit: BoxFit.contain,
        child: Text(
            value,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
