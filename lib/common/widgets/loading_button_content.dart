import 'package:flutter/material.dart';

class LoadingButtonContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}
