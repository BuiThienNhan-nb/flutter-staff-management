import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDropdownButton extends StatelessWidget {
  const MyDropdownButton({
    Key? key,
    required String selectedValue,
    required List<String> values,
    required IconData icon,
    required String lable,
    required Callback callback,
    required Size size,
  })  : _selectedValue = selectedValue,
        _values = values,
        _icon = icon,
        _lable = lable,
        _callback = callback,
        _size = size,
        super(key: key);
  final String _selectedValue;
  final List<String> _values;
  final IconData _icon;
  final String _lable;
  final Callback _callback;
  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _size.height,
      width: _size.width,
      child: IgnorePointer(
        ignoring: false,
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            prefixIcon: _icon.codePoint == 0 ? null : Icon(_icon),
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
