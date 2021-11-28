import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/position.dart';
import 'package:staff_management/models/unit.dart';
import 'package:staff_management/models/workHistory.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:staff_management/utils/textField/textField.dart';
import 'package:intl/intl.dart';
import 'package:staff_management/utils/textField/datePickerTextField.dart';

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
            Icons.change_history,
            color: Colors.grey,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Work Histories",
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
              child: ChildWorkHistoryExpansionTitle(
                workHistory: _workHistories[index],
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
class ChildWorkHistoryExpansionTitle extends StatefulWidget {
  WorkHistory _workHistory;
  final bool _onEdit;
  ChildWorkHistoryExpansionTitle(
      {Key? key, required WorkHistory workHistory, required bool onEdit})
      : _workHistory = workHistory,
        _onEdit = onEdit,
        super(key: key);

  @override
  State<ChildWorkHistoryExpansionTitle> createState() =>
      _ChildWorkHistoryExpansionTitleState();
}

class _ChildWorkHistoryExpansionTitleState
    extends State<ChildWorkHistoryExpansionTitle> {
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
        "${DateFormat('dd/MM/yyyy').format(widget._workHistory.joinDate.toDate())}";

    _workHistoryDismissDateController.text = widget._workHistory.dismissDate
            .toDate()
            .isBefore(widget._workHistory.joinDate.toDate())
        ? "Current"
        : "${DateFormat('dd/MM/yyyy').format(widget._workHistory.dismissDate.toDate())}";
    super.initState();
  }

  void updateVariables() {
    // update unit
    Unit _unit = unitController.listUnits
        .where((element) => element.name == _workHistoryUnitController.text)
        .first;
    widget._workHistory.unitId = _unit.uid;
    widget._workHistory.unit.value = _unit;
    unitController.onInit();

    // update position
    Position _position = positionController.listPositions
        .where((element) => element.name == _workHistoryPositionController.text)
        .first;
    widget._workHistory.positionId = _position.uid;
    widget._workHistory.position.value = _position;
    positionController.onInit();

    // update date
    widget._workHistory.joinDate = Timestamp.fromDate(
        DateFormat('dd/MM/yyyy').parse(_workHistoryJoinDateController.text));
    widget._workHistory.dismissDate =
        _workHistoryDismissDateController.text == "Current"
            ? widget._workHistory.dismissDate
            : Timestamp.fromDate(DateFormat('dd/MM/yyyy')
                .parse(_workHistoryDismissDateController.text));
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
    final sizeWidth = MediaQuery.of(context).size.width;
    return ExpansionTile(
      title: widget._onEdit
          ? MyDropdownButton(
              selectedValue: widget._workHistory.unit.value.name,
              values: unitController.listUnitName,
              icon: Icons.groups,
              lable: "Unit",
              callback: (String _newValue) {
                setState(() {
                  widget._workHistory.unit.value.name = _newValue;
                  _workHistoryUnitController.text = _newValue;
                });
              },
              size: Size(sizeWidth, 70),
            )
          : TextFieldWidget(
              controller: _workHistoryUnitController,
              icon: Icons.groups,
              hintText: "Unit",
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
                  icon: Icons.hail,
                  lable: "Position",
                  callback: (String _newValue) {
                    setState(() {
                      widget._workHistory.position.value.name = _newValue;
                      _workHistoryPositionController.text = _newValue;
                    });
                  },
                  size: Size(sizeWidth, 70),
                )
              : TextFieldWidget(
                  controller: _workHistoryPositionController,
                  icon: Icons.hail,
                  hintText: "Position",
                  onEdit: false,
                  textInputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter,
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: DatePickerTextField(
            labelText: "Join Date",
            placeholder: "Sep 12, 1998",
            textEditingController: _workHistoryJoinDateController,
            editable: widget._onEdit,
            icon: Icons.date_range,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: DatePickerTextField(
            labelText: "Dismiss Date",
            placeholder: "Sep 12, 1998",
            textEditingController: _workHistoryDismissDateController,
            editable: widget._onEdit,
            icon: Icons.date_range,
          ),
        ),
      ],
    );
  }
}
