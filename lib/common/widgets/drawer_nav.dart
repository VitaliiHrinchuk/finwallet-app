import 'package:finwallet_app/app/auth/bloc/auth/auth_bloc.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'drawer_nav_item.dart';

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
  RouteItem(
      id: 'HOME',
      text: "Home",
      icon: Icons.home,
      route: HOME_ROUTE,
      routeReplace: false),
  RouteItem(
      id: 'ACCOUNTS',
      text: "Accounts",
      icon: Icons.account_balance_wallet,
      route: ACCOUNTS_LIST_ROUTE,
      routeReplace: false),
  RouteItem(
      id: 'STATISTICS',
      text: "Statistics",
      icon: Icons.bar_chart,
      route: STATISTICS_ROUTE,
      routeReplace: false),
  RouteItem(
      id: 'INCOMES',
      text: "Incomes",
      icon: Icons.add,
      route: INCOMES_ROUTE,
      routeReplace: false),
  RouteItem(
      id: 'OUTCOMES',
      text: "Outcomes",
      icon: Icons.remove,
      route: OUTCOMES_ROUTE,
      routeReplace: false),
  RouteItem(
      id: 'REGULAR_PAYMENTS',
      text: "Regular Payments",
      icon: Icons.schedule,
      route: REGULAR_PAYMENTS_ROUTE,
      routeReplace: false),
];

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: Container(
          // padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              ...List<Widget>.generate(nav.length, (index) {
                final bool isSelected =
                    ModalRoute.of(context)!.settings.name == nav[index].route;

                return DrawerNavItem(
                    icon: nav[index].icon,
                    selected: isSelected,
                    title: nav[index].text,
                    onTap: () {
                      if (!isSelected) {
                        Navigator.pop(context);

                        bool isCurrentRouteList = ModalRoute.of(context)!
                                .settings
                                .name!
                                .contains("manage") &&
                            nav[index].id.contains("manage");
                        if (nav[index].routeReplace || isCurrentRouteList) {
                          Navigator.pushReplacementNamed(
                              context, nav[index].route);
                        } else {
                          Navigator.pushNamed(context, nav[index].route);
                        }
                      } else {
                        Navigator.pop(context);
                      }
                    });
              }),
              const Expanded(child: SizedBox()),
              DrawerNavItem(
                  icon: Icons.chevron_left,
                  title: "Logout",
                  onTap: () {
                    dispatchLogout(context);
                  }
                  )
            ],
          ),
        ),
      ),
    );
  }

  void dispatchLogout(context) {
    BlocProvider.of<AuthBloc>(context).add(AuthLogout());
  }
}
