import 'package:finwallet_app/app/transaction/pages/widgets/currency_button.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/num_pad.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/num_pad_value.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/secondary_toolbar.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/setting_section.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/toolbar.dart';
import 'package:finwallet_app/app/transaction/pages/widgets/transaction_type_toggler.dart';
import 'package:finwallet_app/common/widgets/app_bar/main_app_bar.dart';
import 'package:finwallet_app/common/widgets/drawer/drawer_nav.dart';
import 'package:flutter/material.dart';

class AddTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MainDrawer(),
      appBar: MainAppBar(title: '', canGoBack: true),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Column(
          children: [
            TransactionTypeToggler(),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: NumPadValue('152')),
                  CurrencyButton()
                ],
              ),
            ),
            SecondaryToolbar(),
            ToolBar(),
            NumPad()
          ],
        ),
      ),
    );
  }
}
