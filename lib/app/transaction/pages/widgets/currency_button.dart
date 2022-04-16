
import 'package:finwallet_app/common/constants/colors.dart';
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
        clipBehavior: Clip.hardEdge,
        child: TextButton(
          onPressed: ()  {
            _navigateAndSelectCurrency(context);
          },
          style: TextButton.styleFrom(
            elevation: 0,

            backgroundColor: SECONDARY_COLOR,
            shape: CircleBorder(

              // side: BorderSide(
              //   color: Colors.black,
              //   width: 2
              // )
            ),
            padding: EdgeInsets.all(20),
          ),
          child: Text(
            this.value.code,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),
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
