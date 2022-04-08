import 'package:finwallet_app/app/account/bloc/account/account_bloc.dart';
import 'package:finwallet_app/app/account/cubit/list/accounts_list_cubit.dart';
import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/app/auth/bloc/auth/auth_bloc.dart';
import 'package:finwallet_app/app/category/cubit/list/category_list_cubit.dart';
import 'package:finwallet_app/app/category/domain/category_entity.dart';
import 'package:finwallet_app/app/transaction/cubit/form/transaction_form_cubit.dart';
import 'package:finwallet_app/app/transaction/cubit/math_pad/math_pad_cubit.dart';
import 'package:finwallet_app/app/transaction/cubit/transaction/transaction_cubit.dart';
import 'package:finwallet_app/app/transaction/domain/transaction_entity.dart';
import 'package:finwallet_app/app/transaction/dto/create_transaction_dto.dart';
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
import 'package:finwallet_app/common/utils/snackbar.dart';
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
    return  MultiBlocProvider(
      providers: [
        BlocProvider<TransactionFormCubit>(create: (context) {
          TransactionFormCubit cubit = di<TransactionFormCubit>();
          String? baseCurrency = (context.read<AuthBloc>().state as AuthAuthenticated)
                  .user
                  .baseCurrency!.code;


          if (baseCurrency != null) {
            Currency currency = CURRENCIES.firstWhere((element) => element.code == baseCurrency);
            cubit.init(currency);
          }
          AccountEntity account = context.read<AccountsListCubit>().state.entities.first;


          if (cubit.state.type == TransactionType.CRE) {
            CategoryEntity category = context.read<CategoryListCubit>().state.creditEntities.first;
            cubit.setCategory(category);
          } else {
            CategoryEntity category = context.read<CategoryListCubit>().state.debitEntities.first;
            cubit.setCategory(category);
          }

          cubit.setAccount(account);

          return cubit;
        }),
        BlocProvider.value(value: _mathPad),
        BlocProvider<TransactionCubit>(
            create: (context) => di<TransactionCubit>()
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: MainDrawer(),
        appBar: MainAppBar(
            title: 'New Record',
            canGoBack: true,
            actions: [
              BlocBuilder<TransactionFormCubit, TransactionFormState>(
                builder: (context, state) {
                  return IconButton(
                      onPressed: () => this.saveTransaction(context),
                      icon: Icon(Icons.check)
                  );
                },
              )
            ],
        ),
        extendBodyBehindAppBar: true,
        body: SafeArea(
          child: MultiBlocListener(
              listeners: [
                BlocListener<CategoryListCubit, CategoryListState>(
                  listener: (context, state) {
                    if (state.loaded) {
                      context
                          .read<TransactionFormCubit>()
                          .setCategory(state.entities.first);
                    }
                  },
                ),
                BlocListener<TransactionFormCubit, TransactionFormState>(
                  listenWhen: (previousState, currentState) {
                    return previousState.type != currentState.type;
                  },
                  listener: (context, state) {
                    TransactionFormCubit transactionCubit = context.read<TransactionFormCubit>();
                    if (transactionCubit.state.type == TransactionType.CRE) {
                      CategoryEntity category = context.read<CategoryListCubit>().state.creditEntities.first;
                      transactionCubit.setCategory(category);
                    } else {
                      CategoryEntity category = context.read<CategoryListCubit>().state.debitEntities.first;
                      transactionCubit.setCategory(category);
                    }
                  },
                ),
                BlocListener<TransactionCubit, TransactionState>(
                  listener: (context, state) {
                    if (state is TransactionLoaded) {
                      Navigator.pop(context);
                      context.read<AccountsListCubit>().loadAccounts();
                      showFloatSnackBar(context, "Transaction created");
                    }
                  },
                ),
              ],
              child: Column(
                children: [
                  SizedBox(height: 10,),
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

  void saveTransaction(context) {
    MathPadCubit mathPad = BlocProvider.of<MathPadCubit>(context)..prepare();
    BlocProvider.of<TransactionFormCubit>(context).setAmount(
        double.parse(mathPad.state.result)
    );
    CreateTransactionDto? dto = BlocProvider.of<TransactionFormCubit>(context).toDTO();
    if (dto != null) {
      BlocProvider.of<TransactionCubit>(context).create(dto);
    }
  }
}
