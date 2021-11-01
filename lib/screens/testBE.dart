import 'package:flutter/material.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/employee.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TestBE extends StatefulWidget {
  const TestBE({Key? key}) : super(key: key);

  @override
  _TestBEState createState() => _TestBEState();
}

class _TestBEState extends State<TestBE> {
  late EmployeeDataSource employeeDataSource;

  // @override
  // void initState() {
  //   super.initState();
  //   retrieveData();
  // }

  void onRefresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // retrieveData();
    employeeDataSource = EmployeeDataSource(
        employeeData: employeeController.listEmployee,
        onRefresh: () {
          setState(() {});
        });

    // Build UI
    return SafeArea(
      child: Scaffold(
        body: SfDataGrid(
          gridLinesVisibility: GridLinesVisibility.both,
          headerGridLinesVisibility: GridLinesVisibility.horizontal,
          columnWidthMode: ColumnWidthMode.lastColumnFill,
          allowSorting: true,
          allowPullToRefresh: true,
          source: employeeDataSource,
          columns: [
            // GridColumn(
            //     columnName: 'uid',
            //     label: Container(
            //         // padding: EdgeInsets.all(8.0),
            //         alignment: Alignment.center,
            //         child: Text(
            //           'ID',
            //           overflow: TextOverflow.ellipsis,
            //         ))),
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

// void retrieveData() {
//   employeeController.listEmployees.forEach((item) {
//     item.addition
//         .bindStream(AdditionRepo().additionByEmployeeStream(item.addition));
//     item.workHistory.forEach((element) {
//       element.position
//           .bindStream(PositionRepo().positionByIdStream(element.positionId));
//       element.unit.bindStream(UnitRepo().unitByIdStream(element.unitId));
//     });
//   });
// }

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource(
      {required List<Employee> employeeData, required this.onRefresh}) {
    buildDataGridRow(employeeData);
  }

  final VoidCallback onRefresh;

  void buildDataGridRow(List<Employee> employeeData) {
    _employees = employeeData;
    _employeeData = employeeData
        .map<DataGridRow>(
          (e) => DataGridRow(
            cells: [
              // DataGridCell<String>(columnName: 'uid', value: e.uid),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'position',
                  value: e.workHistory.last.position.value.name),
              DataGridCell<double>(
                  columnName: 'salary', value: e.getSalaryWithoutAdditions()),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> _employeeData = [];
  List<Employee> _employees = [];

  @override
  List<DataGridRow> get rows => _employeeData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      return Container(
        alignment: (e.columnName == 'salary')
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
    // TODO: implement handleRefresh
    // employeeController.retreiveDetailData();
    onRefresh();
    return super.handleRefresh();
  }
}
