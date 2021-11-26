import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:staff_management/models/addition.dart';
import 'package:staff_management/models/additionHistory.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/models/quota.dart';
import 'package:staff_management/models/quotaHistories.dart';
import 'package:staff_management/models/relative.dart';
import 'package:staff_management/models/workHistory.dart';
import 'package:staff_management/services/employeeRepo.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:staff_management/utils/expansionTitle/addWorkHistory/addWorkHistoryExpansion.dart';
import 'package:staff_management/utils/expansionTitle/additions/additionExpansionTitle.dart';
import 'package:staff_management/utils/expansionTitle/quotaHistories/quotaHisExpansionTitle.dart';
import 'package:staff_management/utils/expansionTitle/relatives/relativesExpansionTitle.dart';
import 'package:staff_management/utils/expansionTitle/workHistories/workHisExpansionTitle.dart';
import 'package:staff_management/utils/textField/birthdayTextField.dart';
import 'package:staff_management/utils/textField/textField.dart';
import 'package:staff_management/utils/textField/datePickerTextField.dart';
import 'package:intl/intl.dart';

// class AddEmployee extends StatefulWidget {
//   // const AddEmployee({
//   //   Key? key,

//   // }) : super(key: key);

//   @override
//   _AddEmployeeState createState() => _AddEmployeeState();
// }

// class _AddEmployeeState extends State<AddEmployee> {
class AddEmployee extends StatelessWidget {
  final EmployeeRepo employeeRepo = EmployeeRepo();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _identityCardController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _folkController = TextEditingController();
  final _workdateController = TextEditingController();
  final _quotaController = TextEditingController();
  final _positionController = TextEditingController();
  final _unitController = TextEditingController();
  final _sexController = TextEditingController();
  final _salaryController = TextEditingController();
  final RxList<Relative> _relativesController = <Relative>[].obs;
  final RxList<WorkHistory> _workHistoryController = <WorkHistory>[].obs;
  final RxList<AdditionHistory> _additionHistoryController =
      <AdditionHistory>[].obs;
  final RxList<QuotaHistory> _quotaHistoryController = <QuotaHistory>[].obs;
  CollectionReference employees =
      FirebaseFirestore.instance.collection('employees');
  String sex = 'Nam';
  bool onEdit = true;
  bool ignore = true;

  // @override
  // void initState() {
  //   super.initState();
  //   // _identityCardController.text = "${widget.employee.identityCard}";
  //   // _nameController.text = "${widget.employee.name}";
  //   // _addressController.text = "${widget.employee.address}";
  //   // _birthdateController.text =
  //   //     '${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.employee.birthdate.seconds * 1000))}';
  //   // _folkController.text = "${widget.employee.folk}";
  //   // _quotaController.text =
  //   //     "${widget.employee.quotaHistory.value[0].quota.value.name}";
  //   // _positionController.text =
  //   //     "${widget.employee.workHistory.first.position.value.name}";
  //   // _unitController.text =
  //   //     "${widget.employee.workHistory.first.unit.value.name}";
  //   // _sexController.text = "${widget.employee.sex}";
  //   // _salaryController.text =
  //   //     "${widget.employee.getSalaryWithAdditionsToCurrency()}";
  // }

  // @override
  // void dispose() {
  //   // _addressController.dispose();
  //   // _birthdateController.dispose();
  //   // _identityCardController.dispose();
  //   // _nameController.dispose();
  //   // _folkController.dispose();
  //   // _quotaController.dispose();
  //   // _positionController.dispose();
  //   // _unitController.dispose();
  //   // _sexController.dispose();
  //   // _salaryController.dispose();
  //   super.dispose();
  // }
  void addEmployee() {
    Employee employee = Employee(
        uid: 'uid',
        address: _addressController.text,
        birthdate: Timestamp.fromDate(
            DateFormat('dd/MM/yyyy').parse(_birthdateController.text)),
        folk: _folkController.text,
        identityCard: _identityCardController.text,
        name: _nameController.text,
        quotaHistory: _quotaHistoryController,
        retirementDate: Timestamp.fromDate(
            DateFormat('dd/MM/yyyy').parse(_workdateController.text)),
        sex: sex,
        workDate: Timestamp.fromDate(
            DateFormat('dd/MM/yyyy').parse(_workdateController.text)),
        relative: _relativesController,
        workHistory: _workHistoryController,
        additionHistory: _additionHistoryController,
        salary: 0);
    employeeRepo.addEmployee(employee);
  }

