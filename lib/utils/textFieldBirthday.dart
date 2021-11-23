import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextFieldBirthday extends StatelessWidget {
  TextFieldBirthday({
    required this.labelText,
    required this.placeholder,
    required this.textEditingController,
    required this.editable,
  });
  final String labelText;
  final String placeholder;
  final bool editable;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    DateTime _selectedDate =
        new DateFormat.yMMMd().parse(textEditingController.text);

    _selectDate(BuildContext context) async {
      DateTime? newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
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

    return Container(
      height: 60,
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
          prefixIcon: Icon(Icons.cake),
          suffixIcon: (textEditingController.text.isEmpty || editable == false)
              ? Container(
                  width: 0,
                )
              : IconButton(
                  onPressed: () => textEditingController.clear(),
                  icon: Icon(Icons.close),
                ),
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
