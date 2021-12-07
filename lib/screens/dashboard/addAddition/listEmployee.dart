import 'package:flutter/material.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/screens/employee/searchScreen/resultItem.dart';

class ListEmployee extends StatelessWidget {
  final List<Employee> _listEmployee;
  const ListEmployee({
    Key? key,
    required List<Employee> listEmployee,
  })  : _listEmployee = listEmployee,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _listEmployee.length,
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: EmployeeResultItem(
            employee: _listEmployee[index],
            onSearchScreen: false,
          ),
        ),
      ),
    );
  }
}
