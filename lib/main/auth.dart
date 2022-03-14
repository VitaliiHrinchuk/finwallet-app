import 'package:finwallet_app/app/auth/cubit/auth_form_cubit.dart';
import 'package:finwallet_app/app/auth/pages/signup.dart';
import 'package:finwallet_app/app/auth/pages/widgets/auth_form.dart';
import 'package:finwallet_app/app/auth/pages/widgets/logo.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Auth extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: '/auth',
      routes: {
        '/signup': (context) => Signup(),
        '/auth': (context) => Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: const EdgeInsets.only(left: 17, right: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Logo(),
                        BlocProvider(
                          create: (_) => di<AuthFormCubit>(),
                          child: AuthForm(),
                        ),
                        SizedBox(height: 30),
                        Text("New to the app?",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black.withOpacity(.6))),
                        SizedBox(height: 8),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () =>
                                {Navigator.pushNamed(context, '/signup')},
                            child: Text("SIGN UP"),
                          ),
                        )
                      ],
                    ),
                  )),
            ))
      },
    );
  }
}
