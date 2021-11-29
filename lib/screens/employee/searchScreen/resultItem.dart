import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/screens/employee/detailScreen/employeeDetail.dart';

class EmployeeResultItem extends StatelessWidget {
  final Employee _employee;
  const EmployeeResultItem({Key? key, required Employee employee})
      : _employee = employee,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.grey.shade400,
      borderRadius: BorderRadius.circular(8),
      onTap: () => Get.to(() => EmployeeDetail(employee: _employee)),
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 10, 6, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${_employee.name}",
                    style: GoogleFonts.varelaRound(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                SizedBox(height: 5),
                Text("${_employee.workHistory!.first.position.value.name}",
                    style: GoogleFonts.varelaRound(
                      fontSize: 15,
                      color: Colors.black,
                    )),
              ],
            ),
            Spacer(),
            Text(
              "${_employee.getSalaryWithoutAdditionsToCurrency()}",
              style: TextStyle(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
