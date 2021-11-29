import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staff_management/models/relative.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:staff_management/utils/textField/textField.dart';
import 'package:intl/intl.dart';
import 'package:staff_management/utils/textField/datePickerTextField.dart';

class RelativesExpansionTitle extends StatefulWidget {
  final List<Relative> _relatives;
  final bool _onEdit;
  final bool _onAdd;
  const RelativesExpansionTitle(
      {Key? key,
      required List<Relative> relatives,
      required bool onEdit,
      required bool onAdd})
      : _relatives = relatives,
        _onEdit = onEdit,
        _onAdd = onAdd,
        super(key: key);

  @override
  State<RelativesExpansionTitle> createState() =>
      _RelativesExpansionTitleState();
}

class _RelativesExpansionTitleState extends State<RelativesExpansionTitle> {
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
          itemCount: widget._relatives.length,
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
                relative: widget._relatives[index],
                onEdit: widget._onEdit,
              ),
            ),
          ),
        ),
        widget._onAdd
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Relative _relative = new Relative(
                          uid: "uid",
                          birthdate: Timestamp.fromDate(DateTime.now()),
                          job: "",
                          name: "",
                          type: "Vợ/Chồng");
                      // Get.bottomSheet(
                      //   //ChildRelativeExpansionTitle(relative: new Relative(uid: "uid", birthdate: birthdate, job: job, name: name, type: type), onEdit: true);
                      //   AddRelative(
                      //       relative: _relative,
                      //       callback: (Relative _newRelative) {
                      //         _relative = _newRelative;
                      //       }),
                      // );
                      widget._relatives.add(_relative);
                      setState(() {});
                    },
                  ),
                ],
              )
            : Container(),
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
    widget._relative.name = _relativeNameController.text;
    widget._relative.type = _relativeTypeController.text;
    widget._relative.job = _relativeJobController.text;
    widget._relative.birthdate = Timestamp.fromDate(
        DateFormat('dd/MM/yyyy').parse(_relativeBirthdateController.text));
  }

  @override
  void dispose() {
    super.dispose();
    // updateVariables();
    _relativeNameController.dispose();
    _relativeTypeController.dispose();
    _relativeJobController.dispose();
    _relativeBirthdateController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeWidth = MediaQuery.of(context).size.width;
    return ExpansionTile(
      title: TextFieldWidget(
        controller: _relativeNameController,
        icon: Icons.person,
        hintText: "Name",
        onEdit: widget._onEdit,
        textInputFormatter: FilteringTextInputFormatter.singleLineFormatter,
        callback: (String _submittedValue) =>
            widget._relative.name = _submittedValue,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: widget._onEdit
              ? MyDropdownButton(
                  selectedValue: widget._relative.type,
                  values: <String>["Vợ/Chồng", "Con cái"],
                  icon: Icons.merge_type,
                  lable: "Type",
                  callback: (String _newValue) {
                    setState(() {
                      widget._relative.type = _newValue;
                      _relativeTypeController.text = _newValue;
                    });
                  },
                  size: Size(sizeWidth, 70),
                )
              : TextFieldWidget(
                  controller: _relativeTypeController,
                  icon: Icons.merge_type,
                  hintText: "Type",
                  onEdit: false,
                  textInputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter,
                  callback: (String _submittedValue) {},
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFieldWidget(
            controller: _relativeJobController,
            icon: Icons.work,
            hintText: "Job",
            onEdit: widget._onEdit,
            textInputFormatter: FilteringTextInputFormatter.singleLineFormatter,
            callback: (String _submittedValue) =>
                widget._relative.job = _submittedValue,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: DatePickerTextField(
            labelText: "Birthday",
            placeholder: "Sep 12, 1998",
            textEditingController: _relativeBirthdateController,
            editable: widget._onEdit,
            icon: Icons.cake,
            callback: (String _newDateString) => widget._relative.birthdate =
                Timestamp.fromDate(
                    DateFormat('dd/MM/yyyy').parse(_newDateString)),
          ),
        ),
      ],
    );
  }
}

typedef Callback = void Function(Relative _newRelative);
