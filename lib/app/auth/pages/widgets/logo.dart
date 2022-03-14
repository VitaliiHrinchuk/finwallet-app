import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 75, right: 75, top: 30, bottom: 30),
      child: Image(
        image: AssetImage('assets/logo.png'),
        height: 70,
      )
    );
  }
}
