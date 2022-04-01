import 'package:finwallet_app/common/constants/currencies.dart';
import 'package:finwallet_app/common/widgets/app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';

class CurrencySelect extends StatefulWidget {
  @override
  State<CurrencySelect> createState() => _CurrencySelectState();
}

class _CurrencySelectState extends State<CurrencySelect> {

  String query = "";

  @override
  Widget build(BuildContext context) {

    List<Currency> filtered = [];

    if (this.query == '') {
      filtered = CURRENCIES;
    } else {
      filtered = CURRENCIES.where(
              (Currency element) {
                return element.name.toLowerCase().contains(this.query)
                    || element.code.toLowerCase().contains(this.query);
              }).toList();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(
        title: 'Select Currency',
        canGoBack: true,
        enableSearch: true,
        onSearchChanged: (String value) {
          setState(() {
            query = value;
          });
        },
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, i) {
              Currency currency = filtered[i];

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


