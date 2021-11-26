import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/screens/employee/addScreen/addEmployee.dart';
import 'package:staff_management/screens/employee/detailScreen/employeeDetail.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class EmployeeDataGridView extends StatefulWidget {
  const EmployeeDataGridView({Key? key}) : super(key: key);

  @override
  _EmployeeDataGridViewState createState() => _EmployeeDataGridViewState();
}

class _EmployeeDataGridViewState extends State<EmployeeDataGridView> {
  late EmployeeDataSource employeeDataSource;

  @override
  void initState() {
    super.initState();
    calculateSalary();
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

  @override
  Widget build(BuildContext context) {
    // retrieveData();
    employeeDataSource = EmployeeDataSource(
        employeeData: employeeController.listEmployees,
        onRefresh: () {
          employeeController.retreiveDetailData();
          setState(() {
            calculateSalary();
          });
        });
    // Build UI
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            InkWell(
              onTap: () {
                Get.to(() => AddEmployee());
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
        body: SfDataGrid(
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
                    employee: employeeController.listEmployees
                        .firstWhere((element) => element.uid == _uidSorted)),
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
      ),
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(
      {required List<Employee> employeeData, required this.onRefresh}) {
    buildDataGridRow(employeeData);
  }

  final VoidCallback onRefresh;

  void buildDataGridRow(List<Employee> employeeData) {
    _employeeData = employeeData
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
