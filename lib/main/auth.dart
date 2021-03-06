import 'package:finwallet_app/app/account/cubit/list/accounts_list_cubit.dart';
import 'package:finwallet_app/app/account/pages/account_edit.dart';
import 'package:finwallet_app/app/account/pages/account_select.dart';
import 'package:finwallet_app/app/account/pages/accounts_home.dart';
import 'package:finwallet_app/app/account/pages/accounts_list.dart';
import 'package:finwallet_app/app/account/pages/widgets/create_account_form.dart';
import 'package:finwallet_app/app/auth/pages/login.dart';
import 'package:finwallet_app/app/auth/pages/signup.dart';
import 'package:finwallet_app/app/category/cubit/list/category_list_cubit.dart';
import 'package:finwallet_app/app/tag/cubit/list/tag_list_cubit.dart';
import 'package:finwallet_app/app/transaction/pages/transaction_add.dart';
import 'package:finwallet_app/app/transaction/pages/transactions_list.dart';
import 'package:finwallet_app/app/user/pages/user_setup.dart';
import 'package:finwallet_app/common/constants/colors.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:finwallet_app/main/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../app/account/pages/account_first.dart';

const RED = 98;
const GREEN = 0;
const BLUE = 238;
const HEX_COLOR = 0xff6200EE;
const Map<int, Color> color = {
  50: Color.fromRGBO(RED, GREEN, BLUE, .1),
  100: Color.fromRGBO(RED, GREEN, BLUE, .2),
  200: Color.fromRGBO(RED, GREEN, BLUE, .3),
  300: Color.fromRGBO(RED, GREEN, BLUE, .4),
  400: Color.fromRGBO(RED, GREEN, BLUE, .5),
  500: Color.fromRGBO(RED, GREEN, BLUE, .6),
  600: Color.fromRGBO(RED, GREEN, BLUE, .7),
  700: Color.fromRGBO(RED, GREEN, BLUE, .8),
  800: Color.fromRGBO(RED, GREEN, BLUE, .9),
  900: Color.fromRGBO(RED, GREEN, BLUE, 1),
};

class Auth extends StatefulWidget {
  const Auth() : super();

  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  // final _router = AppRouter();
  final ThemeData theme = ThemeData(fontFamily: 'OpenSans');


  @override
  Widget build(BuildContext context) {

    return
      MaterialApp(
        title: 'FinWallet',
        theme: theme.copyWith(

          // primarySwatch: MaterialColor(HEX_COLOR, color),
          // accentColor: Colors.tealAccent,
            scaffoldBackgroundColor: Colors.white,
            colorScheme: theme.colorScheme.copyWith(
                secondary: Colors.grey.shade300,
                // background: Color(0xFFF2F3F5),
                secondaryContainer: Colors.white,
                primary: Colors.black
              // primary: Color(0xFF23695E)
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )))),
            textTheme: theme.textTheme.copyWith(
                titleMedium: theme.textTheme.titleMedium?.copyWith(
                  // color: Colors.grey,
                    fontWeight: FontWeight.bold)),
            appBarTheme: theme.appBarTheme.copyWith(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            )),
        // navigatorKey: Navigators.mainNav,
        // onGenerateRoute: _router.onGenerateRoute,
        initialRoute: LOGIN_ROUTE,
        routes: {
          LOGIN_ROUTE: (context) => Login(),
          SIGN_UP_ROUTE: (context) => Signup(),

        },

        // navigatorObservers: [routeObserver],
      );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
