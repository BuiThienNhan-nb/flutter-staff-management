import 'package:flutter/material.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/employee.dart';
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
    int index = 3;
    DateTime begin = DateTime(year, 1, 1);
    DateTime end = DateTime(year, 12, 31);
    List<WorkHistory> position = positionController.positionInRange(
        employeeController.listEmployees[index].workHistory, begin, end);
    List<QuotaPoint> quota = quotaController.quotaInRange(
        employeeController.listEmployees[index].quotaHistory, begin, end);
    List<int> salary = salaryRecordController.calculateYearSalary(
        employeeController.listEmployees[index], year, position, quota);
    salary.forEach((element) => print(element));
  }

  void changeTitle() {
    setState(() {
      _title = _title == "Chưa đổi" ? "Đổi rồi nè" : "Chưa đổi";
    });
  }

  @override
  Widget build(BuildContext context) {
    // int diff =
    //     (-DateTime(2016, 2, 16).difference(DateTime(2017, 6, 8)).inDays ~/ 365)
    //         .toInt();
    // print("DAYS DIFF: $diff");
    // List<QuotaHistory> lists = quotaController.quotasInRange(
    //     employeeController.listEmployees[5].quotaHistory,
    //     DateTime(2006, 5, 5),
    //     DateTime(2013, 9, 9));
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
