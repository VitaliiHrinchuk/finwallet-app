import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget {
  final double appBarHeight = 40.0;
  final Widget child;
  final Color firstColor;
  final Color secondColor;

  GradientAppBar({
    required this.child,
    required this.firstColor,
    required this.secondColor
  });

  @override
  Widget build(BuildContext context) {

    final double statusBarHeight = MediaQuery
        .of(context)
        .padding
        .top;

    return Container(
      padding: new EdgeInsets.only(top: statusBarHeight, left: 15, right: 15),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              this.firstColor,
              this.secondColor,
            ],
          )
      ),
      child: this.child,
    );
  }
}
