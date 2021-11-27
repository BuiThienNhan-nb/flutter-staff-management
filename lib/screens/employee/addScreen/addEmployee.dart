import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/additionHistory.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/models/position.dart';
import 'package:staff_management/models/quota.dart';
import 'package:staff_management/models/quotaHistories.dart';
import 'package:staff_management/models/relative.dart';
import 'package:staff_management/models/unit.dart';
import 'package:staff_management/models/workHistory.dart';
import 'package:staff_management/services/employeeRepo.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:staff_management/utils/expansionTitle/relatives/relativesExpansionTitle.dart';
import 'package:staff_management/utils/textField/textField.dart';
import 'package:staff_management/utils/textField/datePickerTextField.dart';
import 'package:intl/intl.dart';

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
  // final _quotaController = TextEditingController();
  // final _positionController = TextEditingController();
  // final _unitController = TextEditingController();
  // final _sexController = TextEditingController();
  // final _salaryController = TextEditingController();
  final RxList<Relative> _relatives = <Relative>[].obs;
  final RxList<WorkHistory> _workHistory = <WorkHistory>[].obs;
  final RxList<QuotaHistory> _quotaHistory = <QuotaHistory>[].obs;
  String selectedPosition = "Trợ giảng";
  String selectedUnit = "Khoa Văn hóa Du lịch";
  String selectedQuota = "Giảng viên";
  CollectionReference employees =
      FirebaseFirestore.instance.collection('employees');

  // List<String> listPositionName = positionController.listPositionName;
  String sex = 'Nam';
  bool onEdit = true;
  bool ignore = true;
  DateTime workDate = DateTime.now();

  void createWorkQuota() {
    // get unit
    Unit _unit = unitController.listUnits
        .where((element) => element.name == selectedUnit)
        .first;
    unitController.onInit();

    // get position
    Position _position = positionController.listPositions
        .where((element) => element.name == selectedPosition)
        .first;
    positionController.onInit();

    // create work history
    _workHistory.add(new WorkHistory(
        uid: "uid",
        dismissDate: Timestamp.fromDate(workDate.add(const Duration(days: -1))),
        joinDate: Timestamp.fromDate(workDate),
        positionId: _position.uid,
        unitId: _unit.uid,
        position: _position.obs,
        unit: _unit.obs));

    // get quota
    Quota _quota = quotaController.listQuotas
        .where((element) => element.name == selectedQuota)
        .first;
    quotaController.onInit();

    // create quota history
    _quotaHistory.add(new QuotaHistory(
        uid: "uid",
        quotaId: _quota.uid,
        joinDate: Timestamp.fromDate(workDate),
        dismissDate: Timestamp.fromDate(workDate.add(const Duration(days: -1))),
        quota: _quota.obs));
  }

  Future<void> addEmployee() async {
    workDate = DateFormat('dd/MM/yyyy').parse(_workdateController.text);
    createWorkQuota();
    Employee employee = Employee(
        uid: 'uid',
        address: _addressController.text,
        birthdate: Timestamp.fromDate(
            DateFormat('dd/MM/yyyy').parse(_birthdateController.text)),
        folk: _folkController.text,
        identityCard: _identityCardController.text,
        name: _nameController.text,
        quotaHistory: _quotaHistory,
        retirementDate: Timestamp.fromDate(new DateTime(workDate.year + 5)),
        sex: sex,
        workDate: Timestamp.fromDate(workDate),
        relative: _relatives,
        workHistory: _workHistory,
        additionHistory: <AdditionHistory>[].obs,
        salary: 0);
    employeeController.listEmployees.add(employee);
    await employeeRepo.addEmployee(employee);
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
                    MyDropdownButton(
                        selectedValue: selectedPosition,
                        values: positionController.listPositionName,
                        icon: Icons.work,
                        lable: "Position",
                        callback: (String _newValue) {
                          selectedPosition = _newValue;
                        }),
                    MyDropdownButton(
                        selectedValue: selectedUnit,
                        values: unitController.listUnitName,
                        icon: Icons.groups,
                        lable: "Unit",
                        callback: (String _newValue) {
                          selectedUnit = _newValue;
                        }),
                    MyDropdownButton(
                        selectedValue: selectedQuota,
                        values: quotaController.listQuotaName,
                        icon: Icons.hail,
                        lable: "Quota",
                        callback: (String _newValue) {
                          selectedQuota = _newValue;
                        }),
                    RelativesExpansionTitle(
                        relatives: _relatives, onAdd: true, onEdit: true),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        addEmployee().then((value) {
                          Get.back();
                          final snackBar = SnackBar(
                            duration: Duration(milliseconds: 500),
                            content: Text(
                              "Add employee successful",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
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
}
