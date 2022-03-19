import 'package:finwallet_app/app/auth/cubit/auth_form_cubit.dart';
import 'package:finwallet_app/app/auth/pages/widgets/logo.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/auth_form.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        onPressed: () => Navigator.pushNamed(context, SIGN_UP_ROUTE),
                        child: Text("SIGN UP"),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }
}
