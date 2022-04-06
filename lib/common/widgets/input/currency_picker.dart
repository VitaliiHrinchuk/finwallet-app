import 'package:finwallet_app/common/pages/currency_select.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../constants/currencies.dart';
import 'main_input_decoration.dart';

class CurrencyPicker extends StatelessWidget {
  final String label;
  final Function(Currency? currency) onSelect;
  final Currency? value;
  final String? errorText;
  final bool readOnly;

  CurrencyPicker({
    this.label = 'Currency',
    required this.onSelect,
    required this.value,
    this.errorText,
    this.readOnly = false
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    controller.text = value != null ? value!.code + ' - ' + value!.name : "";
    return TextFormField(
      controller: controller,
      readOnly: true,
      enableSuggestions: false,
      autocorrect: false,
      onTap: () {
        if (!this.readOnly) {
          _navigateAndSelectCurrency(context);
        }

      },
      decoration: MainInputDecoration(
        labelText: this.label,
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

    this.onSelect(currency);
  }
}
