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
import 'package:get/get.dart';

class QuotaHistoriesExpansionTitle extends StatefulWidget {
  final List<QuotaHistory> _quotaHistories;
  final bool _onEdit;
  final bool _onAdd;
  const QuotaHistoriesExpansionTitle({
    Key? key,
    required List<QuotaHistory> quotaHistories,
    required bool onEdit,
    required bool onAdd,
  })  : _quotaHistories = quotaHistories,
        _onEdit = onEdit,
        _onAdd = onAdd,
        super(key: key);
  @override
  State<QuotaHistoriesExpansionTitle> createState() =>
      _QuotaHistoriesExpansionTitleState();
}

class _QuotaHistoriesExpansionTitleState
    extends State<QuotaHistoriesExpansionTitle> {
  var dmyNow =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
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
          itemCount: widget._quotaHistories.length,
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
              child: ChildQuotaHistoryExpansionTitle(
                quotaHistory: widget._quotaHistories[index],
                onEdit: index == 0 ? widget._onEdit : false,
                callback: (_newDateString) {
                  if (widget._quotaHistories.length > 1) {
                    if (widget._quotaHistories[index].joinDate
                            .toDate()
                            .compareTo(widget
                                ._quotaHistories[index + 1].joinDate
                                .toDate()) >
                        0) {
                      widget._quotaHistories[index].dismissDate =
                          Timestamp.fromDate(widget
                              ._quotaHistories[index].joinDate
                              .toDate()
                              .add(const Duration(days: -1)));
                      widget._quotaHistories[index + 1].dismissDate =
                          Timestamp.fromDate(widget
                              ._quotaHistories[index].joinDate
                              .toDate()
                              .add(const Duration(days: -1)));
                    } else {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text(
                                      'Join day of the new object you just added is later than the join day of the old object'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Approve'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    widget._quotaHistories[index].dismissDate =
                        Timestamp.fromDate(widget
                            ._quotaHistories[index].joinDate
                            .toDate()
                            .add(const Duration(days: -1)));
                  }
                },
              ),
            ),
          ),
        ),
        widget._onAdd
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget._quotaHistories[0].joinDate
                              .toDate()
                              .compareTo(dmyNow) >=
                          0
                      ? Container()
                      : IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            QuotaHistory _quotaHistory = new QuotaHistory(
                                uid: 'uid',
                                quotaId: 'gBOJPN189hQA3uglbvwc',
                                joinDate: Timestamp.fromDate(DateTime.now()),
                                dismissDate: Timestamp.fromDate(DateTime.now()),
                                quota: new Quota(
                                    uid: 'gBOJPN189hQA3uglbvwc',
                                    duration: 2,
                                    name: 'Cán sự',
                                    ranks: [0]).obs);
                            if (widget._quotaHistories[0].joinDate
                                    .toDate()
                                    .compareTo(
                                        _quotaHistory.joinDate.toDate()) <
                                1) {
                              widget._quotaHistories.insert(0, _quotaHistory);
                              widget._quotaHistories[1].dismissDate =
                                  Timestamp.fromDate(widget
                                      ._quotaHistories[0].joinDate
                                      .toDate()
                                      .add(const Duration(days: -1)));
                            }
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
class ChildQuotaHistoryExpansionTitle extends StatefulWidget {
  QuotaHistory _quotaHistory;
  final bool _onEdit;
  final Callback _callback;
  ChildQuotaHistoryExpansionTitle(
      {Key? key,
      required QuotaHistory quotaHistory,
      required bool onEdit,
      required Callback callback})
      : _quotaHistory = quotaHistory,
        _onEdit = onEdit,
        _callback = callback,
        super(key: key);

  @override
  State<ChildQuotaHistoryExpansionTitle> createState() =>
      _ChildQuotaHistoryExpansionTitleState();
}

class _ChildQuotaHistoryExpansionTitleState
    extends State<ChildQuotaHistoryExpansionTitle> {
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
  }

  void updateQuota(String _selectedQuotaName) {
    Quota _quota = quotaController.listQuotas
        .where((element) => element.name == _selectedQuotaName)
        .first;
    widget._quotaHistory.quotaId = _quota.uid;
    widget._quotaHistory.quota.value = _quota;
    quotaController.onInit();
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
    // updateVariables();
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
              icon: Icons.hail,
              lable: "Quota",
              callback: (String _newValue) {
                setState(() {
                  _quotaHistoryNameController.text = _newValue;
                  updateQuota(_newValue);
                });
              },
              size: Size(500, 70),
            )
          : TextFieldWidget(
              controller: _quotaHistoryNameController,
              icon: Icons.hail,
              hintText: "Quota",
              onEdit: widget._onEdit,
              textInputFormatter:
                  FilteringTextInputFormatter.singleLineFormatter,
              callback: (String _submittedValue) {},
            ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: DatePickerTextField(
              labelText: "Join Date",
              placeholder: "Sep 12, 1998",
              textEditingController: _quotaHistoryJoinDateController,
              editable: widget._onEdit,
              icon: Icons.date_range,
              callback: (String _newDateString) {
                widget._quotaHistory.joinDate = Timestamp.fromDate(
                    DateFormat('dd/MM/yyyy').parse(_newDateString));
                widget._callback(_newDateString);
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: DatePickerTextField(
            labelText: "Dismiss Date",
            placeholder: "Sep 12, 1998",
            textEditingController: _quotaHistoryDismissDateController,
            editable: widget._onEdit,
            icon: Icons.date_range,
            callback: (String _newDateString) => Timestamp.fromDate(
                DateFormat('dd/MM/yyyy')
                    .parse(_quotaHistoryJoinDateController.text)),
          ),
        ),
      ],
    );
  }
}

typedef Callback = Function(String _newDateString);
