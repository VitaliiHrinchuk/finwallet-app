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

class App extends StatefulWidget {
  final String initialRoute;
  // final GlobalKey<NavigatorState> navigationKey;

  const App({required this.initialRoute})
      : super();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // final _router = AppRouter();
  final ThemeData theme = ThemeData(fontFamily: 'OpenSans');
  // final CategoryListCubit _categoryListCubit = di<CategoryListCubit>();
  // final TagListCubit _tagListCubit = di<TagListCubit>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AccountsListCubit>(
          create: (context) => di<AccountsListCubit>()..loadAccounts(),
        ),
        BlocProvider<CategoryListCubit>(
          create: (context) => di<CategoryListCubit>()
        ),
        BlocProvider<TagListCubit>(
          create: (context) => di<TagListCubit>(),
        ),
      ],
      child: MaterialApp(
        title: 'FinWallet',
        // navigatorKey: widget.navigationKey,
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

        initialRoute: widget.initialRoute,
        routes: {
          SETUP_USER_ROUTE: (context) => SetupUserPage(),
          HOME_ROUTE: (context) => MainWrapper(),
          CREATE_ACCOUNT_ROUTE: (context) => AccountFirst(),
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
