import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/additionHistory.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/models/quotaHistories.dart';
import 'package:staff_management/models/relative.dart';
import 'package:staff_management/models/workHistory.dart';
import 'package:staff_management/screens/employee/detailScreen/employeeDetail.dart';
import 'package:staff_management/screens/employee/searchScreen/resultItem.dart';

class EmployeeSearchData extends SearchDelegate<Employee> {
  @override
  String? get searchFieldLabel => 'Search Employee...';

  // late Employee _employee;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(
            context,
            Employee(
                uid: "uid",
                address: "",
                birthdate: Timestamp.fromDate(DateTime.now()),
                folk: "",
                identityCard: "",
                name: "",
                quotaHistory: <QuotaHistory>[].obs,
                retirementDate: Timestamp.fromDate(DateTime.now()),
                sex: "",
                workDate: Timestamp.fromDate(DateTime.now()),
                relative: <Relative>[].obs,
                workHistory: <WorkHistory>[].obs,
                additionHistory: <AdditionHistory>[].obs,
                salary: 0));
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final result = employeeController.listEmployees
        .where((element) =>
            element.name.toLowerCase().trim().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(2, 3),
              ),
            ],
          ),
          child: EmployeeResultItem(employee: result[index]),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // return ListView.builder(
    //   itemBuilder: (context, index) => ListTile(
    //     onTap: () {
    //       _destination = suggestion[index];
    //       tag = 'search-${suggestion[index].uid}';
    //       // showResults(context);
    //       destinationController.navigateToDesDetail(suggestion[index], tag);
    //       // close(context,
    //       //     Destination(uid: '', name: '', description: '', imageUrl: ''));
    //     },
    //     leading: Icon(Icons.arrow_forward_ios),
    //     title: RichText(
    //       text: TextSpan(
    //         text: suggestion[index].name.substring(0, query.length),
    //         style: TextStyle(
    //           color: Colors.black,
    //           fontWeight: FontWeight.bold,
    //         ),
    //         children: [
    //           TextSpan(
    //             text: suggestion[index].name.substring(query.length),
    //             style: TextStyle(color: Colors.grey),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   itemCount: suggestion.length,
    // );
    final suggestion = query.isEmpty
        ? employeeController.listEmployees
        : employeeController.listEmployees
            .where((element) =>
                element.name.toLowerCase().trim().contains(query.toLowerCase()))
            .toList();
    return ListView.builder(
      itemCount: suggestion.length < 10 ? suggestion.length : 10,
      itemBuilder: (context, index) => ListTile(
        onTap: () => Get.to(() => EmployeeDetail(employee: suggestion[index])),
        leading: Icon(Icons.person),
        title: Text("${suggestion[index].name}"),
      ),
    );
  }
}
