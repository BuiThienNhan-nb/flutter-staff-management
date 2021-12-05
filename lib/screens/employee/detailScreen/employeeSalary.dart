import 'package:flutter/material.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/additionHistory.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/models/quotaHistories.dart';
import 'package:staff_management/models/workHistory.dart';
import 'package:intl/intl.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class EmployeeSalary extends StatefulWidget {
  final Employee _employee;
  const EmployeeSalary({Key? key, required Employee employee})
      : _employee = employee,
        super(key: key);

  @override
  _EmployeeSalaryState createState() => _EmployeeSalaryState();
}

class _EmployeeSalaryState extends State<EmployeeSalary> {
  List<EmployeeSalaryData> chartData = [];
  List<String> _listYear = ["All"];
  String _selectedYear = "All"; //DateTime.now().year.toString();
  final oCcy = new NumberFormat("#,##0", "en_US");
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    updateChartData(chartData);
    createListYear(_listYear);
    super.initState();
  }

  void updateChartData(List<EmployeeSalaryData> list) {
    for (int i = widget._employee.workHistory.last.dismissDate.toDate().year;
        i <= DateTime.now().year;
        i++) {
      list.add(EmployeeSalaryData(year: i, salary: [], totalSalary: 0));
      // create a list of positions, quotas and additions which this employee join in this year
      List<WorkHistory> position = positionController.positionInRange(
          widget._employee.workHistory, DateTime(i, 1, 1), DateTime(i, 12, 31));
      List<QuotaPoint> quota = quotaController.quotaInRange(
          widget._employee.quotaHistory,
          DateTime(i, 1, 1),
          DateTime(i, 12, 31));
      List<AdditionHistory> addition = [];
      addition.addAll(widget._employee.additionHistory
          .where((p0) => p0.date.toDate().year == i));
      // calculate employee salary this year
      list.last.salary = salaryRecordController.calculateYearSalary(
          widget._employee, i, position, quota, addition);
      list.last.salary
          .forEach((monthSalary) => list.last.totalSalary += monthSalary);
    }
  }

  void updateMonthChartData(List<EmployeeMonthSalaryData> _monthChartData,
      List<EmployeeSalaryData> _chartData, int year) {
    int monthIndex = 0;
    EmployeeSalaryData _salary =
        _chartData.firstWhere((element) => element.year == year);
    _salary.salary.forEach((element) => _monthChartData
        .add(EmployeeMonthSalaryData(month: ++monthIndex, salary: element)));
  }

  void createListYear(List<String> listYear) {
    for (int i = DateTime.now().year;
        i >= widget._employee.workHistory.last.dismissDate.toDate().year;
        i--) {
      listYear.add(i.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    List<EmployeeMonthSalaryData> monthChartData = [];
    if (_selectedYear != "All") {
      updateMonthChartData(monthChartData, chartData, int.parse(_selectedYear));
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("${widget._employee.name} Salary"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 25),
        child: Column(
          children: [
            MyDropdownButton(
                selectedValue: _selectedYear,
                values: _listYear,
                icon: Icons.calendar_today,
                lable: "Year",
                callback: (String _newValue) {
                  setState(() {
                    _selectedYear = _newValue;
                  });
                },
                size: Size(200, 70)),
            SizedBox(height: 20),
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
                  _selectedYear == "All"
                      ? LineSeries<EmployeeSalaryData, int>(
                          name: "Year Salary",
                          dataSource: chartData,
                          xValueMapper: (EmployeeSalaryData salary, _) =>
                              salary.year,
                          yValueMapper: (EmployeeSalaryData salary, _) =>
                              salary.totalSalary)
                      : LineSeries<EmployeeMonthSalaryData, int>(
                          name: "Month Salary",
                          dataSource: monthChartData,
                          xValueMapper: (EmployeeMonthSalaryData salary, _) =>
                              salary.month,
                          yValueMapper: (EmployeeMonthSalaryData salary, _) =>
                              salary.salary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmployeeSalaryData {
  final int year;
  List<int> salary;
  int totalSalary;
  EmployeeSalaryData(
      {required this.year, required this.salary, required this.totalSalary});
}

class EmployeeMonthSalaryData {
  final int month;
  int salary;
  EmployeeMonthSalaryData({required this.month, required this.salary});
}
