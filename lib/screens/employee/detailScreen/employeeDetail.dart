import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
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
    _quotaController.text = "${widget.employee.quotaHistories.value[0].name}";
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
                              width: 88,
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize: 17, color: Colors.blue.shade800),
                                controller: _identityCardController,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                keyboardType: TextInputType.phone,
                                validator: (input) {
                                  if (input == null || input.isEmpty)
                                    return 'This field is required';
                                },
                              ),
                            ),
                            Text(" | "),
                            Container(
                              width: 90,
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize: 17, color: Colors.blue.shade800),
                                controller: _nameController,
                                decoration:
                                    InputDecoration(border: InputBorder.none),
                                keyboardType: TextInputType.name,
                                validator: (input) {
                                  if (input == null || input.isEmpty)
                                    return 'This field is required';
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
                              fontSize: 17,
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
                        icon: Icon(Icons.work),
                        hintText: "Quota",
                        onEdit: false,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    TextFieldWidget(
                        controller: _positionController,
                        icon: Icon(Icons.work_outline_outlined),
                        hintText: "Position",
                        onEdit: false,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    TextFieldWidget(
                        controller: _unitController,
                        icon: Icon(Icons.home_work),
                        hintText: "Unit",
                        onEdit: false,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    TextFieldWidget(
                        controller: _addressController,
                        icon: Icon(Icons.place),
                        hintText: "Address",
                        onEdit: onEdit,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    DatePickerTextField(
                      labelText: "Birthday",
                      placeholder: "Sep 12, 1998",
                      textEditingController: _birthdateController,
                      editable: onEdit,
                      icon: Icon(Icons.cake),
                    ),
                    TextFieldWidget(
                        controller: _folkController,
                        icon: Icon(Icons.short_text),
                        hintText: "Folk",
                        onEdit: onEdit,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    !onEdit
                        ? TextFieldWidget(
                            controller: _sexController,
                            icon: Icon(Icons.male),
                            hintText: "Gender",
                            onEdit: false,
                            textInputFormatter:
                                FilteringTextInputFormatter.singleLineFormatter)
                        : MyDropdownButton(
                            selectedValue: _sexController.text,
                            values: <String>["Nam", "Nữ"],
                            icon: Icon(Icons.male),
                            lable: "Gender",
                            callback: (String _newValue) {
                              _sexController.text = _newValue;
                            },
                          ),
                    TextFieldWidget(
                        controller: _salaryController,
                        icon: Icon(Icons.attach_money),
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
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          onEdit = !onEdit;
                          ignore = !ignore;
                        });
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
}
