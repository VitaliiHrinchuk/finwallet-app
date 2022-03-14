import 'package:finwallet_app/app/auth/bloc/auth/auth_bloc.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class RouteItem {
  final String id;
  final String text;
  final IconData icon;
  final String route;
  final bool routeReplace;

  const RouteItem(
      {required this.id,
      required this.text,
      required this.icon,
      required this.route,
      required this.routeReplace});
}

const List<RouteItem> nav = [
  // RouteItem(
  //     id: 'feed',
  //     text: Strings.DRAWER_FEED,
  //     icon: Icons.list,
  //     route: FEED_ROUTE,
  //     routeReplace: false),
  // RouteItem(
  //     id: 'school/create',
  //     text: Strings.DRAWER_CREATE_SCHOOL,
  //     icon: Icons.add_circle,
  //     route: SCHOOL_CREATE_ROUTE,
  //     routeReplace: false),
  // RouteItem(
  //     id: 'manage/school',
  //     text: Strings.DRAWER_LIST_SCHOOL,
  //     icon: Icons.school,
  //     route: SCHOOLS_LIST_ROUTE,
  //     routeReplace: false),
  // RouteItem(
  //     id: 'invite/create',
  //     text: Strings.DRAWER_CREATE_INVITE,
  //     icon: Icons.person_add,
  //     route: SCHOOL_CREATE_ROUTE,
  //     routeReplace: false),
  // RouteItem(
  //     id: 'manage/invites',
  //     text: Strings.DRAWER_LIST_INVITE,
  //     icon: Icons.supervisor_account,
  //     route: INVITES_LIST_ROUTE,
  //     routeReplace: false),
  // RouteItem(
  //     id: 'report',
  //     text: Strings.DRAWER_LIST_REPORT,
  //     icon: Icons.dashboard,
  //     route: REPORT_ROUTE,
  //     routeReplace: false),
];

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.only(left: 5),
              leading: IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.close,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                'FinWallet',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    letterSpacing: 0.15),
              ),
            ),
            ...List<Widget>.generate(nav.length, (index) {
              final bool isSelected =
                  ModalRoute.of(context)!.settings.name == nav[index].route;
              return ListTile(
                leading: Icon(nav[index].icon, color: Colors.black),
                selected: isSelected,
                title: Text(nav[index].text),
                onTap: () {
                  if (!isSelected) {
                    Navigator.pop(context);

                    bool isCurrentRouteList = ModalRoute.of(context)!
                            .settings
                            .name!
                            .contains("manage") &&
                        nav[index].id.contains("manage");
                    if (nav[index].routeReplace || isCurrentRouteList) {
                      Navigator.pushReplacementNamed(context, nav[index].route);
                    } else {
                      Navigator.pushNamed(context, nav[index].route);
                    }
                  } else {
                    Navigator.pop(context);
                  }
                },
              );
            }),
            ListTile(
              leading: Icon(Icons.chevron_left),
              title: Text("Logout"),
              onTap: () {
                dispatchLogout(context);
              },
            )
          ],
        ),
      ),
    );
  }

  void dispatchLogout(context) {
    BlocProvider.of<AuthBloc>(context).add(AuthLogout());
  }
}
