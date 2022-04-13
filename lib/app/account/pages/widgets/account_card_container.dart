import 'package:flutter/material.dart';

class AccountCardContainer extends StatelessWidget {
  final Widget child;
  final Color? color;

  AccountCardContainer({ required this.child,  this.color = Colors.black });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      // margin: EdgeInsets.all(5),
      // width: 200,
      // height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        // color: color,
        color: Colors.black
      ),
      child: this.child,
    );
  }
}
