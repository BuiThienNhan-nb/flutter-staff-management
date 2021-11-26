import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextFieldBirthday extends StatelessWidget {
  TextFieldBirthday(
      {required this.labelText,
      required this.placeholder,
      required this.textEditingController,
      required this.icon});
  final String labelText;
  final String placeholder;
  final IconData icon;
  DateTime _selectedDate = DateTime(2020);
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        focusNode: AlwaysDisabledFocusNode(),
        controller: textEditingController,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        onTap: () {
          _selectDate(context);
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 5),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          prefixIcon: Icon(icon),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime? newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime(2020),
      firstDate: DateTime(1900),
      lastDate: DateTime(2021),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      textEditingController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
