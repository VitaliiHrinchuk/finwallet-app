import 'package:finwallet_app/app/account/domain/analytics_models/date_node_model.dart';
import 'package:finwallet_app/common/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class TransactionsByRangeChart extends StatelessWidget {

  final List<DateNodeModel> nodes;
  TooltipBehavior? _tooltipBehavior = TooltipBehavior(
      enable: true,
      header: null
  );

  TransactionsByRangeChart(this.nodes);

  @override
  Widget build(BuildContext context) {
    print(this.nodes.first.date.toIso8601String());
    return Container(
      child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          tooltipBehavior: _tooltipBehavior,
          primaryYAxis: NumericAxis(isVisible: false),
          primaryXAxis: DateTimeCategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
              interval: 1,
              plotBands: <PlotBand>[

                PlotBand(
                    isVisible: true,
                    textAngle: 0,
                    start: DateTime.now(),
                    end: this.nodes.last.date,
                    verticalTextAlignment: TextAnchor.start,
                    verticalTextPadding: '%-5',
                    color: PRIMARY_COLOR,
                    opacity: 0.2),
              ]
          ),
          series: <ColumnSeries<DateNodeModel, DateTime>>[
            ColumnSeries<DateNodeModel, DateTime>(
              dataSource: nodes,
              xValueMapper: (DateNodeModel data, _) => data.date,
              yValueMapper: (DateNodeModel data, _) => data.sum,
              pointColorMapper: (_, __) => Colors.black,
            )
          ]),
    );
  }
}
