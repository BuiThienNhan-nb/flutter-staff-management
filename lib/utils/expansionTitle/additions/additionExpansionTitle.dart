import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/addition.dart';
import 'package:staff_management/models/quotaHistories.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:staff_management/utils/textField/textField.dart';
import 'package:intl/intl.dart';
import 'package:staff_management/utils/textField/datePickerTextField.dart';

class AdditionsExpansionTitle extends StatelessWidget {
  final List<Addition> _additions;
  final bool _onEdit;
  const AdditionsExpansionTitle(
      {Key? key, required List<Addition> additions, required bool onEdit})
      : _additions = additions,
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
          itemCount: _additions.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(12),
            child: ChildRelativeExpansionTitle(
              addition: _additions[index],
              onEdit: _onEdit,
            ),
          ),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class ChildRelativeExpansionTitle extends StatefulWidget {
  Addition _addition;
  final bool _onEdit;
  ChildRelativeExpansionTitle(
      {Key? key, required Addition addition, required bool onEdit})
      : _addition = addition,
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
    _additionNameController.text = widget._addition.content;
    _additionDateController.text =
        "${DateFormat('dd/MM/yyyy').format(widget._addition.date.toDate())}";
    super.initState();
    additionController.initListAdditionName();
  }

  void updateVariables() {
    widget._addition.content = _additionNameController.text;
    widget._addition.date = Timestamp.fromDate(
        DateFormat('dd/MM/yyyy').parse(_additionDateController.text));
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
              selectedValue: widget._addition.content,
              values: additionController.listAdditionName,
              icon: Icon(Icons.content_copy),
              lable: "Addtions",
              callback: (String _newValue) {
                widget._addition.content = _newValue;
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
            labelText: "Date",
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
