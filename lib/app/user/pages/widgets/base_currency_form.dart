import 'package:finwallet_app/app/user/bloc/user/user_bloc.dart';
import 'package:finwallet_app/app/user/cubit/user_setup_form_cubit.dart';
import 'package:finwallet_app/common/constants/currencies.dart';
import 'package:finwallet_app/common/utils/snackbar.dart';
import '../../../../common/widgets/input/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class BaseCurrencyForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlocBuilder<UserSetupFormCubit, UserSetupFormState>(
                    builder: (formContext, formState) {

                      return CurrencyPicker(
                          label: "Base Currency",
                          onSelect: (Currency? currency) =>
                              context
                                  .read<UserSetupFormCubit>()
                                  .setBaseCurrency(currency),
                          value: formState.baseCurrency);
                    }),
                SizedBox(
                  height: 18,
                ),
                Expanded(child: Container()),
                BlocBuilder<UserSetupFormCubit, UserSetupFormState>(
                  builder: (formContext, formState) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formState.baseCurrency != null) {
                            dispatchSetupUser(
                                context, formState.baseCurrency!.code);
                          } else {
                            showFloatSnackBar(
                                context, "Please choose currency from list");
                          }
                        },
                        child: BlocBuilder<UserBloc, UserState>(
                          builder: (context, state) {
                            return getButtonChild(state);
                          },
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10)
              ])),
    );
  }

  Widget getButtonChild(UserState state) {
    if (state is UserLoading) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
    return Text("SAVE");
  }

  void dispatchSetupUser(context, String baseCurrency) {
    BlocProvider.of<UserBloc>(context)
        .add(UserSetup(baseCurrency: baseCurrency));
  }
}
