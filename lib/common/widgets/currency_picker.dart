import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../constants/currencies.dart';
import 'main_input_decoration.dart';

class CurrencyPicker extends StatelessWidget {
  final String label;
  final Function(Currency? currency) onSelect;
  final Currency? value;
  final String? errorText;

  final TextEditingController _typeAheadController = TextEditingController();

  CurrencyPicker({
    this.label = 'Currency',
    required this.onSelect,
    required this.value,
    this.errorText
  });

  @override
  Widget build(BuildContext context) {
    print("null ${this.value}");
    if (this.value != null) {
      this._typeAheadController.text = "${value!.name} - ${value!.code}";
    } else {

      this._typeAheadController.text = "";
    }
    return TypeAheadFormField<Currency>(
      textFieldConfiguration: TextFieldConfiguration(
          controller: this._typeAheadController,
          decoration: MainInputDecoration(
            labelText: this.label,
            errorText: this.errorText,
            suffixIcon: IconButton(
              onPressed: () {
                this.onSelect(null);
              },
              icon: Icon(Icons.clear),
            ),
          ),

      ),
      suggestionsCallback: (String pattern) {
        List<Currency> items =
        CURRENCIES.where((Currency currency) {
          bool nameContains = currency.name
              .toUpperCase()
              .contains(pattern.toUpperCase());

          bool codeContains = currency.code
              .toUpperCase()
              .contains(pattern.toUpperCase());

          return nameContains || codeContains;
        }).toList();

        return items;
      },
      itemBuilder: (context, Currency suggestion) {
        return ListTile(
          title: Text(
              "${suggestion.name} - ${suggestion.code}"),
        );
      },
      transitionBuilder: (context, suggestionsBox, controller) {
        return suggestionsBox;
      },
      onSuggestionSelected: (Currency suggestion) {
        this.onSelect(suggestion);
      },
    );
  }
}
