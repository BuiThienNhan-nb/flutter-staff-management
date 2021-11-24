import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerTextField extends StatelessWidget {
  DatePickerTextField({
    required this.labelText,
    required this.placeholder,
    required this.textEditingController,
    required this.editable,
    required this.icon,
  });
  final String labelText;
  final String placeholder;
  final bool editable;
  final TextEditingController textEditingController;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    DateTime _selectedDate = (textEditingController.text == "Current")
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
      }
    }

    return Container(
      height: 70,
      child: TextFormField(
        focusNode: AlwaysDisabledFocusNode(),
        controller: textEditingController,
        style: TextStyle(fontSize: 16),
        onTap: () {
          _selectDate(context);
        },
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
