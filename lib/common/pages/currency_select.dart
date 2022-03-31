import 'package:finwallet_app/common/constants/currencies.dart';
import 'package:finwallet_app/common/widgets/app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';

class CurrencySelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        title: 'Select Currency',
        canGoBack: true,
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
          child: ListView.builder(
            itemCount: CURRENCIES.length,
            itemBuilder: (context, i) {
              Currency currency = CURRENCIES[i];

              return ListTile(
                title: Text(currency.code),
                subtitle: Text(currency.name),
                onTap: () {
                  Navigator.pop(context, currency.code);
                },
              );
            },
          )
      ),
    );
  }
}


