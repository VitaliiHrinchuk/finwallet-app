import 'package:finwallet_app/app/account/pages/widgets/create_account_form.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:finwallet_app/common/widgets/content_container.dart';
import 'package:finwallet_app/common/widgets/drawer_nav.dart';
import 'package:finwallet_app/common/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/account/account_bloc.dart';

class AccountEdit extends StatelessWidget {
  final AccountEditScreenArguments? arguments;

  bool get isEdit => this.arguments?.id != null;

  AccountEdit({
    this.arguments
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: MainAppBar(
          title: this.isEdit ? 'Edit Account' : 'Create An Account',
          canGoBack: true
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          child: ContentContainer(
            child: BlocProvider(
              create: (_) => di<AccountBloc>(),
              child: BlocListener<AccountBloc, AccountState>(
                listener: (context, state) {
                  // if (state is AccountError) {
                  //   showFloatSnackBar(context, state.error ?? "Unknown error");
                  // } else if (state is AccountLoaded) {
                  //   Navigator.pushNamed(context, HOME_ROUTE);
                  // }
                },
                child: CreateAccountForm(),
              ),
            ),
          ),
        ),
      ),
    );;
  }
}


class AccountEditScreenArguments {
  final String? id;

  AccountEditScreenArguments({
    this.id
  });
}