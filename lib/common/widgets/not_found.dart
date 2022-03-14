import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage() : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not found'),
      ),
      body: Center(
        child: Text('...'),
      ),
    );
  }
}
