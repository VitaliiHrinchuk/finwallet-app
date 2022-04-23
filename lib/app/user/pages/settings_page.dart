import 'package:finwallet_app/app/auth/bloc/auth/auth_bloc.dart';
import 'package:finwallet_app/app/category/pages/category_list.dart';
import 'package:finwallet_app/app/tag/pages/tag_list.dart';
import 'package:finwallet_app/app/user/pages/widgets/setting_menu_item.dart';
import 'package:finwallet_app/app/user/pages/widgets/settings_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SettingsAppBar(),
      body:  SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SettingMenuItem(
                  "Manage Categories",
                  icon: Icons.category,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (childContext) {
                        return CategoryList();
                      }),
                    );
                  }
              ),
              SizedBox(height: 15),
              SettingMenuItem(
                  "Manage Tags",
                  icon: Icons.label,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (childContext) {
                        return TagList();
                      }),
                    );
                  }
              ),
              // SizedBox(height: 15),
              // SettingMenuItem(
              //     "Regular Payments",
              //     icon: Icons.access_time,
              //     onTap: () {}
              // ),
              Expanded(child: Container()),
              SettingMenuItem(
                "Logout",
                icon: Icons.logout,
                onTap: () {
                  BlocProvider.of<AuthBloc>(context).add(AuthLogout());
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
