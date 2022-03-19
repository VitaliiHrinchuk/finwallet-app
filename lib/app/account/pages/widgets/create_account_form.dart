import 'dart:math';

import 'package:finwallet_app/app/account/bloc/account/account_bloc.dart';
import 'package:finwallet_app/app/account/cubit/form/account_form_cubit.dart';
import 'package:finwallet_app/app/account/usecases/create_account.dart';
import 'package:finwallet_app/common/constants/currencies.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:finwallet_app/common/widgets/currency_picker.dart';
import 'package:finwallet_app/common/widgets/loading_button_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const List<String> RANDOM_COLORS = [
  '304ffe',
  'aa00ff',
  '00c853'
];

class CreateAccountForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return BlocProvider(
          create: (_) => di<AccountFormCubit>(),
          child: Container(
            child: Form(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      BlocBuilder<AccountFormCubit, AccountFormState>(
                          builder: (formContext, formState) {
                            return TextFormField(
                              keyboardType: TextInputType.text,
                              initialValue: formState.name,
                              enableSuggestions: false,
                              autocorrect: false,
                              onChanged: (value) {
                                formContext.read<AccountFormCubit>().setName(
                                    value);
                              },
                              decoration: InputDecoration(
                                  errorText: (state is AccountValidationError)
                                      ? state.errors["name"]
                                      : null,
                                  labelText: "Name",
                                  // errorText: ,
                                  border: OutlineInputBorder()
                              ),
                            );
                          }),
                      SizedBox(
                        height: 18,
                      ),
                      BlocBuilder<AccountFormCubit, AccountFormState>(
                          builder: (formContext, formState) {
                            return TextFormField(
                              keyboardType: TextInputType.number,
                              initialValue: formState.name,
                              enableSuggestions: false,
                              autocorrect: false,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                formContext.read<AccountFormCubit>().setAmount(
                                    double.parse(value)
                                );
                              },
                              decoration: InputDecoration(
                                  errorText: (state is AccountValidationError)
                                      ? state.errors["amount"]
                                      : null,
                                  labelText: "Amount",
                                  // errorText: ,
                                  border: OutlineInputBorder()
                              ),
                            );
                          }
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      BlocBuilder<AccountFormCubit, AccountFormState>(
                          builder: (formContext, formState) {

                            return CurrencyPicker(
                                label: "Base Currency",
                                onSelect: (Currency? currency) =>
                                    formContext
                                        .read<AccountFormCubit>()
                                        .setCurrency(currency),
                                errorText: (state is AccountValidationError)
                                            ? state.errors["currency"]
                                            : null,
                                value: formState.currency
                            );
                          }),
                      Expanded(child: Container()),
                      BlocBuilder<AccountFormCubit, AccountFormState>(
                        builder: (formContext, formState) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                dispatchCreateAccount(context, formState);
                              },
                              child: getButtonChild(state),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10)
                    ])
            ),
          ),
        );
      },
    );
  }


  Widget getButtonChild(AccountState state) {
    if (state is AccountLoading) {
      return LoadingButtonContent();
    }
    return Text("SAVE");
  }

  void dispatchCreateAccount(context, AccountFormState state) {
    final _random = new Random();

    BlocProvider.of<AccountBloc>(context).add(AccountCreate(
      name: state.name,
      amount: state.amount,
      currency: state.currency?.code,
      hexColor: RANDOM_COLORS[_random.nextInt(RANDOM_COLORS.length)],
    ));
  }
}
