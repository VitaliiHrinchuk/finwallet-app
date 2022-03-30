import 'package:finwallet_app/common/widgets/app_bar/main_app_bar.dart';
import 'package:finwallet_app/common/widgets/drawer/drawer_nav.dart';
import 'package:flutter/material.dart';

class AccountSelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MainDrawer(),
      appBar: MainAppBar(
        title: '',
        canGoBack: true,
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(

        child: ListView(
          children: [
            ListTile(
              title: Text("test"),
            ),
            ListTile(
              title: Text("test"),
            )
            ,ListTile(
              title: Text("test"),
            )
            ,ListTile(
              title: Text("test"),
            )
          ],
        )
      ),
    );
  }
}
