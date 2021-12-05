import 'package:flutter/material.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/additionHistory.dart';
import 'package:staff_management/models/quotaHistories.dart';
import 'package:staff_management/models/workHistory.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class RevenueScreen extends StatefulWidget {
  const RevenueScreen({Key? key}) : super(key: key);

  @override
  _RevenueScreenState createState() => _RevenueScreenState();
}

class _RevenueScreenState extends State<RevenueScreen> {
  List<String> _listUnitNames = ["All"];
  String _selectedUnit = "All";
  final oCcy = new NumberFormat("#,##0", "en_US");
  late TooltipBehavior _tooltipBehavior;

  void updateChart(List<SalaryData> _list) {
    salaryRecordController.listSalaryRecords.forEach((element) {
      _list.add(SalaryData(element.year, 0));
      employeeController.listEmployees
          .where((employee) =>
              _selectedUnit == "All" ||
              _selectedUnit == employee.workHistory.first.unit.value.name)
          .forEach((item) {
        List<WorkHistory> position = positionController.positionInRange(
            item.workHistory,
            DateTime(element.year, 1, 1),
            DateTime(element.year, 12, 31));
        List<QuotaPoint> quota = quotaController.quotaInRange(item.quotaHistory,
            DateTime(element.year, 1, 1), DateTime(element.year, 12, 31));
        List<AdditionHistory> addition = [];
        addition.addAll(item.additionHistory
            .where((value) => value.date.toDate().year == element.year));
        List<int> salary = salaryRecordController.calculateYearSalary(
            item, element.year, position, quota, addition);
        salary.forEach((salary) => _list.last.salary += salary);
      });
    });
  }

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    _listUnitNames.addAll(unitController.listUnitName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<SalaryData> chartData = [];
    updateChart(chartData);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 62),
          child: Column(
            children: [
              MyDropdownButton(
                  selectedValue: _selectedUnit,
                  values: _listUnitNames,
                  icon: Icons.home_work_rounded,
                  lable: "Unit",
                  callback: (String _newValue) {
                    setState(() {
                      _selectedUnit = _newValue;
                    });
                  },
                  size: Size(200, 70)),
              SizedBox(height: 10),
              Expanded(
                child: SfCartesianChart(
                  tooltipBehavior: _tooltipBehavior,
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                  ),
                  // primaryXAxis: CategoryAxis(isInversed: true),
                  primaryYAxis: NumericAxis(
                      numberFormat: NumberFormat.compactCurrency(locale: "vi")),
                  enableAxisAnimation: true,
                  series: <ChartSeries>[
                    // Renders line chart
                    LineSeries<SalaryData, int>(
                        name: "Total employee year salary",
                        xAxisName: "year",
                        yAxisName: "money",
                        dataSource: chartData,
                        xValueMapper: (SalaryData salary, _) => salary.year,
                        yValueMapper: (SalaryData salary, _) => salary.salary)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SalaryData {
  SalaryData(this.year, this.salary);
  final int year;
  int salary;
}
