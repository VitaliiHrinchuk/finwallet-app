import 'package:finwallet_app/app/account/bloc/account/account_bloc.dart';
import 'package:finwallet_app/app/account/cubit/form/account_form_cubit.dart';
import 'package:finwallet_app/app/account/pages/widgets/create_account_form.dart';
import 'package:finwallet_app/app/auth/pages/widgets/logo.dart';
import 'package:finwallet_app/common/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/constants/routes.dart';
import '../../../common/dependencies.dart';

class AccountFirst extends StatelessWidget {
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
                  Padding(
                    padding: EdgeInsets.only(top: 40, bottom: 10),
                    child: Center(
                      child: Text(
                        "Create first account",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Center(
                      child: Text(
                        "Setup your first account in a few clicks!",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                      child: BlocProvider(
                        create: (_) => di<AccountBloc>(),
                        child: BlocListener<AccountBloc, AccountState>(
                          listener: (context, state) {
                            if (state is AccountError) {
                              showFloatSnackBar(context, state.error ?? "Unknown error");
                            } else if (state is AccountLoaded) {
                              print("created");
                              Navigator.pushReplacementNamed(context, HOME_ROUTE);
                            }
                          },
                          child: CreateAccountForm(
                            isEdit: false,
                          ),
                        ),
                      )
                  ),
                ],
              )
          )
      ),
    );;
  }
}
