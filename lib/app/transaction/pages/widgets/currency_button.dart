
import 'package:finwallet_app/common/constants/currencies.dart';
import 'package:finwallet_app/common/pages/currency_select.dart';
import 'package:flutter/material.dart';

class CurrencyButton extends StatelessWidget {

  final Currency value;
  final Function(Currency currency) onChange;

  CurrencyButton({
    required this.value,
    required this.onChange
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: FittedBox(
        child: TextButton(
          onPressed: ()  {
            _navigateAndSelectCurrency(context);
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary
              )
            ),
            padding: EdgeInsets.all(20),
          ),
          child: Text(
            this.value.code,
          ),
        ),
      ),
    );
  }

  void _navigateAndSelectCurrency(BuildContext context) async {

    final String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (childContext) {
        return CurrencySelect();
      }),
    );

    Currency currency = CURRENCIES.firstWhere((element) => element.code == result);

    this.onChange(currency);
  }
}
