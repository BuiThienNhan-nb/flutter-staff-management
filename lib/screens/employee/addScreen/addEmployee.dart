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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final _formKey2 = GlobalKey<FormState>();
  final _identityCardController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _folkController = TextEditingController();
  final _workdateController = TextEditingController();
  final RxList<Relative> _relatives = <Relative>[].obs;
  final RxList<WorkHistory> _workHistory = <WorkHistory>[].obs;
  final RxList<QuotaHistory> _quotaHistory = <QuotaHistory>[].obs;
  String selectedPosition = "Trợ giảng";
  String selectedUnit = "Khoa Văn hóa Du lịch";
  String selectedQuota = "Giảng viên";
  CollectionReference employees =
      FirebaseFirestore.instance.collection('employees');

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
    await notificationController
        .addEmployeeNotification(employee)
        .then((value) => employeeController.retreiveDetailData());
  }

  @override
  Widget build(BuildContext context) {
    final Size sizeDevice = MediaQuery.of(context).size;
    final sizeWidth = sizeDevice.width;
    final sizeHeight = sizeDevice.height;
    _workdateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    _birthdateController.text = "11/11/1999";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Employee"),
      ),
      body: SingleChildScrollView(
        child: DefaultTextStyle(
          style: TextStyle(color: Colors.blue.shade800),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFieldWidget(
                  controller: _identityCardController,
                  hintText: 'Identity card',
                  icon: Icons.card_membership,
                  onEdit: true,
                  textInputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter,
                  callback: (String _submittedValue) {},
                ),
                TextFieldWidget(
                  controller: _nameController,
                  hintText: 'Name',
                  icon: Icons.person,
                  onEdit: true,
                  textInputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter,
                  callback: (String _submittedValue) {},
                ),
                DatePickerTextField(
                  labelText: "Work day",
                  placeholder: "Sep 12, 1998",
                  textEditingController: _workdateController,
                  icon: Icons.access_time,
                  editable: true,
                  callback: (String _newDateString) {},
                ),
                TextFieldWidget(
                  controller: _addressController,
                  icon: Icons.place,
                  hintText: "Address",
                  onEdit: true,
                  textInputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter,
                  callback: (String _submittedValue) {},
                ),
                DatePickerTextField(
                  labelText: "Birthday",
                  placeholder: "Sep 12, 1998",
                  textEditingController: _birthdateController,
                  icon: Icons.cake,
                  editable: true,
                  callback: (String _newDateString) {},
                ),
                TextFieldWidget(
                  controller: _folkController,
                  icon: Icons.short_text,
                  hintText: "Folk",
                  onEdit: onEdit,
                  textInputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter,
                  callback: (String _submittedValue) {},
                ),
                MyDropdownButton(
                  selectedValue: sex,
                  values: <String>["Nam", "Nữ"],
                  icon: Icons.male,
                  lable: "Gender",
                  callback: (String _newValue) {
                    sex = _newValue;
                  },
                  size: Size(sizeWidth, 70),
                ),
                MyDropdownButton(
                  selectedValue: selectedPosition,
                  values: positionController.listPositionName,
                  icon: Icons.work,
                  lable: "Position",
                  callback: (String _newValue) {
                    selectedPosition = _newValue;
                  },
                  size: Size(sizeWidth, 70),
                ),
                MyDropdownButton(
                  selectedValue: selectedUnit,
                  values: unitController.listUnitName,
                  icon: Icons.groups,
                  lable: "Unit",
                  callback: (String _newValue) {
                    selectedUnit = _newValue;
                  },
                  size: Size(sizeWidth, 70),
                ),
                MyDropdownButton(
                  selectedValue: selectedQuota,
                  values: quotaController.listQuotaName,
                  icon: Icons.hail,
                  lable: "Quota",
                  callback: (String _newValue) {
                    selectedQuota = _newValue;
                  },
                  size: Size(sizeWidth, 70),
                ),
                RelativesExpansionTitle(
                    relatives: _relatives, onAdd: true, onEdit: true),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    // validateAndSave();
                    if (_formKey.currentState!.validate()) {
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
                    }
                  },
                  child: Text("Add employee"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
