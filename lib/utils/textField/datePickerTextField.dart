import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerTextField extends StatelessWidget {
  DatePickerTextField({
    required this.labelText,
    required this.placeholder,
    required this.textEditingController,
    required this.editable,
    required this.icon,
    required this.callback,
  });
  final String labelText;
  final String placeholder;
  final bool editable;
  final TextEditingController textEditingController;
  final IconData icon;
  final Callback callback;

  @override
  Widget build(BuildContext context) {
    DateTime _selectedDate = (textEditingController.text == "Current" ||
            textEditingController.text == "")
        ? DateTime.now().add(const Duration(days: 1))
        : DateFormat('dd/MM/yyyy').parse(textEditingController.text);

    _selectDate(BuildContext context) async {
      DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2040),
      );

      if (newSelectedDate != null) {
        _selectedDate = newSelectedDate;
        textEditingController
          ..text = DateFormat('dd/MM/yyyy').format(_selectedDate)
          ..selection = TextSelection.fromPosition(TextPosition(
              offset: textEditingController.text.length,
              affinity: TextAffinity.upstream));
        callback(textEditingController.text);
      }
    }

    return Container(
      height: 70,
      child: TextFormField(
        focusNode: AlwaysDisabledFocusNode(),
        controller: textEditingController,
        style: TextStyle(fontSize: 16),
        onTap: textEditingController.text == "Current"
            ? () {}
            : () => _selectDate(context),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          prefixIcon: Icon(icon),
          // border: InputBorder.none,
        ),
        enabled: editable,
      ),
    );
  }
}

typedef Callback = Function(String _newDateString);

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
