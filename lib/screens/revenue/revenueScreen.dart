import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RevenueScreen extends StatefulWidget {
  const RevenueScreen({Key? key}) : super(key: key);

  @override
  _RevenueScreenState createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData(DateTime.now(), 62),
      SalesData(DateTime(DateTime.now().year - 1), 28),
      SalesData(DateTime(DateTime.now().year - 2), 34),
      SalesData(DateTime(DateTime.now().year - 3), 32),
      SalesData(DateTime(DateTime.now().year - 4), 40)
    ];
    int diff =
        (-DateTime(2016, 2, 16).difference(DateTime(2017, 6, 8)).inDays ~/ 365)
            .toInt();
    print("DAYS DIFF: $diff");

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 62),
          child: SfCartesianChart(
            series: <ChartSeries>[
              // Renders line chart
              LineSeries<SalesData, int>(
                  dataSource: chartData,
                  xValueMapper: (SalesData sales, _) => sales.year.year,
                  yValueMapper: (SalesData sales, _) => sales.sales)
            ],
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}
