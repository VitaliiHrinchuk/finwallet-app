import 'dart:io';

import 'package:finwallet_app/app/user/bloc/user/user_bloc.dart';
import 'package:finwallet_app/main/loading.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/auth/bloc/auth/auth_bloc.dart';
import 'common/constants/routes.dart';
import 'common/dependencies.dart';
import 'main/app.dart';
import 'main/auth.dart';
import 'package:http/http.dart' as http;
import './common/http_client/http_client.dart';

final GlobalKey<NavigatorState> navigator = new GlobalKey();

void errorInterceptor(int code, String message) {
  if (code == 401) {
    navigator.currentState?.pushReplacementNamed(LOGIN_ROUTE);
  }
}

void main() {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  di.registerLazySingleton<HttpClient>(() => HttpClient(
      baseUrl: '10.0.2.2',
      client: new http.Client(), errorInterceptor: errorInterceptor));
  runApp(Wrapper());
}

class Wrapper extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di<AuthBloc>()..add(AuthChecked())),
      ],
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            if (state.user.userConfigured) {
              navigator.currentState?.pushNamedAndRemoveUntil(HOME_ROUTE, (route) => false);
            } else {
              navigator.currentState?.pushNamedAndRemoveUntil(SETUP_USER_ROUTE, (route) => false);
            }
          } else if (state is AuthInitial) {
            navigator.currentState?.pushNamedAndRemoveUntil(LOGIN_ROUTE,  (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return this._buildApp(context, HOME_ROUTE);
          } else {
            return this._buildApp(context, LOGIN_ROUTE);
          }
        },
      ),
    );
  }

  Widget _buildApp(BuildContext context, String initialRoute) {
    return BlocProvider(
      create: (context) => di<UserBloc>(),
      child: App(initialRoute: initialRoute, navigationKey: navigator),
    );
  }
}
