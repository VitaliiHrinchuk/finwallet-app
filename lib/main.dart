import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app/auth/bloc/auth/auth_bloc.dart';
import 'common/dependencies.dart';
import 'main/app.dart';
import 'main/auth.dart';


void main()  {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(Wrapper());
}

class Wrapper extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<Wrapper> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => di<AuthBloc>()..add(AuthChecked()),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated)
              return App();
            else
              return Auth();
          },
        ));
  }
}
