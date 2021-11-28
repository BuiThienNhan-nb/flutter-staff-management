import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/screens/employee/addScreen/addEmployee.dart';
import 'package:staff_management/screens/employee/detailScreen/employeeDetail.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EmployeeDataGridView extends StatefulWidget {
  const EmployeeDataGridView({Key? key}) : super(key: key);

  @override
  _EmployeeDataGridViewState createState() => _EmployeeDataGridViewState();
}

class _EmployeeDataGridViewState extends State<EmployeeDataGridView> {
  late EmployeeDataSource employeeDataSource;
  EmployeeQuery _employeeQuery =
      EmployeeQuery(position: "", quota: "", unit: "");
  String _selectedPosition = "Trợ giảng";
  String _selectedUnit = "Khoa Văn hóa Du lịch";
  String _selectedQuota = "Giảng viên";

  @override
  void initState() {
    super.initState();
    calculateSalary();
    employeeDataSource = EmployeeDataSource(
        employeeData: employeeController.listEmployees,
        onRefresh: dataGridRefresh);
    additionController.initListAdditionName();
    quotaController.initListPositionName();
    positionController.initListPositionName();
    unitController.initListUnitName();
  }

  void calculateSalary() {
    employeeController.listEmployees.forEach((element) {
      element.calculateSalary();
    });
  }

  void dataGridRefresh() {
    employeeController.retreiveDetailData();
    setState(() {
      calculateSalary();
    });
  }

  List<Employee> queryEmployee(List<Employee> employees) {
    return employees
        .where((item) =>
            (_employeeQuery.position == "" ||
                _employeeQuery.position!
                    .contains(item.workHistory.first.position.value.name)) &&
            (_employeeQuery.unit == "" ||
                _employeeQuery.unit!
                    .contains(item.workHistory.first.unit.value.name)) &&
            (_employeeQuery.quota == "" ||
                _employeeQuery.quota!
                    .contains(item.quotaHistory.first.quota.value.name)))
        .toList();
  }

  void updateDataGird() {
    employeeDataSource = EmployeeDataSource(
        employeeData: queryEmployee(employeeController.listEmployees),
        onRefresh: dataGridRefresh);
  }

  void updateDataGirdRow() {
    updateDataGird();
    employeeDataSource.buildDataGridRow();
    employeeDataSource._employeeData
        .forEach((element) => employeeDataSource.buildRow(element));
  }

  @override
  Widget build(BuildContext context) {
    // Build UI
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   // backgroundColor: Colors.white,
        //   // title: Row(
        //   //   crossAxisAlignment: CrossAxisAlignment.center,
        //   //   mainAxisAlignment: MainAxisAlignment.start,
        //   //   children: [
        //   //     MyDropdownButton(
        //   //         selectedValue: _selectedPosition,
        //   //         values: positionController.listPositionName,
        //   //         icon: IconData(0),
        //   //         lable: "Position",
        //   //         callback: (String _newValue) {},
        //   //         size: Size(120, 60))
        //   //   ],
        //   // ),
        //   actions: [
        //     InkWell(
        //       onTap: () {
        //         Get.to(() => AddEmployee());
        //       },
        //       child: Icon(Icons.add),
        //     ),
        //   ],
        // ),
        body: Column(
          children: [
            SingleChildScrollView(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 10),
                  MyDropdownButton(
                      selectedValue: _selectedPosition,
                      values: positionController.listPositionName,
                      icon: IconData(0),
                      lable: "Position",
                      callback: (String _newValue) {
                        _employeeQuery.position = _newValue;
                        updateDataGirdRow();
                        setState(() {});
                      },
                      size: Size(120, 60)),
                  SizedBox(width: 10),
                  MyDropdownButton(
                      selectedValue: _selectedUnit,
                      values: unitController.listUnitName,
                      icon: IconData(0),
                      lable: "Unit",
                      callback: (String _newValue) {
                        _employeeQuery.unit = _newValue;
                        setState(() {});
                      },
                      size: Size(120, 60)),
                  SizedBox(width: 10),
                  MyDropdownButton(
                      selectedValue: _selectedQuota,
                      values: quotaController.listQuotaName,
                      icon: IconData(0),
                      lable: "Quota",
                      callback: (String _newValue) {
                        _employeeQuery.unit = _newValue;
                        setState(() {});
                      },
                      size: Size(120, 60))
                ],
              ),
            ),
            Container(
              color: Colors.black,
              width: 500,
              height: 0.6,
            ),
            SfDataGrid(
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
                    columnName: 'salary',
                    label: Container(
                        // padding: EdgeInsets.all(8.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Lương',
                          overflow: TextOverflow.ellipsis,
                        ))),
              ],
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: FloatingActionButton(
            onPressed: () {
              Get.to(() => AddEmployee());
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.blue,
          ),
        ),
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
                  value: e.workHistory.last.position.value.name),
              DataGridCell<String>(
                  columnName: 'salary',
                  value: e.getSalaryWithoutAdditionsToCurrency()),
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

class EmployeeQuery {
  String? position;
  String? unit;
  String? quota;

  EmployeeQuery({this.position, this.unit, this.quota});
}
