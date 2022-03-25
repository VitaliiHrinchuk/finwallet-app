import 'package:flutter/material.dart';

class ContentContainer extends StatelessWidget {

  final Widget child;

  ContentContainer({
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 15 ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: this.child,
    );
  }
}
