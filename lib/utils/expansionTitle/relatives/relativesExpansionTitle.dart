import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staff_management/models/relative.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:staff_management/utils/textField/textField.dart';
import 'package:intl/intl.dart';
import 'package:staff_management/utils/textField/datePickerTextField.dart';

class RelativesExpansionTitle extends StatelessWidget {
  final List<Relative> _relatives;
  final bool _onEdit;
  const RelativesExpansionTitle(
      {Key? key, required List<Relative> relatives, required bool onEdit})
      : _relatives = relatives,
        _onEdit = onEdit,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.only(left: 12),
      title: Row(
        children: [
          Icon(
            Icons.family_restroom,
            color: Colors.grey,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Relatives",
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
        ],
      ),
      children: [
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: _relatives.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
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
              child: ChildRelativeExpansionTitle(
                relative: _relatives[index],
                onEdit: _onEdit,
              ),
            ),
          ),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class ChildRelativeExpansionTitle extends StatefulWidget {
  Relative _relative;
  final bool _onEdit;
  ChildRelativeExpansionTitle(
      {Key? key, required Relative relative, required bool onEdit})
      : _relative = relative,
        _onEdit = onEdit,
        super(key: key);

  @override
  State<ChildRelativeExpansionTitle> createState() =>
      _ChildRelativeExpansionTitleState();
}

class _ChildRelativeExpansionTitleState
    extends State<ChildRelativeExpansionTitle> {
  final TextEditingController _relativeNameController = TextEditingController();
  final TextEditingController _relativeTypeController = TextEditingController();
  final TextEditingController _relativeJobController = TextEditingController();
  final TextEditingController _relativeBirthdateController =
      TextEditingController();

  @override
  void initState() {
    _relativeNameController.text = widget._relative.name;
    _relativeTypeController.text = widget._relative.type;
    _relativeJobController.text = widget._relative.job;
    _relativeBirthdateController.text =
        "${DateFormat('dd/MM/yyyy').format(widget._relative.birthdate.toDate())}";
    super.initState();
  }

  void updateVariables() {
    if (widget._onEdit == false) {
      widget._relative.name = _relativeNameController.text;
      widget._relative.type = _relativeTypeController.text;
      widget._relative.job = _relativeJobController.text;
      widget._relative.birthdate = Timestamp.fromDate(
          DateFormat('dd/MM/yyyy').parse(_relativeBirthdateController.text));
    } else {}
  }

  @override
  void dispose() {
    updateVariables();
    _relativeNameController.dispose();
    _relativeTypeController.dispose();
    _relativeJobController.dispose();
    _relativeBirthdateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: TextFieldWidget(
        controller: _relativeNameController,
        icon: Icon(Icons.person),
        hintText: "Name",
        onEdit: widget._onEdit,
        textInputFormatter: FilteringTextInputFormatter.singleLineFormatter,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: widget._onEdit
              ? MyDropdownButton(
                  selectedValue: widget._relative.type,
                  values: <String>["Vợ/Chồng", "Con cái"],
                  icon: Icon(Icons.merge_type),
                  lable: "Type",
                  callback: (String _newValue) {
                    widget._relative.type = _newValue;
                    _relativeTypeController.text = _newValue;
                  },
                )
              : TextFieldWidget(
                  controller: _relativeTypeController,
                  icon: Icon(Icons.merge_type),
                  hintText: "Type",
                  onEdit: false,
                  textInputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter,
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFieldWidget(
            controller: _relativeJobController,
            icon: Icon(Icons.work),
            hintText: "Job",
            onEdit: widget._onEdit,
            textInputFormatter: FilteringTextInputFormatter.singleLineFormatter,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: DatePickerTextField(
            labelText: "Birthday",
            placeholder: "Sep 12, 1998",
            textEditingController: _relativeBirthdateController,
            editable: widget._onEdit,
            icon: Icon(Icons.cake),
          ),
        ),
      ],
    );
  }
}
