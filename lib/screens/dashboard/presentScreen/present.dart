import 'package:flutter/material.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/models/relative.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';

class PresentScreen extends StatefulWidget {
  const PresentScreen({Key? key}) : super(key: key);

  @override
  _PresentScreenState createState() => _PresentScreenState();
}

class _PresentScreenState extends State<PresentScreen> {
  late EmployeeDataSource employeeDataSource;
  YearQuery _yearQuery = YearQuery(year: "none");
  HolidayQuery _holidayQuery = HolidayQuery(holiday: "none");
  String _selectedYear = "none";
  String _selectedHoliday = "none";
  List<String> _listYearNames = [
    "none",
    "2021",
    "2022",
    "2023",
    "2024",
    "2025"
  ];
  List<String> _listHolidays = [
    "none",
    "International Children",
    "Lunar New Year",
  ];

  @override
  void initState() {
    super.initState();
    employeeDataSource = EmployeeDataSource(
        employeeData: employeeController.listEmployees,
        onRefresh: dataGridRefresh,
        year: "none",
        holidayName: "none");
  }

  void dataGridRefresh() {
    updateDataGird();
    setState(() {});
  }

  bool checkRelative(Employee employee, int year, String holidayName) {
    bool flag = false;
    int limitAge = 0;
    switch (holidayName) {
      case "International Children":
        limitAge = 10;
        break;
      case "Lunar New Year":
        limitAge = 5;
        break;
      default:
    }
    employee.relative.forEach((relative) {
      int age =
          DateTime(year, 1, 1).difference(relative.birthdate.toDate()).inDays ~/
              365;
      if (relative.type == "Con cái" && age <= limitAge && age >= 0) {
        flag = true;
      }
    });
    return flag;
  }

  List<Employee> queryEmployee(List<Employee> employees) {
    return employees
        .where(
          (element) => (_yearQuery.year == "none" ||
              _holidayQuery.holiday == "none" ||
              checkRelative(
                  element,
                  int.parse(
                    _yearQuery.year.toString(),
                  ),
                  _holidayQuery.holiday.toString())),
        )
        .toList();
  }

  void updateDataGird() {
    employeeDataSource = EmployeeDataSource(
        employeeData: queryEmployee(employeeController.listEmployees),
        onRefresh: dataGridRefresh,
        year: _yearQuery.year.toString(),
        holidayName: _holidayQuery.holiday.toString());
    employeeDataSource._employeeData
        .forEach((element) => employeeDataSource.buildRow(element));
  }

