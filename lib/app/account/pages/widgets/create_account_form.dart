import 'dart:math';

import 'package:finwallet_app/app/account/bloc/account/account_bloc.dart';
import 'package:finwallet_app/app/account/cubit/form/account_form_cubit.dart';
import 'package:finwallet_app/app/account/usecases/create_account.dart';
import 'package:finwallet_app/common/constants/currencies.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:finwallet_app/common/utils/hex_to_color_widget.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../../../common/widgets/input/currency_picker.dart';
import 'package:finwallet_app/common/widgets/loading_button_content.dart';
import '../../../../common/widgets/input/main_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'account_color_picker.dart';

class CreateAccountForm extends StatelessWidget {
  final String? name;
  final double? amount;
  final Currency? currency;
  final String? hexColor;
  final bool isEdit;
  final String? id;

  CreateAccountForm({
    this.name,
    this.amount,
    this.currency,
    this.hexColor,
    required this.isEdit,
    this.id
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return BlocProvider(
          create: (_) {
            AccountFormCubit form = di<AccountFormCubit>();

            if (this.name != null) {
              form.setName(this.name);
            }
            if (this.amount != null) {
              print(this.amount);
              form.setAmount(this.amount);
            }
            if (this.currency != null) {
              form.setCurrency(this.currency);
            }
            if (this.hexColor != null) {

              form.setHexColor(hexToColorWidget(this.hexColor!));
            }


            return form;
          },
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
                              decoration: MainInputDecoration(
                                errorText: (state is AccountValidationError)
                                    ? state.errors["name"]
                                    : null,
                                labelText: "Name",
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
                              initialValue: formState.amount?.toStringAsFixed(
                                  2),
                              enableSuggestions: false,
                              autocorrect: false,
                              readOnly: this.isEdit,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (value) {
                                formContext.read<AccountFormCubit>().setAmount(
                                    double.parse(value)
                                );
                              },
                              decoration: MainInputDecoration(
                                errorText: (state is AccountValidationError)
                                    ? state.errors["amount"]
                                    : null,
                                labelText: "Amount",
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
                                readOnly: this.isEdit,
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
                      SizedBox(
                        height: 18,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          "Pick A Color",
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleMedium,
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      BlocBuilder<AccountFormCubit, AccountFormState>(
                        builder: (formContext, state) {
                          Color? initialValue = state.color != null
                              ? state.color
                              : null;
                          return AccountColorPicker(
                            initialValue: initialValue,
                            onChange: (Color? color) {
                              formContext
                                  .read<AccountFormCubit>()
                                  .setHexColor(color);
                            } ,
                          );
                        },
                      ),
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
                      SizedBox(height: 10),
                    ]
                )
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
    if (this.isEdit) {
      BlocProvider.of<AccountBloc>(context).add(AccountUpdate(
        name: state.name,
        id: this.id!,
        hexColor: state.color != null ? widgetColorToHex(state.color!) : null,
      ));
    } else {
      BlocProvider.of<AccountBloc>(context).add(AccountCreate(
        name: state.name,
        amount: state.amount,
        currency: state.currency?.code,
        hexColor: state.color != null ? widgetColorToHex(state.color!) : null,
      ));
    }

  }
}
