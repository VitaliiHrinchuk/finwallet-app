import 'package:finwallet_app/app/auth/cubit/auth_form_cubit.dart';
import 'package:finwallet_app/common/dependencies.dart';
import '../../../common/widgets/layout/content_container.dart';
import '../../../common/widgets/app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './widgets/signup_form.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: 'Create your account',
        canGoBack: true,
      ),
      body: SafeArea(
          child: Container(
              padding: const EdgeInsets.all(10),
              child: ContentContainer(
                child: BlocProvider(
                  create: (_) => di<AuthFormCubit>(),
                  child: SignupForm(),
                ),
              )
          )
      ),
    );
  }
}
