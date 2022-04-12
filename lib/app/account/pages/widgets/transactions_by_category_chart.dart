import 'package:finwallet_app/app/account/domain/analytics_models/category_node_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class TransactionsByCategoryChart extends StatelessWidget {
  SelectionBehavior? selectionBehavior = SelectionBehavior(enable: true);
  final List<CategoryNodeModel> nodes;

  TransactionsByCategoryChart(this.nodes);

  @override
  Widget build(BuildContext context) {
    print(this.nodes);
    return Container(
      child: SfCircularChart(
          onSelectionChanged: (SelectionArgs args) {
            // print("dsadas");
            // print(this.nodes[args.pointIndex].name);

          },
          annotations: <CircularChartAnnotation>[

            CircularChartAnnotation(
                widget: const Text("22222 UAH")
            )
          ],
          // legend: Legend(
          //     isVisible:  true,
          //     overflowMode: LegendItemOverflowMode.wrap,
          //   position: LegendPosition.bottom
          // ),
          series: <DoughnutSeries<CategoryNodeModel, String>>[
            DoughnutSeries<CategoryNodeModel, String>(
                radius: '70%',
                explode: true,
                explodeOffset: '20%',
                innerRadius: '60%',
                dataSource: this.nodes,
                xValueMapper: (CategoryNodeModel data, _) => data.name,
                yValueMapper: (CategoryNodeModel data, _) => double.parse(data.sum.toStringAsFixed(2)),
                dataLabelMapper: (CategoryNodeModel data, _) => data.name,
                dataLabelSettings: const DataLabelSettings(
                    overflowMode: OverflowMode.hide,
                    isVisible: true,
                  labelPosition: ChartDataLabelPosition.outside
                ),
                selectionBehavior: selectionBehavior
            )
          ]),
    );
  }
}
