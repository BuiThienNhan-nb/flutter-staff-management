import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/workHistory.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:staff_management/utils/textField/textField.dart';
import 'package:staff_management/utils/textField/datePickerTextField.dart';

class AddWorkHistoriesExpansionTitle extends StatelessWidget {
  final List<WorkHistory> _workHistories;
  final bool _onEdit;
  const AddWorkHistoriesExpansionTitle(
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
        // ListView.builder(
        //   physics: NeverScrollableScrollPhysics(),
        //   shrinkWrap: true,
        //   scrollDirection: Axis.vertical,
        //   itemCount: _workHistories.length,
        //   itemBuilder: (context, index) => Padding(
        //     padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.circular(10),
        //         boxShadow: [
        //           BoxShadow(
        //             color: Colors.black.withOpacity(0.2),
        //             spreadRadius: 1,
        //             blurRadius: 5,
        //             offset: Offset(2, 3),
        //           ),
        //         ],
        //       ),
        //       child: ChildRelativeExpansionTitle(
        //         workHistory: _workHistories[index],
        //         onEdit: _onEdit,
        //       ),
        //     ),
        //   ),
        // )
        ChildRelativeExpansionTitle(
            workHistory: _workHistories[1], onEdit: _onEdit)
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
  void dispose() {
    _workHistoryUnitController.dispose();
    _workHistoryPositionController.dispose();
    _workHistoryJoinDateController.dispose();
    _workHistoryDismissDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: TextFieldWidget(
        controller: _workHistoryUnitController,
        icon: Icons.groups,
        hintText: "Unit",
        onEdit: false,
        textInputFormatter: FilteringTextInputFormatter.singleLineFormatter,
      ),
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: MyDropdownButton(
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
            )),
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