  @override
  Widget build(BuildContext context) {
    // Build UI
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Present'), centerTitle: true),
        body: Column(
          children: [
            SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  MyDropdownButton(
                      selectedValue: _selectedYear,
                      values: _listYearNames,
                      icon: IconData(0),
                      lable: "Gift year",
                      callback: (String _newValue) {
                        _yearQuery.year = _newValue;
                        updateDataGird();
                        setState(() {});
                      },
                      size: Size(120, 60)),
                  SizedBox(width: 10),
                  MyDropdownButton(
                      selectedValue: _selectedHoliday,
                      values: _listHolidays,
                      icon: IconData(0),
                      lable: "Holiday",
                      callback: (String _newValue) {
                        _holidayQuery.holiday = _newValue;
                        updateDataGird();
                        setState(() {});
                      },
                      size: Size(120, 60)),
                ],
              ),
            ),
            Container(
              color: Colors.black,
              width: 500,
              height: 0.6,
            ),
            Expanded(
              child: SfDataGrid(
                gridLinesVisibility: GridLinesVisibility.both,
                headerGridLinesVisibility: GridLinesVisibility.horizontal,
                columnWidthMode: ColumnWidthMode.auto,
                allowSorting: true,
                sortingGestureType: SortingGestureType.tap,
                showSortNumbers: true,
                allowPullToRefresh: true,
                source: employeeDataSource,
                selectionMode: SelectionMode.single,
                columns: [
                  GridColumn(
                      columnName: 'uid',
                      label: Container(
                          // padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text(
                            'ID',
                            overflow: TextOverflow.ellipsis,
                          ))),
                  GridColumn(
                      columnName: 'name',
                      label: Container(
                          // padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Tên',
                            overflow: TextOverflow.ellipsis,
                          ))),
                  GridColumn(
                      columnName: 'relative',
                      label: Container(
                          // padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Thân nhân',
                            overflow: TextOverflow.ellipsis,
                          ))),
                  GridColumn(
                      columnName: 'type',
                      label: Container(
                          // padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Quan hệ',
                            overflow: TextOverflow.ellipsis,
                          ))),
                  GridColumn(
                      columnName: 'Birthday',
                      label: Container(
                          // padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Năm sinh',
                            overflow: TextOverflow.ellipsis,
                          ))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  List<Employee> _employees;
  String year;
  String holidayName;
  EmployeeDataSource(
      {required List<Employee> employeeData,
      required this.onRefresh,
      required this.year,
      required this.holidayName})
      : _employees = employeeData {
    buildDataGridRow(); //employeeData);
  }

  final VoidCallback onRefresh;

  void buildDataGridRow() {
    int i = 0;
    int limitAge = 0;
    switch (holidayName) {
      case "International Children":
        limitAge = 10;
        break;
      case "Lunar New Year":
        limitAge = 5;
        break;
      default:
    }
    List<List<DataGridRow>> _listEmployeeData =
        List.filled(_employees.length, []);

    for (var employee in _employees) {
      _listEmployeeData[i] = employee.relative
          .map<DataGridRow>(
            (relative) => DataGridRow(
              cells: (relative.type == "Con cái" &&
                          (year == "none" || holidayName == "none")) ||
                      (relative.type == "Con cái" &&
                          DateTime(int.parse(year), 1, 1)
                                      .difference(relative.birthdate.toDate())
                                      .inDays ~/
                                  365 >=
                              0 &&
                          DateTime(int.parse(year), 1, 1)
                                      .difference(relative.birthdate.toDate())
                                      .inDays ~/
                                  365 <=
                              limitAge)
                  ? [
                      DataGridCell<String>(
                          columnName: 'uid', value: employee.uid),
                      DataGridCell<String>(
                          columnName: 'name', value: employee.name),
                      DataGridCell<String>(
                          columnName: 'relative', value: relative.name),
                      DataGridCell<String>(
                          columnName: 'type', value: relative.type),
                      DataGridCell<String>(
                          columnName: 'Birthday',
                          value: DateFormat('dd/MM/yyyy')
                              .format(relative.birthdate.toDate())),
                    ]
                  : [
                      DataGridCell<String>(columnName: 'null', value: ""),
                      DataGridCell<String>(columnName: 'null', value: ""),
                      DataGridCell<String>(columnName: 'null', value: ""),
                      DataGridCell<String>(columnName: 'null', value: ""),
                      DataGridCell<String>(columnName: 'null', value: ""),
                    ],
            ),
          )
          .toList();
      _TemplateData = [..._listEmployeeData[i]];
      _TemplateData.forEach(
        (element) {
          if (element.getCells().first.columnName == 'null') {
            _listEmployeeData[i].remove(element);
          }
        },
      );
      i++;
    }
    _listEmployeeData.forEach((element) {
      _employeeData += element;
    });
  }

  List<DataGridRow> _employeeData = [];
  List<DataGridRow> _TemplateData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: (e.columnName == "salary")
            ? Alignment.center
            : Alignment.centerLeft,
        padding: EdgeInsets.all(8.0),
        child: Text(
          e.value.toString(),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList());
  }

  @override
  Future<void> handleRefresh() {
    employeeController.retreiveDetailData();
    onRefresh();
    return super.handleRefresh();
  }
}

class YearQuery {
  String? year;
  YearQuery({this.year});
}

class HolidayQuery {
  String? holiday;
  HolidayQuery({this.holiday});
}
