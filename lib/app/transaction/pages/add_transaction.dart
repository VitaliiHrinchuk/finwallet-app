import 'package:finwallet_app/app/account/bloc/account/account_bloc.dart';
import 'package:finwallet_app/app/account/cubit/list/accounts_list_cubit.dart';
import 'package:finwallet_app/app/auth/bloc/auth/auth_bloc.dart';
import 'package:finwallet_app/app/transaction/cubit/form/transaction_form_cubit.dart';
import 'package:finwallet_app/app/transaction/cubit/math_pad/math_pad_cubit.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/currency_button.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/num_pad.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/num_pad_value.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/secondary_toolbar.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/setting_section.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/toolbar.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/transaction_type_toggler.dart';
import 'package:finwallet_app/app/user/bloc/user/user_bloc.dart';
import 'package:finwallet_app/common/constants/currencies.dart';
import 'package:finwallet_app/common/dependencies.dart';
import 'package:finwallet_app/common/widgets/app_bar/main_app_bar.dart';
import 'package:finwallet_app/common/widgets/drawer/drawer_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransaction extends StatefulWidget {
  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final MathPadCubit _mathPad = di<MathPadCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MainDrawer(),
      appBar: MainAppBar(title: 'New Record', canGoBack: true),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider<TransactionFormCubit>(create: (context) {
              String? baseCurrency =
                  (context.read<AuthBloc>().state as AuthAuthenticated)
                      .user
                      .baseCurrency;

              print(baseCurrency);
              if (baseCurrency != null) {
                Currency currency = CURRENCIES
                    .firstWhere((element) => element.code == baseCurrency);
                return di<TransactionFormCubit>()..init(currency);
              }

              return di<TransactionFormCubit>();
            }),
            BlocProvider.value(value: _mathPad),
            BlocProvider<AccountsListCubit>(
                create: (context) => di<AccountsListCubit>()..loadAccounts()),
          ],
          child: BlocListener<AccountsListCubit, AccountsListState>(
            listener: (context, state) {
              if (state.loaded) {
                context.read<TransactionFormCubit>().setAccount(state.entities.first);
              }
            },
            child: Column(
              children: [
                TransactionTypeToggler(),
                Expanded(child: Container()),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(child: BlocBuilder<MathPadCubit, MathPadState>(
                        builder: (context, state) {
                          return NumPadValue(state.result);
                        },
                      )),
                      BlocBuilder<TransactionFormCubit, TransactionFormState>(
                        builder: (context, state) {
                          return CurrencyButton(
                            value: state.currency,
                            onChange: (Currency currency) {
                              context
                                  .read<TransactionFormCubit>()
                                  .setCurrency(currency);
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  height: 1,
                ),
                SecondaryToolbar(),
                Divider(
                  color: Colors.grey.shade300,
                  height: 1,
                ),
                ToolBar(),
                Divider(
                  color: Colors.grey.shade300,
                  height: 1,
                ),
                NumPad(
                  onButtonTap: (String value) {
                    _mathPad.addValue(value);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mathPad.close();
    super.dispose();
  }
}
