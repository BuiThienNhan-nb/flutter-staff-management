import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/employee.dart';

class AdditionEmployeeBottomSheet extends StatefulWidget {
  final List<Employee> _listSelectedEmployee;
  final Callback _callback;
  const AdditionEmployeeBottomSheet({
    Key? key,
    required Callback callback,
    required List<Employee> listSelectedEmployee,
  })  : _callback = callback,
        _listSelectedEmployee = listSelectedEmployee,
        super(key: key);

  @override
  _AdditionEmployeeBottomSheetState createState() =>
      _AdditionEmployeeBottomSheetState();
}

class _AdditionEmployeeBottomSheetState
    extends State<AdditionEmployeeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "List Employee",
          style: GoogleFonts.varelaRound(
            // fontSize: 25,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Container(
            height: 330,
            child: ListView.builder(
              itemCount: employeeController.listEmployees.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: AdditionEmployeeItem(index),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          widget._callback(widget._listSelectedEmployee);
          Get.back();
        },
        child: Icon(
          Icons.person_add,
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
        ),
      ),
    );
  }

  GestureDetector AdditionEmployeeItem(int index) {
    return GestureDetector(
      onTap: () => setState(
        () => widget._listSelectedEmployee
            .add(employeeController.listEmployees[index]),
      ),
      onDoubleTap: () => setState(
        () => widget._listSelectedEmployee
            .remove(employeeController.listEmployees[index]),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: widget._listSelectedEmployee
                    .contains(employeeController.listEmployees[index])
                ? Colors.blue.shade100
                : Colors.grey.withOpacity(0),
            width: 2.0,
          ),
          // borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: widget._listSelectedEmployee
                      .contains(employeeController.listEmployees[index])
                  ? Colors.blue.withOpacity(0.2)
                  : Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(12, 10, 6, 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${employeeController.listEmployees[index].name}",
                      style: GoogleFonts.varelaRound(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  SizedBox(height: 5),
                  Text(
                      "${employeeController.listEmployees[index].workHistory.first.position.value.name}",
                      style: GoogleFonts.varelaRound(
                        fontSize: 15,
                        color: Colors.black,
                      )),
                ],
              ),
              Spacer(),
              Text(
                "${employeeController.listEmployees[index].getSalaryWithoutAdditionsToCurrency()}",
                style: TextStyle(fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}

typedef Callback = Function(List<Employee> onSubmited);