  @override
  Widget build(BuildContext context) {
    final Size sizeDevice = MediaQuery.of(context).size;
    final sizeWidth = sizeDevice.width;
    final sizeHeight = sizeDevice.height;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Employee Detail"),
      ),
      body: SingleChildScrollView(
        child: DefaultTextStyle(
          style: TextStyle(color: Colors.blue.shade800),
          child: Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.only(
              //     top: 20,
              //     bottom: 20,
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //         height: sizeHeight * 0.15,
              //         child: ClipOval(
              //           child: Container(
              //             width: sizeWidth * 0.3,
              //             color: Colors.grey.shade400,
              //             child: Icon(
              //               Icons.person,
              //               color: Colors.white,
              //               size: 70,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 20),
              //   child: onEdit
              //       ? Form(
              //           key: _formKey2,
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Container(
              //                 width: 77,
              //                 child: TextFormField(
              //                   style: TextStyle(
              //                       fontSize: 15, color: Colors.blue.shade800),
              //                   controller: _identityCardController,
              //                   decoration:
              //                       InputDecoration(border: InputBorder.none),
              //                   keyboardType: TextInputType.phone,
              //                   validator: (input) {
              //                     if (input == null || input.isEmpty)
              //                       return "Can't be null";
              //                   },
              //                 ),
              //               ),
              //               Text(" | ", style: TextStyle(fontSize: 15)),
              //               Container(
              //                 width: 90,
              //                 child: TextFormField(
              //                   style: TextStyle(
              //                       fontSize: 15, color: Colors.blue.shade800),
              //                   controller: _nameController,
              //                   decoration:
              //                       InputDecoration(border: InputBorder.none),
              //                   keyboardType: TextInputType.name,
              //                   validator: (input) {
              //                     if (input == null || input.isEmpty)
              //                       return "Can't be null";
              //                   },
              //                 ),
              //               )
              //             ],
              //           ),
              //         )
              //       : Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               "${widget.employee.identityCard} | ${widget.employee.name}",
              //               style: TextStyle(
              //                 fontSize: 15,
              //               ),
              //             )
              //           ],
              //         ),
              // ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Form(
                      key: _formKey2,
                      child: TextFormField(
                        style: TextStyle(
                            fontSize: 15, color: Colors.blue.shade800),
                        controller: _identityCardController,
                        decoration: InputDecoration(
                          hintText: 'Identity card',
                          prefixIcon: Icon(Icons.card_membership),
                          labelText: 'Identity card',
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (input) {
                          if (input == null || input.isEmpty)
                            return "Can't be null";
                        },
                      ),
                    ),
                    TextFormField(
                      style:
                          TextStyle(fontSize: 15, color: Colors.blue.shade800),
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        prefixIcon: Icon(Icons.person),
                        labelText: 'Name',
                      ),
                      keyboardType: TextInputType.name,
                      validator: (input) {
                        if (input == null || input.isEmpty)
                          return "Can't be null";
                      },
                    ),
                    DatePickerTextField(
                      labelText: "Work day",
                      placeholder: "Sep 12, 1998",
                      textEditingController: _workdateController,
                      icon: Icons.access_time,
                      editable: true,
                    ),
                    // MyDropdownButton(
                    //     controller: _quotaController,
                    //     icon: Icons.work,
                    //     hintText: "Quota",
                    //     onEdit: true,
                    //     textInputFormatter:
                    //         FilteringTextInputFormatter.singleLineFormatter),
                    // TextFieldWidget(
                    //     controller: _positionController,
                    //     icon: Icons.work_outline_outlined,
                    //     hintText: "Position",
                    //     onEdit: true,
                    //     textInputFormatter:
                    //         FilteringTextInputFormatter.singleLineFormatter),
                    // TextFieldWidget(
                    //     controller: _unitController,
                    //     icon: Icons.home_work,
                    //     hintText: "Unit",
                    //     onEdit: true,
                    //     textInputFormatter:
                    //         FilteringTextInputFormatter.singleLineFormatter),
                    TextFieldWidget(
                        controller: _addressController,
                        icon: Icons.place,
                        hintText: "Address",
                        onEdit: true,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    DatePickerTextField(
                      labelText: "Birthday",
                      placeholder: "Sep 12, 1998",
                      textEditingController: _birthdateController,
                      icon: Icons.cake,
                      editable: true,
                    ),
                    TextFieldWidget(
                        controller: _folkController,
                        icon: Icons.short_text,
                        hintText: "Folk",
                        onEdit: onEdit,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    MyDropdownButton(
                      selectedValue: sex,
                      values: <String>["Nam", "Nữ"],
                      icon: Icons.male,
                      lable: "Gender",
                      callback: (String _newValue) {
                        sex = _newValue;
                      },
                    ),
                    // TextFieldWidget(
                    //     controller: _salaryController,
                    //     icon: Icons.attach_money,
                    //     hintText: "Current Total Salary",
                    //     onEdit: false,
                    //     textInputFormatter:
                    //         FilteringTextInputFormatter.singleLineFormatter),
                    RelativesExpansionTitle(
                        relatives: _relativesController,
                        onAdd: true,
                        onEdit: true),
                    // AddWorkHistoriesExpansionTitle(
                    //     workHistories: _workHistoryController, onEdit: true),
                    // WorkHistoriesExpansionTitle(
                    //   workHistories: ,
                    //   onEdit: onEdit,
                    // ),
                    // QuotaHistoriesExpansionTitle(
                    //   quotaHistories: ,
                    //   onEdit: onEdit,
                    // ),
                    // AdditionsExpansionTitle(
                    //   additionHistories: widget.employee.additionHistory,
                    //   onEdit: onEdit,
                    // ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        addEmployee();
                      },
                      child: Text("Add employee"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void updateEmployee() {
  //   if (onEdit == !ignore && onEdit == false) {
  //     setState(() {
  //       onEdit = !onEdit;
  //       ignore = !ignore;
  //     });
  //   } else if (_formKey.currentState!.validate() &&
  //       _formKey2.currentState!.validate()) {
  //     setState(() {
  //       onEdit = !onEdit;
  //       ignore = !ignore;
  //     });
  //   }
  // }
}
