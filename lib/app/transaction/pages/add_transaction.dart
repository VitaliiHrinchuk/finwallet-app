import 'package:finwallet_app/app/transaction/cubit/math_pad/math_pad_cubit.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/currency_button.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/num_pad.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/num_pad_value.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/secondary_toolbar.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/setting_section.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/toolbar.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/transaction_type_toggler.dart';
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
      appBar: MainAppBar(title: '', canGoBack: true),
      extendBodyBehindAppBar: true,
      body: SafeArea(

        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: _mathPad)
          ],
          child: Column(
            children: [
              TransactionTypeToggler(),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.only(right: 5),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                        child: BlocBuilder<MathPadCubit, MathPadState>(
                          builder: (context, state) {
                            return NumPadValue(state.result);
                          },
                        )
                    ),
                    CurrencyButton()
                  ],
                ),
              ),
              Divider(color: Colors.grey.shade300, height: 1,),
              SecondaryToolbar(),
              Divider(color: Colors.grey.shade300, height: 1,),
              ToolBar(),
              Divider(color: Colors.grey.shade300, height: 1,),
              NumPad(onButtonTap: (String value) {
                _mathPad.addValue(value);
              },)
            ],
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
