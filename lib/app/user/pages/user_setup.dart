import 'package:finwallet_app/app/auth/pages/widgets/logo.dart';
import 'package:finwallet_app/app/user/cubit/user_setup_form_cubit.dart';
import 'package:finwallet_app/app/user/pages/widgets/base_currency_form.dart';
import 'package:finwallet_app/common/constants/routes.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user/user_bloc.dart';

class SetupUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            color: Colors.white,
              padding: const EdgeInsets.only(left: 17, right: 17),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Logo(),
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 10),
                    child: Center(
                      child: Text(
                        "Select Base Currency",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Center(
                      child: Text(
                        "Please select the base currency to be used for analytics and statistics ",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                      child: BlocProvider(
                      create: (_) => di<UserSetupFormCubit>(),
                      child: BlocListener<UserBloc, UserState>(
                        listener: (context, state) {
                          if (state is UserIsSetup) {
                            Navigator.pushReplacementNamed(context, CREATE_ACCOUNT_ROUTE);
                          }
                        },
                        child: BaseCurrencyForm(),
                    ),
                  )),
                ],
              )
          )
      ),
    );

  }
}
