import 'package:finwallet_app/app/auth/cubit/auth_form_cubit.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './widgets/signup_form.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
              padding: const EdgeInsets.only(left: 17, right: 17),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 40, bottom: 40, left: 0),
                      child: Text(
                          "Create your account",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                  ),
                  Expanded(child: BlocProvider(
                    create: (_) => di<AuthFormCubit>(),
                    child: SignupForm(),
                  ))
                ],
              )
          )
      ),
    );
  }
}
