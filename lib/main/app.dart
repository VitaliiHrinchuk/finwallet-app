import 'package:finwallet_app/app/account/pages/accounts_home.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


const RED = 98;
const GREEN = 0;
const BLUE = 238;
const HEX_COLOR = 0xff6200EE;
const Map<int, Color> color =
{
  50:Color.fromRGBO(RED,GREEN,BLUE, .1),
  100:Color.fromRGBO(RED,GREEN,BLUE,  .2),
  200:Color.fromRGBO(RED,GREEN,BLUE,  .3),
  300:Color.fromRGBO(RED,GREEN,BLUE,  .4),
  400:Color.fromRGBO(RED,GREEN,BLUE,  .5),
  500:Color.fromRGBO(RED,GREEN,BLUE,  .6),
  600:Color.fromRGBO(RED,GREEN,BLUE,  .7),
  700:Color.fromRGBO(RED,GREEN,BLUE,  .8),
  800:Color.fromRGBO(RED,GREEN,BLUE, .9),
  900:Color.fromRGBO(RED,GREEN,BLUE,  1),
};

class App extends StatefulWidget {
  const App() : super();
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  // final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinWallet',
      theme: ThemeData(
        primarySwatch: MaterialColor(HEX_COLOR, color),
        accentColor: Colors.tealAccent,
      ),
      // navigatorKey: Navigators.mainNav,
      // onGenerateRoute: _router.onGenerateRoute,
      // initialRoute: _router.initialRoute,
        routes: {
          HOME_ROUTE: (context) => AccountsHome(),
        },

      // navigatorObservers: [routeObserver],
    );
  }

  @override
  void dispose() {
    // _router.dispose();
    super.dispose();
  }
}
