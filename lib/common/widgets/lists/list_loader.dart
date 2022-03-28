import 'package:flutter/material.dart';

class ListLoader extends StatelessWidget {
  const ListLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}