import 'package:finwallet_app/app/account/domain/analytics_models/category_node_model.dart';
import 'package:finwallet_app/app/category/utils/category_icon_settings.dart';
import 'package:finwallet_app/app/category/utils/default_categories_list.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';


class TransactionsByCategoryChart extends StatefulWidget {
  final List<CategoryNodeModel> nodes;

  TransactionsByCategoryChart(this.nodes);

  @override
  State<TransactionsByCategoryChart> createState() => _TransactionsByCategoryChartState();
}

class _TransactionsByCategoryChartState extends State<TransactionsByCategoryChart> {
  SelectionBehavior? selectionBehavior = SelectionBehavior(enable: true);
  CategoryNodeModel? selected;

  @override
  Widget build(BuildContext context) {


    double sum = _calculateTotal();

    return Container(
      child: SfCircularChart(
          onSelectionChanged: (SelectionArgs args) {

            setState(() {
              CategoryNodeModel newSelected = this.widget.nodes[args.pointIndex];
              if (selected != null && selected?.name == newSelected.name) {
                selected = null;
              } else {
                selected = this.widget.nodes[args.pointIndex];
              }

            });
          },
          annotations: <CircularChartAnnotation>[

            CircularChartAnnotation(
                widget: Text(
                    sum.toStringAsFixed(2) + " USD",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                )
            )
          ],
          // legend: Legend(
          //     isVisible:  true,
          //     overflowMode: LegendItemOverflowMode.wrap,
          //   position: LegendPosition.bottom
          // ),
          series: <DoughnutSeries<CategoryNodeModel, String>>[
            DoughnutSeries<CategoryNodeModel, String>(
                radius: '90%',
                explode: true,
                explodeOffset: '20%',
                innerRadius: '60%',
                dataSource: this.widget.nodes,
                xValueMapper: (CategoryNodeModel data, _) => data.name,
                yValueMapper: (CategoryNodeModel data, _) => double.parse(data.sum.toStringAsFixed(2)),
                dataLabelMapper: (CategoryNodeModel data, _) => data.name,
                pointColorMapper: (CategoryNodeModel data, _) {
                  CategoryIconSettings settings =
                    DEFAULT_CATEGORIES_ICONS.containsKey(data.slug)
                        ? DEFAULT_CATEGORIES_ICONS[data.slug]!
                        : DEFAULT_CATEGORIES_ICONS['other']!;

                  return settings.color;
                },
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

  double _calculateTotal() {
    double sum = 0;

    if (this.selected != null) {
      return this.selected!.sum;
    }

    this.widget.nodes.forEach((element) => sum += element.sum);

    return sum;
  }
}
