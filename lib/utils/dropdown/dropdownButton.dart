import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDropdownButton extends StatelessWidget {
  const MyDropdownButton({
    Key? key,
    required String selectedValue,
    required List<String> values,
    required Icon icon,
    required String lable,
    required Callback callback,
  })  : _selectedValue = selectedValue,
        _values = values,
        _icon = icon,
        _lable = lable,
        _callback = callback,
        super(key: key);
  final String _selectedValue;
  final List<String> _values;
  final Icon _icon;
  final String _lable;
  final Callback _callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: IgnorePointer(
        ignoring: false,
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            prefixIcon: _icon,
            labelText: _lable,
            border: InputBorder.none,
          ),
          isExpanded: true,
          value: _selectedValue,
          items: _values.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          hint: Text("$_lable"),
          onChanged: (String? newValue) {
            _callback(newValue!);
          },
        ),
      ),
    );
  }
}

typedef Callback = void Function(String _newValue);
