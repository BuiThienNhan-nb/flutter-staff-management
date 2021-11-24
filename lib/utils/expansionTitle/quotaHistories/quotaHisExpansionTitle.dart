import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/quota.dart';
import 'package:staff_management/models/quotaHistories.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:staff_management/utils/textField/textField.dart';
import 'package:intl/intl.dart';
import 'package:staff_management/utils/textField/datePickerTextField.dart';

class QuotaHistoriesExpansionTitle extends StatelessWidget {
  final List<QuotaHistory> _quotaHistories;
  final bool _onEdit;
  const QuotaHistoriesExpansionTitle(
      {Key? key,
      required List<QuotaHistory> quotaHistories,
      required bool onEdit})
      : _quotaHistories = quotaHistories,
        _onEdit = onEdit,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: EdgeInsets.only(left: 12),
      title: Row(
        children: [
          Icon(
            Icons.group_work,
            color: Colors.grey,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "Quota Histories",
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
          itemCount: _quotaHistories.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(12),
            child: ChildRelativeExpansionTitle(
              quotaHistory: _quotaHistories[index],
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
  QuotaHistory _quotaHistory;
  final bool _onEdit;
  ChildRelativeExpansionTitle(
      {Key? key, required QuotaHistory quotaHistory, required bool onEdit})
      : _quotaHistory = quotaHistory,
        _onEdit = onEdit,
        super(key: key);

  @override
  State<ChildRelativeExpansionTitle> createState() =>
      _ChildRelativeExpansionTitleState();
}

class _ChildRelativeExpansionTitleState
    extends State<ChildRelativeExpansionTitle> {
  final TextEditingController _quotaHistoryNameController =
      TextEditingController();
  final TextEditingController _quotaHistoryJoinDateController =
      TextEditingController();
  final TextEditingController _quotaHistoryDismissDateController =
      TextEditingController();

  @override
  void initState() {
    _quotaHistoryNameController.text = widget._quotaHistory.quota.value.name;
    _quotaHistoryJoinDateController.text =
        "${DateFormat('dd/MM/yyyy').format(widget._quotaHistory.joinDate.toDate())}";
    _quotaHistoryDismissDateController.text = widget._quotaHistory.dismissDate
            .toDate()
            .isBefore(widget._quotaHistory.joinDate.toDate())
        ? "Current"
        : "${DateFormat('dd/MM/yyyy').format(widget._quotaHistory.dismissDate.toDate())}";
    super.initState();
    quotaController.initListPositionName();
  }

  void updateVariables() {
    // update quota
    Quota _quota = quotaController.listQuotas
        .where((element) => element.name == _quotaHistoryNameController.text)
        .first;
    widget._quotaHistory.quotaId = _quota.uid;
    widget._quotaHistory.quota.value = _quota;
    quotaController.onInit();

    // update join date
    widget._quotaHistory.joinDate = Timestamp.fromDate(
        DateFormat('dd/MM/yyyy').parse(_quotaHistoryJoinDateController.text));

    // update dismiss date
    widget._quotaHistory.dismissDate =
        _quotaHistoryDismissDateController.text == "Current"
            ? widget._quotaHistory.dismissDate
            : Timestamp.fromDate(DateFormat('dd/MM/yyyy')
                .parse(_quotaHistoryDismissDateController.text));
  }

  @override
  void dispose() {
    updateVariables();
    _quotaHistoryNameController.dispose();
    _quotaHistoryJoinDateController.dispose();
    _quotaHistoryDismissDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: widget._onEdit
          ? MyDropdownButton(
              selectedValue: widget._quotaHistory.quota.value.name,
              values: quotaController.listQuotaName,
              icon: Icon(Icons.hail),
              lable: "Quota",
              callback: (String _newValue) {
                widget._quotaHistory.quota.value.name = _newValue;
                _quotaHistoryNameController.text = _newValue;
              },
            )
          : TextFieldWidget(
              controller: _quotaHistoryNameController,
              icon: Icon(Icons.hail),
              hintText: "Quota",
              onEdit: widget._onEdit,
              textInputFormatter:
                  FilteringTextInputFormatter.singleLineFormatter,
            ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: DatePickerTextField(
            labelText: "Join Date",
            placeholder: "Sep 12, 1998",
            textEditingController: _quotaHistoryJoinDateController,
            editable: widget._onEdit,
            icon: Icon(Icons.date_range),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: DatePickerTextField(
            labelText: "Dismiss Date",
            placeholder: "Sep 12, 1998",
            textEditingController: _quotaHistoryDismissDateController,
            editable: widget._onEdit,
            icon: Icon(Icons.date_range),
          ),
        ),
      ],
    );
  }
}
