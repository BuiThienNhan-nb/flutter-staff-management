import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/screens/employee/detailScreen/employeeDetail.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart';

class RetirementEmployee extends StatefulWidget {
  const RetirementEmployee({Key? key}) : super(key: key);

  @override
  _RetirementEmployeeState createState() => _RetirementEmployeeState();
}

class _RetirementEmployeeState extends State<RetirementEmployee> {
  late EmployeeDataSource employeeDataSource;
  EmployeeQuery _employeeQuery =
      EmployeeQuery(position: "All", quota: "All", unit: "All", year: "All");
  String _selectedPosition = "All";
  String _selectedUnit = "All";
  String _selectedQuota = "All";
  String _selectedYear = 'All';
  String _selectedMonth = 'All';
  List<String> _listPositionNames = ["All"];
  List<String> _listUnitNames = ["All"];
  List<String> _listQuotaNames = ["All"];
  var _listYear =
      new List<String>.generate(6, (i) => '${DateTime.now().year + i}');
  List<String> _listMonth = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    'All'
  ];
  @override
  void initState() {
    super.initState();
    calculateSalary();
    employeeDataSource = EmployeeDataSource(
        employeeData: employeeController.listEmployees,
        onRefresh: dataGridRefresh);
    additionController.initListAdditionName();
    quotaController.initListQuoataName();
    positionController.initListPositionName();
    unitController.initListUnitName();
    _listPositionNames.addAll(positionController.listPositionName);
    _listUnitNames.addAll(unitController.listUnitName);
    _listQuotaNames.addAll(quotaController.listQuotaName);
    _listYear.add("All");
  }

  void calculateSalary() {
    employeeController.listEmployees.forEach((element) {
      element.calculateSalary();
    });
  }

  void dataGridRefresh() {
    // employeeController.retreiveDetailData();
    calculateSalary();
    // employeeDataSource.buildDataGridRow();
    // employeeDataSource._employeeData
    //     .forEach((element) => employeeDataSource.buildRow(element));
    updateDataGird();
    setState(() {});
  }

  List<Employee> queryEmployee(List<Employee> employees) {
    return employees
        .where((item) =>
            // (_employeeQuery.position == "All" ||
            //     _employeeQuery.position!.compareTo(
            //             item.workHistory.first.position.value.name) ==
            //         0) &&
            // (_employeeQuery.unit == "All" ||
            //     _employeeQuery.unit!
            //             .compareTo(item.workHistory.first.unit.value.name) ==
            //         0) &&
            // (_employeeQuery.quota == "All" ||
            //     _employeeQuery.quota!
            //             .compareTo(item.quotaHistory.first.quota.value.name) ==
            //         0))
            // &&
            (_employeeQuery.year == "All" ||
                _employeeQuery.year!.compareTo(
                        item.retirementDate.toDate().year.toString()) ==
                    0) &&
            (_employeeQuery.month == "All" ||
                _employeeQuery.month!.compareTo(
                        item.retirementDate.toDate().month.toString()) ==
                    0))
        .toList();
  }

  void updateDataGird() {
    employeeDataSource = EmployeeDataSource(
        employeeData: queryEmployee(employeeController.listEmployees),
        onRefresh: dataGridRefresh);
    employeeDataSource.buildDataGridRow();
    employeeDataSource._employeeData
        .forEach((element) => employeeDataSource.buildRow(element));
  }

  @override
  Widget build(BuildContext context) {
    // Build UI
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Retirement Employee'), centerTitle: true),
        body: Column(
          children: [
            SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  MyDropdownButton(
                      selectedValue: _selectedMonth,
                      values: _listMonth,
                      icon: IconData(0),
                      lable: "Month",
                      callback: (String _newValue) {
                        _employeeQuery.month = _newValue;
                        updateDataGird();
                        setState(() {});
                      },
                      size: Size(120, 60)),
                  SizedBox(width: 10),
                  MyDropdownButton(
                      selectedValue: _selectedYear,
                      values: _listYear,
                      icon: IconData(0),
                      lable: "Year",
                      callback: (String _newValue) {
                        _employeeQuery.year = _newValue;
                        updateDataGird();
                        setState(() {});
                      },
                      size: Size(120, 60)),
                  // MyDropdownButton(
                  //     selectedValue: _selectedPosition,
                  //     values: _listPositionNames,
                  //     icon: IconData(0),
                  //     lable: "Position",
                  //     callback: (String _newValue) {
                  //       _employeeQuery.position = _newValue;
                  //       updateDataGird();
                  //       setState(() {});
                  //     },
                  //     size: Size(120, 60)),
                  // SizedBox(width: 10),
                  // MyDropdownButton(
                  //     selectedValue: _selectedUnit,
                  //     values: _listUnitNames,
                  //     icon: IconData(0),
                  //     lable: "Unit",
                  //     callback: (String _newValue) {
                  //       _employeeQuery.unit = _newValue;
                  //       updateDataGird();
                  //       setState(() {});
                  //     },
                  //     size: Size(120, 60)),
                  // SizedBox(width: 10),
                  // MyDropdownButton(
                  //     selectedValue: _selectedQuota,
                  //     values: _listQuotaNames,
                  //     icon: IconData(0),
                  //     lable: "Quota",
                  //     callback: (String _newValue) {
                  //       _employeeQuery.quota = _newValue;
                  //       updateDataGird();
                  //       setState(() {});
                  //     },
                  //     size: Size(120, 60))
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
                onCellTap: (DataGridCellTapDetails details) {
                  if (details.rowColumnIndex.rowIndex > 0) {
                    String _uidSorted = employeeDataSource.effectiveRows
                        .elementAt(details.rowColumnIndex.rowIndex - 1)
                        .getCells()
                        .first
                        .value as String;
                    // print(_uidSorted);

                    Get.to(
                      () => EmployeeDetail(
                          employee: employeeController.listEmployees.firstWhere(
                              (element) => element.uid == _uidSorted)),
                      transition: Transition.rightToLeft,
                      duration: const Duration(milliseconds: 400),
                    );
                  }
                },
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
                      columnName: 'position',
                      label: Container(
                          // padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Chức vụ',
                            overflow: TextOverflow.ellipsis,
                          ))),
                  GridColumn(
                      columnName: 'retirementDate',
                      label: Container(
                          // padding: EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: Text(
                            'Về hưu',
                            overflow: TextOverflow.ellipsis,
                          ))),
                ],
              ),
            ),
          ],
        ),
        // floatingActionButton: Padding(
        //   padding: const EdgeInsets.only(bottom: 50),
        //   child: FloatingActionButton(
        //     onPressed: () {
        //       Get.to(() => AddEmployee());
        //     },
        //     child: Icon(Icons.add),
        //     backgroundColor: Colors.blue,
        //   ),
        // ),
      ),
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  List<Employee> _employees;
  EmployeeDataSource(
      {required List<Employee> employeeData, required this.onRefresh})
      : _employees = employeeData {
    buildDataGridRow(); //employeeData);
  }

  final VoidCallback onRefresh;

  void buildDataGridRow() {
    //List<Employee> employeeData) {
    _employeeData = _employees
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'uid', value: e.uid),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'position',
                  value: e.workHistory.first.position.value.name),
              DataGridCell<String>(
                  columnName: 'retirementDate',
                  value: DateFormat('dd/MM/yyyy')
                      .format(e.retirementDate.toDate())),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _employeeData = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: (e.columnName == "retirementDate")
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

class EmployeeQuery {
  String? position;
  String? unit;
  String? quota;
  String? year;
  String? month;

  EmployeeQuery({this.position, this.unit, this.quota, this.year, this.month});
}
