import 'package:flutter/material.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/models/relative.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';

class RelativeScreen extends StatefulWidget {
  const RelativeScreen({Key? key}) : super(key: key);

  @override
  _RelativeScreenState createState() => _RelativeScreenState();
}

class _RelativeScreenState extends State<RelativeScreen> {
  late EmployeeDataSource employeeDataSource;
  RelativeQuery _relativeQuery = RelativeQuery(year: "none");
  String _selectedYear = "none";
  List<String> _listYearNames = [
    "none",
    "2021",
    "2020",
    "2019",
    "2018",
    "2017",
    "2003",
    "2000",
    "1995"
  ];

  @override
  void initState() {
    super.initState();
    // employeeController.listEmployees.forEach((element) => (element.relative.forEach((relative) => relative.type == "Con cái" ? _listRelative.add(relative) : {},)),);
    employeeDataSource = EmployeeDataSource(
        employeeData: employeeController.listEmployees,
        onRefresh: dataGridRefresh,
        year: "none");
    additionController.initListAdditionName();
    quotaController.initListQuoataName();
    positionController.initListPositionName();
    unitController.initListUnitName();
    // _listTypeNames.addAll(unitController.listUnitName);
  }

  void dataGridRefresh() {
    updateDataGird();
    setState(() {});
  }

  bool checkRelative(Employee employee, int year) {
    bool flag = false;

    employee.relative.forEach((relative) {
      int age =
          DateTime(year, 1, 1).difference(relative.birthdate.toDate()).inDays ~/
              365;

      if (relative.type == "Con cái" && age <= 10 && age >= 0) {
        flag = true;
      }
    });
    return flag;
  }

  List<Employee> queryEmployee(List<Employee> employees) {
    return employees
        .where(
          (element) => (_relativeQuery.year == "none" ||
              checkRelative(
                  element, int.parse(_relativeQuery.year.toString()))),
        )
        .toList();
  }

  void updateDataGird() {
    employeeDataSource = EmployeeDataSource(
        employeeData: queryEmployee(employeeController.listEmployees),
        onRefresh: dataGridRefresh,
        year: _relativeQuery.year.toString());
    // employeeDataSource.buildDataGridRow();
    employeeDataSource._employeeData
        .forEach((element) => employeeDataSource.buildRow(element));
  }

  @override
  Widget build(BuildContext context) {
    // Build UI
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Relative'), centerTitle: true),
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
                      lable: "Gift date",
                      callback: (String _newValue) {
                        _relativeQuery.year = _newValue;
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
  EmployeeDataSource(
      {required List<Employee> employeeData,
      required this.onRefresh,
      required this.year})
      : _employees = employeeData {
    buildDataGridRow(); //employeeData);
  }

  final VoidCallback onRefresh;

  void buildDataGridRow() {
    int i = 0;
    // int age =
    List<List<DataGridRow>> _listEmployeeData =
        List.filled(_employees.length, []);

    for (var employee in _employees) {
      _listEmployeeData[i] = employee.relative
          .map<DataGridRow>(
            (relative) => DataGridRow(
              cells: (relative.type == "Con cái" && year == "none") ||
                      (relative.type == "Con cái" &&
                          DateTime(int.parse(year), 1, 1)
                                      .difference(relative.birthdate.toDate())
                                      .inDays ~/
                                  365 >=
                              0)
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

class RelativeQuery {
  String? year;
  RelativeQuery({this.year});
}
