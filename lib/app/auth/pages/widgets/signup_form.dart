import 'package:finwallet_app/app/auth/bloc/auth/auth_bloc.dart';
import 'package:finwallet_app/app/auth/cubit/auth_form_cubit.dart';
import '../../../../common/widgets/input/main_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignupForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          child: Form(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    BlocBuilder<AuthFormCubit, AuthFormState>(
                        builder: (formContext, formState) {
                          return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            initialValue: formState.email,

                            onChanged: (value) {
                              formContext.read<AuthFormCubit>().setEmail(value);
                            },
                            decoration: MainInputDecoration(
                                errorText: (state is AuthValidationError) ? state.errors["email"]  : null,
                                labelText: "Email",
                            ),
                          );
                        }
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    BlocBuilder<AuthFormCubit, AuthFormState>(
                      builder: (formContext, formState) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          initialValue: formState.password,
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: true,
                          onChanged: (value) {
                            formContext.read<AuthFormCubit>().setPassword(value);
                          },
                          decoration: MainInputDecoration(
                              errorText: (state is AuthValidationError) ? state.errors["password"]  : null,
                              labelText: "Password",
                              // errorText: ,
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    BlocBuilder<AuthFormCubit, AuthFormState>(
                      builder: (formContext, formState) {
                        return TextFormField(
                          keyboardType: TextInputType.text,
                          initialValue: formState.confirmPassword,
                          enableSuggestions: false,
                          autocorrect: false,
                          obscureText: true,
                          onChanged: (value) {
                            formContext.read<AuthFormCubit>().setConfirmPassword(value);
                          },
                          decoration: MainInputDecoration(
                              errorText: (state is AuthValidationError) ? state.errors["confirmPassword"]  : null,
                              labelText: "Confirm Password",
                          ),
                        );
                      },
                    ),
                    Expanded(child: Container()),
                    BlocBuilder<AuthFormCubit, AuthFormState>(
                      builder: (formContext, formState) {
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => dispatchAttemptLogin(
                                context,
                                formState.email,
                                formState.password,
                                formState.confirmPassword
                            ),
                            child: getButtonChild(state),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10)
                  ])
          ),
        );
      },
    );
  }

  Widget getButtonChild(AuthState state) {
    if (state is AuthLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
    return Text("SignUp");
  }

  void dispatchAttemptLogin(context, String email, String password, String confirmPassword) {
    BlocProvider.of<AuthBloc>(context).add(AuthAttemptSignup(email, password, confirmPassword));
  }
}
