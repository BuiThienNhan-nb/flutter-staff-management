import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:staff_management/utils/expansionTitle/additions/additionExpansionTitle.dart';
import 'package:staff_management/utils/expansionTitle/quotaHistories/quotaHisExpansionTitle.dart';
import 'package:staff_management/utils/expansionTitle/relatives/relativesExpansionTitle.dart';
import 'package:staff_management/utils/expansionTitle/workHistories/workHisExpansionTitle.dart';
import 'package:staff_management/utils/textField/textField.dart';
import 'package:staff_management/utils/textField/datePickerTextField.dart';
import 'package:intl/intl.dart';

class EmployeeDetail extends StatefulWidget {
  final Employee employee;

  const EmployeeDetail({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  _EmployeeDetailState createState() => _EmployeeDetailState();
}

class _EmployeeDetailState extends State<EmployeeDetail> {
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _identityCardController = TextEditingController();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _birthdateController = TextEditingController();
  final _folkController = TextEditingController();
  final _quotaController = TextEditingController();
  final _positionController = TextEditingController();
  final _unitController = TextEditingController();
  final _sexController = TextEditingController();
  final _salaryController = TextEditingController();
  String dropdownValue = 'Nam';
  bool onEdit = false;
  bool ignore = true;

  @override
  void initState() {
    super.initState();
    _identityCardController.text = "${widget.employee.identityCard}";
    _nameController.text = "${widget.employee.name}";
    _addressController.text = "${widget.employee.address}";
    _birthdateController.text =
        '${DateFormat('dd/MM/yyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.employee.birthdate.seconds * 1000))}';
    _folkController.text = "${widget.employee.folk}";
    _quotaController.text =
        "${widget.employee.quotaHistory.value[0].quota.value.name}";
    _positionController.text =
        "${widget.employee.workHistory.first.position.value.name}";
    _unitController.text =
        "${widget.employee.workHistory.first.unit.value.name}";
    _sexController.text = "${widget.employee.sex}";
    _salaryController.text =
        "${widget.employee.getSalaryWithAdditionsToCurrency()}";
  }

  @override
  void dispose() {
    _addressController.dispose();
    _birthdateController.dispose();
    _identityCardController.dispose();
    _nameController.dispose();
    _folkController.dispose();
    _quotaController.dispose();
    _positionController.dispose();
    _unitController.dispose();
    _sexController.dispose();
    _salaryController.dispose();
    super.dispose();
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
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: sizeHeight * 0.15,
                      child: ClipOval(
                        child: Container(
                          width: sizeWidth * 0.3,
                          color: Colors.grey.shade400,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 70,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: onEdit
                    ? Form(
                        key: _formKey2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 77,
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize: 15, color: Colors.blue.shade800),
                                controller: _identityCardController,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                keyboardType: TextInputType.phone,
                                validator: (input) {
                                  if (input == null || input.isEmpty)
                                    return "Can't be null";
                                },
                              ),
                            ),
                            Text(" | ", style: TextStyle(fontSize: 15)),
                            Container(
                              width: 90,
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize: 15, color: Colors.blue.shade800),
                                controller: _nameController,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                keyboardType: TextInputType.name,
                                validator: (input) {
                                  if (input == null || input.isEmpty)
                                    return "Can't be null";
                                },
                              ),
                            )
                          ],
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${widget.employee.identityCard} | ${widget.employee.name}",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          )
                        ],
                      ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                        controller: _quotaController,
                        icon: Icons.work,
                        hintText: "Quota",
                        onEdit: false,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    TextFieldWidget(
                        controller: _positionController,
                        icon: Icons.work_outline_outlined,
                        hintText: "Position",
                        onEdit: false,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    TextFieldWidget(
                        controller: _unitController,
                        icon: Icons.home_work,
                        hintText: "Unit",
                        onEdit: false,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    TextFieldWidget(
                        controller: _addressController,
                        icon: Icons.place,
                        hintText: "Address",
                        onEdit: onEdit,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    DatePickerTextField(
                      labelText: "Birthday",
                      placeholder: "Sep 12, 1998",
                      textEditingController: _birthdateController,
                      editable: onEdit,
                      icon: Icons.cake,
                    ),
                    TextFieldWidget(
                        controller: _folkController,
                        icon: Icons.short_text,
                        hintText: "Folk",
                        onEdit: onEdit,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    !onEdit
                        ? TextFieldWidget(
                            controller: _sexController,
                            icon: Icons.male,
                            hintText: "Gender",
                            onEdit: false,
                            textInputFormatter:
                                FilteringTextInputFormatter.singleLineFormatter)
                        : MyDropdownButton(
                            selectedValue: _sexController.text,
                            values: <String>["Nam", "Nữ"],
                            icon: Icons.male,
                            lable: "Gender",
                            callback: (String _newValue) {
                              _sexController.text = _newValue;
                            },
                          ),
                    TextFieldWidget(
                        controller: _salaryController,
                        icon: Icons.attach_money,
                        hintText: "Current Total Salary",
                        onEdit: false,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    RelativesExpansionTitle(
                        relatives: widget.employee.relative, onEdit: onEdit),
                    WorkHistoriesExpansionTitle(
                      workHistories: widget.employee.workHistory,
                      onEdit: onEdit,
                    ),
                    QuotaHistoriesExpansionTitle(
                      quotaHistories: widget.employee.quotaHistory,
                      onEdit: onEdit,
                    ),
                    AdditionsExpansionTitle(
                      additionHistories: widget.employee.additionHistory,
                      onEdit: onEdit,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        updateEmployee();
                      },
                      child: Text(onEdit ? "Save changes" : "Edit Employee"),
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

  void updateEmployee() {
    if (onEdit == !ignore && onEdit == false) {
      setState(() {
        onEdit = !onEdit;
        ignore = !ignore;
      });
    } else if (_formKey.currentState!.validate() &&
        _formKey2.currentState!.validate()) {
      setState(() {
        onEdit = !onEdit;
        ignore = !ignore;
      });
    }
  }
}
