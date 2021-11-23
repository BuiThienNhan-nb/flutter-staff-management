import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/position.dart';
import 'package:staff_management/models/relative.dart';
import 'package:staff_management/models/workHistory.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:staff_management/utils/textField/textField.dart';
import 'package:intl/intl.dart';
import 'package:staff_management/utils/textField/textFieldBirthday.dart';

class WorkHistoriesExpansionTitle extends StatelessWidget {
  final List<WorkHistory> _workHistories;
  final bool _onEdit;
  const WorkHistoriesExpansionTitle(
      {Key? key,
      required List<WorkHistory> workHistories,
      required bool onEdit})
      : _workHistories = workHistories,
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
            "Work histories",
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
          itemCount: _workHistories.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(12),
            child: ChildRelativeExpansionTitle(
              workHistory: _workHistories[index],
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
  WorkHistory _workHistory;
  final bool _onEdit;
  ChildRelativeExpansionTitle(
      {Key? key, required WorkHistory workHistory, required bool onEdit})
      : _workHistory = workHistory,
        _onEdit = onEdit,
        super(key: key);

  @override
  State<ChildRelativeExpansionTitle> createState() =>
      _ChildRelativeExpansionTitleState();
}

class _ChildRelativeExpansionTitleState
    extends State<ChildRelativeExpansionTitle> {
  final TextEditingController _workHistoryUnitController =
      TextEditingController();
  final TextEditingController _workHistoryPositionController =
      TextEditingController();
  final TextEditingController _workHistoryJoinDateController =
      TextEditingController();
  final TextEditingController _workHistoryDismissDateController =
      TextEditingController();

  @override
  void initState() {
    _workHistoryUnitController.text = widget._workHistory.unit.value.name;
    _workHistoryPositionController.text =
        widget._workHistory.position.value.name;
    _workHistoryJoinDateController.text =
        "${DateFormat('dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(widget._workHistory.joinDate.seconds * 1000))}";
    ;
    _workHistoryDismissDateController.text =
        "${DateFormat('dd/MM/yyyy').format(DateTime.fromMicrosecondsSinceEpoch(widget._workHistory.dismissDate.seconds * 1000))}";
    positionController.initListPositionName();
    unitController.initListUnitName();
    super.initState();
  }

  void updateVariables() {
    widget._workHistory.unit.value.name = _workHistoryUnitController.text;
    widget._workHistory.position.value.name =
        _workHistoryPositionController.text;
    widget._workHistory.joinDate = Timestamp.fromDate(
        DateFormat('dd/MM/yyyy').parse(_workHistoryJoinDateController.text));
    widget._workHistory.dismissDate = Timestamp.fromDate(
        DateFormat('dd/MM/yyyy').parse(_workHistoryDismissDateController.text));
  }

  @override
  void dispose() {
    updateVariables();
    _workHistoryUnitController.dispose();
    _workHistoryPositionController.dispose();
    _workHistoryJoinDateController.dispose();
    _workHistoryDismissDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: widget._onEdit
          ? MyDropdownButton(
              selectedValue: widget._workHistory.unit.value.name,
              values: unitController.listUnitName,
              icon: Icon(Icons.merge_type),
              lable: "{Position}",
              callback: (String _newValue) {
                widget._workHistory.position.value.name = _newValue;
                _workHistoryPositionController.text = _newValue;
              },
            )
          : TextFieldWidget(
              controller: _workHistoryPositionController,
              icon: Icon(Icons.merge_type),
              hintText: "Position",
              onEdit: false,
              textInputFormatter:
                  FilteringTextInputFormatter.singleLineFormatter,
            ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: widget._onEdit
              ? MyDropdownButton(
                  selectedValue: widget._workHistory.position.value.name,
                  values: positionController.listPositionName,
                  icon: Icon(Icons.merge_type),
                  lable: "{Position}",
                  callback: (String _newValue) {
                    widget._workHistory.position.value.name = _newValue;
                    _workHistoryPositionController.text = _newValue;
                  },
                )
              : TextFieldWidget(
                  controller: _workHistoryPositionController,
                  icon: Icon(Icons.merge_type),
                  hintText: "Position",
                  onEdit: false,
                  textInputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter,
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFieldBirthday(
            labelText: "Join date",
            placeholder: "Sep 12, 1998",
            textEditingController: _workHistoryJoinDateController,
            editable: widget._onEdit,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: TextFieldBirthday(
            labelText: "Birthday",
            placeholder: "Sep 12, 1998",
            textEditingController: _workHistoryDismissDateController,
            editable: widget._onEdit,
          ),
        ),
      ],
    );
  }
}
