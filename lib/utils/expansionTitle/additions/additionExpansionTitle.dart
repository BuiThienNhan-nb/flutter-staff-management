import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/addition.dart';
import 'package:staff_management/models/additionHistory.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:staff_management/utils/textField/textField.dart';
import 'package:intl/intl.dart';
import 'package:staff_management/utils/textField/datePickerTextField.dart';

class AdditionsExpansionTitle extends StatelessWidget {
  final List<AdditionHistory> _additionHistories;
  final bool _onEdit;
  const AdditionsExpansionTitle(
      {Key? key,
      required List<AdditionHistory> additionHistories,
      required bool onEdit})
      : _additionHistories = additionHistories,
        _onEdit = onEdit,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.only(left: 12),
      title: Row(
        children: [
          Icon(
            Icons.card_giftcard,
            color: Colors.grey,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Additions",
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
          itemCount: _additionHistories.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.fromLTRB(12, 2.5, 12, 2.5),
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
                additionHistory: _additionHistories[index],
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
  AdditionHistory _additionHistory;
  final bool _onEdit;
  ChildRelativeExpansionTitle(
      {Key? key,
      required AdditionHistory additionHistory,
      required bool onEdit})
      : _additionHistory = additionHistory,
        _onEdit = onEdit,
        super(key: key);

  @override
  State<ChildRelativeExpansionTitle> createState() =>
      _ChildRelativeExpansionTitleState();
}

class _ChildRelativeExpansionTitleState
    extends State<ChildRelativeExpansionTitle> {
  final TextEditingController _additionNameController = TextEditingController();
  final TextEditingController _additionDateController = TextEditingController();

  @override
  void initState() {
    _additionNameController.text =
        widget._additionHistory.addition.value.content;
    _additionDateController.text =
        "${DateFormat('dd/MM/yyyy').format(widget._additionHistory.date.toDate())}";
    super.initState();
    additionController.initListAdditionName();
  }

  void updateVariables() {
    if (widget._onEdit == false) {
      // update addition
      Addition _addition = additionController.listAdditions
          .where((element) => element.content == _additionNameController.text)
          .first;
      widget._additionHistory.addition.value = _addition;
      additionController.onInit();

      // update date
      widget._additionHistory.date = Timestamp.fromDate(
          DateFormat('dd/MM/yyyy').parse(_additionDateController.text));
    } else {}
  }

  @override
  void dispose() {
    updateVariables();
    _additionNameController.dispose();
    _additionDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: widget._onEdit
          ? MyDropdownButton(
              selectedValue: widget._additionHistory.addition.value.content,
              values: additionController.listAdditionName,
              icon: Icon(Icons.content_copy),
              lable: "Addtions",
              callback: (String _newValue) {
                widget._additionHistory.addition.value.content = _newValue;
                _additionNameController.text = _newValue;
              },
            )
          : TextFieldWidget(
              controller: _additionNameController,
              icon: Icon(Icons.content_copy),
              hintText: "Addtions",
              onEdit: widget._onEdit,
              textInputFormatter:
                  FilteringTextInputFormatter.singleLineFormatter,
            ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: DatePickerTextField(
            labelText: "Date Receive",
            placeholder: "Sep 12, 1998",
            textEditingController: _additionDateController,
            editable: widget._onEdit,
            icon: Icon(Icons.date_range),
          ),
        ),
      ],
    );
  }
}