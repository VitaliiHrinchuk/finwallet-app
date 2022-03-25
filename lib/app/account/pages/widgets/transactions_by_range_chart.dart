import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChartSampleData {
  final DateTime x;
  final double yValue;

  ChartSampleData({required this.x, required this.yValue});
}

class TransactionsByRangeChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          primaryXAxis: DateTimeCategoryAxis(
              majorGridLines: const MajorGridLines(width: 0),
              plotBands: <PlotBand>[
                //@todo spend
                // PlotBand(
                //     isVisible: true,
                //     start: DateTime(2015, 12, 22),
                //     end: DateTime(2017, 12, 27),
                //     textAngle: 0,
                //     verticalTextAlignment: TextAnchor.start,
                //     verticalTextPadding: '%-5',
                //     text: 'Christmas Offer \nDec 2017',
                //     color: const Color.fromRGBO(50, 198, 255, 1),
                //     opacity: 0.3),
                // PlotBand(
                //     isVisible: true,
                //     textAngle: 0,
                //     start: DateTime(2018, 1, 2),
                //     end: DateTime(2018, 1, 4),
                //     verticalTextAlignment: TextAnchor.start,
                //     verticalTextPadding: '%-5',
                //     text: 'New Year Offer \nJan 2018',
                //
                //     color: Colors.pink,
                //     opacity: 0.2),
              ]),
          series: <ColumnSeries<ChartSampleData, DateTime>>[
            ColumnSeries<ChartSampleData, DateTime>(
              dataSource: <ChartSampleData>[
                ChartSampleData(x: DateTime(2015, 1, 1), yValue: 1.13),
                ChartSampleData(x: DateTime(2015, 2, 1), yValue: 1.12),
                ChartSampleData(x: DateTime(2015, 3, 1), yValue: 1.08),
                ChartSampleData(x: DateTime(2015, 4, 1), yValue: 1.12),
                ChartSampleData(x: DateTime(2015, 5, 1), yValue: 1.1),
                ChartSampleData(x: DateTime(2015, 6, 1), yValue: 1.12),
                ChartSampleData(x: DateTime(2015, 7, 1), yValue: 1.1),
                ChartSampleData(x: DateTime(2015, 8, 1), yValue: 1.12),
                ChartSampleData(x: DateTime(2015, 9, 1), yValue: 1.12),
                ChartSampleData(x: DateTime(2015, 10, 1), yValue: 1.1),
                ChartSampleData(x: DateTime(2015, 11, 1), yValue: 1.06),
                ChartSampleData(x: DateTime(2015, 12, 1), yValue: 1.09),
                ChartSampleData(x: DateTime(2015, 1, 1), yValue: 1.09),
                ChartSampleData(x: DateTime(2015, 2, 1), yValue: 1.09),
                ChartSampleData(x: DateTime(2015, 3, 1), yValue: 1.14),
                ChartSampleData(x: DateTime(2015, 4, 1), yValue: 1.14),
                ChartSampleData(x: DateTime(2015, 5, 1), yValue: 1.12),
                ChartSampleData(x: DateTime(2015, 6, 1), yValue: 1.11),
                ChartSampleData(x: DateTime(2015, 7, 1), yValue: 1.11),
                ChartSampleData(x: DateTime(2015, 8, 1), yValue: 1.11),
                ChartSampleData(x: DateTime(2015, 9, 1), yValue: 1.12),
                ChartSampleData(x: DateTime(2015, 10, 1), yValue: 1.1),
                ChartSampleData(x: DateTime(2015, 11, 1), yValue: 1.08),
                ChartSampleData(x: DateTime(2015, 12, 1), yValue: 1.05),
                ChartSampleData(x: DateTime(2015, 1, 1), yValue: 1.08),
                ChartSampleData(x: DateTime(2015, 2, 1), yValue: 1.06),
                ChartSampleData(x: DateTime(2015, 3, 1), yValue: 1.07),
                ChartSampleData(x: DateTime(2015, 4, 1), yValue: 1.09),
                ChartSampleData(x: DateTime(2015, 5, 1), yValue: 1.12),
                ChartSampleData(x: DateTime(2015, 6, 1), yValue: 1.14),
                ChartSampleData(x: DateTime(2015, 7, 1), yValue: 1.17),
                ChartSampleData(x: DateTime(2017, 8, 1), yValue: 1.18),
                ChartSampleData(x: DateTime(2017, 9, 1), yValue: 1.18),
                ChartSampleData(x: DateTime(2017, 10, 1), yValue: 1.16),
                ChartSampleData(x: DateTime(2017, 11, 1), yValue: 1.18),
                ChartSampleData(x: DateTime(2017, 12, 1), yValue: 1.2),
                ChartSampleData(x: DateTime(2018, 1, 1), yValue: 1.25),
                ChartSampleData(x: DateTime(2018, 2, 1), yValue: 1.22),
                ChartSampleData(x: DateTime(2018, 3, 1), yValue: 1.23),
                ChartSampleData(x: DateTime(2018, 4, 1), yValue: 1.21),
                ChartSampleData(x: DateTime(2018, 5, 1), yValue: 1.17),
                ChartSampleData(x: DateTime(2018, 6, 1), yValue: 1.17),
                ChartSampleData(x: DateTime(2018, 7, 1), yValue: 1.17),
                ChartSampleData(x: DateTime(2018, 8, 1), yValue: 1.17),
                ChartSampleData(x: DateTime(2018, 9, 1), yValue: 1.16),
                ChartSampleData(x: DateTime(2018, 10, 1), yValue: 1.13),
                ChartSampleData(x: DateTime(2018, 11, 1), yValue: 1.14),
                ChartSampleData(x: DateTime(2018, 12, 1), yValue: 1.15)
              ],
              xValueMapper: (ChartSampleData data, _) => data.x,
              yValueMapper: (ChartSampleData data, _) => data.yValue,
       
            )
          ]),
    );
  }
}
