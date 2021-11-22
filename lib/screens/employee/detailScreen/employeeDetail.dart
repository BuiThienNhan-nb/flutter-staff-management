import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staff_management/models/employee.dart';
import 'package:staff_management/utils/textField.dart';
import 'package:staff_management/utils/textFieldBirthday.dart';
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
  final _addressController = TextEditingController();
  final _birthdateController = TextEditingController();
  // final _identityCardController = TextEditingController();
  final _folkController = TextEditingController();
  final _quotaController = TextEditingController();
  final _positionController = TextEditingController();
  final _unitController = TextEditingController();
  final _sexController = TextEditingController();
  final _salaryController = TextEditingController();
  final _relativeNameController = TextEditingController();
  final _workHistoryJoinDateController = TextEditingController();
  String dropdownValue = 'Nam';
  bool editable = false;
  bool ignore = true;

  @override
  void initState() {
    super.initState();
    _addressController.text = "${widget.employee.address}";
    _birthdateController.text =
        '${DateFormat.yMMMd().format(DateTime.fromMillisecondsSinceEpoch(widget.employee.birthdate.millisecondsSinceEpoch))}';
    // _identityCardController.text = "${widget.employee.identityCard}";
    _folkController.text = "${widget.employee.folk}";
    _quotaController.text = "${widget.employee.quotaHistories.value[0].name}";
    _positionController.text =
        "${widget.employee.workHistory.first.position.value.name}";
    _unitController.text =
        "${widget.employee.workHistory.first.unit.value.name}";
    _sexController.text = "${widget.employee.sex}";
    _salaryController.text =
        "${widget.employee.getSalaryWithAdditionsToCurrency()}";
    _relativeNameController.text = "${widget.employee.relative.first.name}";
    _workHistoryJoinDateController.text =
        "${DateFormat('MM/dd/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(widget.employee.workHistory.first.joinDate.millisecondsSinceEpoch))}";
  }

  @override
  void dispose() {
    _addressController.dispose();
    _birthdateController.dispose();
    // _identityCardController.dispose();
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text("${widget.employee.uid} | ${widget.employee.name}",
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
                    // TextFieldWidget(
                    //     controller: _identityCardController,
                    //     icon: Icon(Icons.credit_card),
                    //     hintText: "Identity Card",
                    //     editable: editable,
                    //     textInputFormatter:
                    //         FilteringTextInputFormatter.singleLineFormatter),
                    TextFieldWidget(
                        controller: _quotaController,
                        icon: Icon(Icons.work),
                        hintText: "Quota",
                        editable: editable,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    TextFieldWidget(
                        controller: _positionController,
                        icon: Icon(Icons.work_outline_outlined),
                        hintText: "Position",
                        editable: editable,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    TextFieldWidget(
                        controller: _unitController,
                        icon: Icon(Icons.home_work),
                        hintText: "Unit",
                        editable: editable,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    TextFieldWidget(
                        controller: _addressController,
                        icon: Icon(Icons.place),
                        hintText: "Address",
                        editable: editable,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    TextFieldBirthday(
                      labelText: "Birthday",
                      placeholder: "Sep 12, 1998",
                      textEditingController: _birthdateController,
                      editable: editable,
                    ),
                    TextFieldWidget(
                        controller: _folkController,
                        icon: Icon(Icons.short_text),
                        hintText: "Folk",
                        editable: editable,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    Container(
                      height: 60,
                      child: IgnorePointer(
                        ignoring: ignore,
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.male),
                            labelText: 'Gender',
                          ),
                          value: dropdownValue,
                          items: <String>['Nam', 'Nữ'].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          hint: Text('Gender'),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownValue = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                    TextFieldWidget(
                        controller: _salaryController,
                        icon: Icon(Icons.attach_money),
                        hintText: "Current Total Salary",
                        editable: false,
                        textInputFormatter:
                            FilteringTextInputFormatter.singleLineFormatter),
                    ExpansionTile(
                      tilePadding: EdgeInsets.only(left: 12),
                      title: Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Thân nhân",
                            style: TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        ListTile(
                          title: TextFieldWidget(
                              controller: _relativeNameController,
                              icon: Icon(Icons.person),
                              hintText: "Em trai",
                              editable: editable,
                              textInputFormatter: FilteringTextInputFormatter
                                  .singleLineFormatter),
                        )
                      ],
                    ),
                    ExpansionTile(
                      tilePadding: EdgeInsets.only(left: 12),
                      title: Row(
                        children: [
                          Icon(Icons.person_pin_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Quá trình công tác",
                            style: TextStyle(
                              fontSize: 17.0,
                            ),
                          ),
                        ],
                      ),
                      children: <Widget>[
                        ListTile(
                          title: TextFieldWidget(
                              controller: _workHistoryJoinDateController,
                              icon: Icon(Icons.access_time_outlined),
                              hintText: "Ngày vào làm",
                              editable: editable,
                              textInputFormatter: FilteringTextInputFormatter
                                  .singleLineFormatter),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          editable = !editable;
                          ignore = !ignore;
                        });
                      },
                      child: Text(editable ? "Save changes" : "Edit Employee"),
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
