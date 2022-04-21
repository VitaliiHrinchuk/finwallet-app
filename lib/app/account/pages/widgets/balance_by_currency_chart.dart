import 'package:finwallet_app/app/account/domain/analytics_models/currency_node_model.dart';
import 'package:finwallet_app/common/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BalanceByCurrencyChart extends StatelessWidget {

  final List<CurrencyNodeModel> models;

  BalanceByCurrencyChart(this.models);

  @override
  Widget build(BuildContext context) {
    double max = models.fold(0, (previous, CurrencyNodeModel current) => current.sum > previous ? current.sum : previous);
    double min = models.fold(0, (previous, CurrencyNodeModel current) => current.sum < previous ? current.sum : previous);
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          minorGridLines: const MinorGridLines(width: 0),
          majorTickLines: MajorTickLines(width: 0),
          minorTickLines: MinorTickLines(width: 0),
          axisLine: AxisLine(width: 0)
      ),
      primaryYAxis: NumericAxis(
          minimum: min,
          isVisible: false,
          maximum: max,
          axisLine: const AxisLine(width: 0),
          majorGridLines: const MajorGridLines(width: 0),
          majorTickLines: const MajorTickLines(size: 0)
      ),
      series: <ColumnSeries<CurrencyNodeModel, String>>[
        ColumnSeries<CurrencyNodeModel, String>(
            dataSource: models,

            /// We can enable the track for column here.
            isTrackVisible: true,
            trackColor: SECONDARY_COLOR,
            borderRadius: BorderRadius.circular(5),
            xValueMapper: (CurrencyNodeModel model, _) => model.currency.code,
            yValueMapper: (CurrencyNodeModel model, _) => double.parse(model.sum.toStringAsFixed(2)),
            dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.outer))
      ],
    );;
  }
}
