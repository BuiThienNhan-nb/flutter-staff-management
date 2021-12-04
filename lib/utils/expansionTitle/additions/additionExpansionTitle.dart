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
import 'package:get/get.dart';

class AdditionsExpansionTitle extends StatefulWidget {
  final List<AdditionHistory> _additionHistories;
  final bool _onEdit;
  final bool _onAdd;
  const AdditionsExpansionTitle(
      {Key? key,
      required List<AdditionHistory> additionHistories,
      required bool onEdit,
      required bool onAdd})
      : _additionHistories = additionHistories,
        _onEdit = onEdit,
        _onAdd = onAdd,
        super(key: key);
  @override
  State<AdditionsExpansionTitle> createState() =>
      _AdditionsExpansionTitleState();
}

class _AdditionsExpansionTitleState extends State<AdditionsExpansionTitle> {
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
          itemCount: widget._additionHistories.length,
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
              child: ChildAdditionExpansionTitle(
                additionHistory: widget._additionHistories[index],
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
                      AdditionHistory _addition = new AdditionHistory(
                        uid: 'uid',
                        additionId: 'HTEGwD5TpvMPHBwUaQDG',
                        date: Timestamp.fromDate(DateTime.now()),
                        addition: new Addition(
                                uid: 'HTEGwD5TpvMPHBwUaQDG',
                                content: 'Giảng viên dạy giỏi',
                                isReward: true,
                                value: 1500)
                            .obs,
                      );
                      widget._additionHistories.add(_addition);
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
class ChildAdditionExpansionTitle extends StatefulWidget {
  AdditionHistory _additionHistory;
  final bool _onEdit;
  ChildAdditionExpansionTitle(
      {Key? key,
      required AdditionHistory additionHistory,
      required bool onEdit})
      : _additionHistory = additionHistory,
        _onEdit = onEdit,
        super(key: key);

  @override
  State<ChildAdditionExpansionTitle> createState() =>
      _ChildAdditionExpansionTitleState();
}

class _ChildAdditionExpansionTitleState
    extends State<ChildAdditionExpansionTitle> {
  final TextEditingController _additionNameController = TextEditingController();
  final TextEditingController _additionDateController = TextEditingController();

  @override
  void initState() {
    _additionNameController.text =
        widget._additionHistory.addition.value.content;
    _additionDateController.text =
        "${DateFormat('dd/MM/yyyy').format(widget._additionHistory.date.toDate())}";
    super.initState();
  }

  @override
  void dispose() {
    // updateVariables();
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
              icon: Icons.content_copy,
              lable: "Addtions",
              callback: (String _newValue) {
                setState(() {
                  widget._additionHistory.addition.value.content = _newValue;
                  _additionNameController.text = _newValue;
                });
              },
              size: Size(400, 70),
            )
          : TextFieldWidget(
              controller: _additionNameController,
              icon: Icons.content_copy,
              hintText: "Addtions",
              onEdit: widget._onEdit,
              textInputFormatter:
                  FilteringTextInputFormatter.singleLineFormatter,
              callback: (String _submittedValue) {},
            ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: DatePickerTextField(
            labelText: "Date Receive",
            placeholder: "Sep 12, 1998",
            textEditingController: _additionDateController,
            editable: widget._onEdit,
            icon: Icons.date_range,
            callback: (String _newDateString) => widget._additionHistory.date =
                Timestamp.fromDate(DateFormat('dd/MM/yyyy')
                    .parse(_additionDateController.text)),
          ),
        ),
      ],
    );
  }
}
