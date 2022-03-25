import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChartSampleData {
  final String x;
  final double y;

  ChartSampleData({required this.x, required this.y});
}

class TransactionsByCategoryChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCircularChart(
          legend: Legend(
              isVisible:  true, overflowMode: LegendItemOverflowMode.wrap),
          series: <DoughnutSeries<ChartSampleData, String>>[
            DoughnutSeries<ChartSampleData, String>(
                radius: '80%',
                explode: true,
                explodeOffset: '10%',
                dataSource: <ChartSampleData>[
                  ChartSampleData(x: 'Chlorine', y: 55),
                  ChartSampleData(x: 'Sodium', y: 31),
                  ChartSampleData(x: 'Magnesium', y: 7.7),
                  ChartSampleData(x: 'Sulfur', y: 3.7),
                  ChartSampleData(x: 'Calcium', y: 1.2),
                  ChartSampleData(x: 'Others', y: 1.4),
                ],
                xValueMapper: (ChartSampleData data, _) => data.x as String,
                yValueMapper: (ChartSampleData data, _) => data.y,
                // dataLabelMapper: (ChartSampleData data, _) => data.text,
                dataLabelSettings: const DataLabelSettings(isVisible: true))
          ]),
    );
  }
}
