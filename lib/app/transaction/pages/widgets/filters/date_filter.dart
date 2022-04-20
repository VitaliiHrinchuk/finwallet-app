import 'package:finwallet_app/common/widgets/input/main_input_decoration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFilter extends StatelessWidget {

  final DateTime startDate;
  final DateTime endDate;
  final Function(DateTime date) onStartDateChange;
  final Function(DateTime date) onEndDateChange;
  final _endDateController = TextEditingController();
  final _startDateController = TextEditingController();

  DateFilter({
    required this.startDate,
    required this.endDate,
    required this.onEndDateChange,
    required this.onStartDateChange
  });

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    _startDateController.text = dateFormat.format(startDate);
    _endDateController.text = dateFormat.format(endDate);

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _startDateController,
            readOnly: true,
            onTap: () async {
              DateTime? date = await _showDatePicker(context);
              if (date != null) {
                this.onStartDateChange(date);
              }
            },
            decoration: MainInputDecoration(
              labelText: "Start Date",
              // errorText: ,
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            controller: _endDateController,
            readOnly: true,
            onTap: () async {
              DateTime? date = await _showDatePicker(context);
              if (date != null) {
                this.onEndDateChange(date);
              }
            },
            decoration: MainInputDecoration(
              labelText: "End Date",
              // errorText: ,
            ),
          ),
        ),
      ],
    );
  }

  Future<DateTime?> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101)
    );

    return picked;
  }
}
