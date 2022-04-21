import 'package:finwallet_app/app/account/domain/account_entity.dart';
import 'package:finwallet_app/common/constants/colors.dart';
import 'package:finwallet_app/common/utils/hex_to_color_widget.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BalanceByAccountChart extends StatelessWidget {
  final List<AccountEntity> accounts;

  BalanceByAccountChart(this.accounts);

  @override
  Widget build(BuildContext context) {
    double max = accounts.fold(0, (previous, AccountEntity current) => current.amount > previous ? current.amount : previous);
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        labelAlignment: LabelAlignment.center,
        labelPosition: ChartDataLabelPosition.outside,
        majorGridLines: const MajorGridLines(width: 0),
        minorGridLines: const MinorGridLines(width: 0),
        majorTickLines: MajorTickLines(width: 0),
        minorTickLines: MinorTickLines(width: 0),
        axisLine: AxisLine(width: 0)
      ),
      primaryYAxis: NumericAxis(

          majorGridLines: const MajorGridLines(width: 0),
          minimum: 0,
          isVisible: false,
          maximum: max,
          majorTickLines: const MajorTickLines(size: 0)),
      series: <BarSeries<AccountEntity, String>>[
        BarSeries<AccountEntity, String>(
          dataSource: accounts,
          borderRadius: BorderRadius.circular(5),
          trackColor: SECONDARY_COLOR,

          /// If we enable this property as true,
          /// then we can show the track of series.
          isTrackVisible: true,
          dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.outer,

          ),
          xValueMapper: (AccountEntity entity, _) => entity.name,
          yValueMapper: (AccountEntity entity, _) => double.parse(entity.amount.toStringAsFixed(2)),
          pointColorMapper: (AccountEntity entity, _) => hexToColorWidget(entity.hexColor)
        ),
      ],
    );
  }
}
