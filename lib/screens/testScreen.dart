import 'package:flutter/material.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/additionHistory.dart';
import 'package:staff_management/models/quotaHistories.dart';
import 'package:staff_management/models/workHistory.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String _title = "Chưa đổi";

  @override
  void initState() {
    // testCalculateSalary();
    super.initState();
  }

  void testCalculateSalary() {
    int year = 2019;
    int index = 5;
    DateTime begin = DateTime(year, 1, 1);
    DateTime end = DateTime(year, 12, 31);
    List<WorkHistory> position = positionController.positionInRange(
        employeeController.listEmployees[index].workHistory, begin, end);
    List<QuotaPoint> quota = quotaController.quotaInRange(
        employeeController.listEmployees[index].quotaHistory, begin, end);
    List<AdditionHistory> addition = [];
    addition.addAll(employeeController.listEmployees[index].additionHistory
        .where((element) => element.date.toDate().year == year));
    List<int> salary = salaryRecordController.calculateYearSalary(
        employeeController.listEmployees[index],
        year,
        position,
        quota,
        addition);
    salary.forEach((element) => print(element));
  }

  void changeTitle() {
    setState(() {
      _title = _title == "Chưa đổi" ? "Đổi rồi nè" : "Chưa đổi";
    });
  }

  @override
  Widget build(BuildContext context) {
    testCalculateSalary();

    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(_title),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              changeTitle();
            },
            child: Text("Nhấn chơi để đổi title nè"),
          ),
        ),
      ),
    );
  }
}
