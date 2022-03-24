import 'package:flutter/material.dart';

class AccountCardContainer extends StatelessWidget {
  final Widget child;
  final bool outlined;

  AccountCardContainer({ required this.child, this.outlined = false });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      // margin: EdgeInsets.all(5),
      // width: 200,
      // height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(13)),
        color: this.outlined ? Colors.transparent : Colors.blue,
        border: Border.all(
          color: this.outlined ? Colors.blue : Colors.transparent,
        )
      ),
      child: this.child,
    );
  }
}
