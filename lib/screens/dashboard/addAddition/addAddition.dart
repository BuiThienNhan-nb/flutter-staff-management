import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/addition.dart';
import 'package:staff_management/models/additionHistory.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/screens/dashboard/addAddition/additionEmployeeBottomSheet.dart';
import './listEmployee.dart';
import 'package:staff_management/services/employeeRepo.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';

class AddAdditionScreen extends StatefulWidget {
  const AddAdditionScreen({Key? key}) : super(key: key);

  @override
  _AddAdditionScreenState createState() => _AddAdditionScreenState();
}

class _AddAdditionScreenState extends State<AddAdditionScreen> {
  String _selectedAddition = additionController.listAdditionName.first;
  List<Employee> _selectedEmployee = [];

  @override
  Widget build(BuildContext context) {
    final Size _deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Addition",
          style: GoogleFonts.varelaRound(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Text(
                "Choose addition:",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            MyDropdownButton(
                selectedValue: _selectedAddition,
                values: additionController.listAdditionName,
                icon: Icons.image_aspect_ratio_rounded,
                lable: "Unit",
                callback: (String _newValue) {
                  setState(() {
                    _selectedAddition = _newValue;
                  });
                },
                size: Size(200, 60)),
            SizedBox(height: 10),
            Container(
              height: _selectedEmployee.length == 0
                  ? 20
                  : _deviceSize.height * 0.53,
              child: ListEmployee(listEmployee: _selectedEmployee),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Get.bottomSheet(
                    AdditionEmployeeBottomSheet(
                      callback: (List<Employee> _selectedList) => setState(
                        () => _selectedEmployee = _selectedList,
                      ),
                      listSelectedEmployee: _selectedEmployee,
                    ),
                    // _selectedEmployee = _selectedList),
                  ),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async => await addEmployeeAddition()
                    .then((value) => showSnackBar(context, value)),
                child: Text("Add Employee Addition"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> addEmployeeAddition() async {
    if (_selectedEmployee.length == 0) {
      return false;
    } else {
      Addition addition = additionController.listAdditions
          .firstWhere((element) => element.content == _selectedAddition);
      AdditionHistory additionHistory = AdditionHistory(
        uid: "uid",
        additionId: addition.uid,
        date: Timestamp.fromDate(DateTime.now()),
        addition: addition.obs,
      );
      await EmployeeRepo()
          .updateEmployeeAddition(_selectedEmployee, additionHistory);
      return true;
    }
  }

  void showSnackBar(BuildContext context, bool flag) {
    if (flag) {
      Get.back();
      final snackBar = SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(
          "Add addition for employee successful",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(
          "No employee selected yet",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
