import 'package:finwallet_app/common/widgets/drawer_nav.dart';
import 'package:flutter/material.dart';

class AccountsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: SafeArea(
        child: Text("test"),
      ),
    );
  }
}
