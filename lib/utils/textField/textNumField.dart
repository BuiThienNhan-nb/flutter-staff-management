import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextNumFieldWidget extends StatefulWidget {
  final TextEditingController _controller;
  final String _hintText;
  final Callback _callback;

  const TextNumFieldWidget({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    required Callback callback,
  })  : _controller = controller,
        _hintText = hintText,
        _callback = callback,
        super(key: key);

  @override
  _TextNumFieldWidgetState createState() => _TextNumFieldWidgetState();
}

class _TextNumFieldWidgetState extends State<TextNumFieldWidget> {
  @override
  void initState() {
    widget._controller.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    widget._controller.removeListener(onListen);
    super.dispose();
  }

  void onListen() => setState(() {});

  bool validate(String _str) {
    for (int i = 0; i < _str.length; i++) {
      if (_str[i] == ",") return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final textFielHiegh = 70.0;
    final textFieldFontSize = 16.0;
    return Container(
      padding: const EdgeInsets.only(left: 10),
      height: textFielHiegh,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(fontSize: textFieldFontSize),
        controller: widget._controller,
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: textFieldFontSize - 5),
          hintText: "${widget._hintText}",
          labelText: "${widget._hintText}",
        ),
        // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        enabled: true,
        keyboardType:
            TextInputType.numberWithOptions(decimal: true, signed: true),
        validator: (input) {
          if (input == null || input.isEmpty) return 'This field is required';
          if (!validate(input))
            return 'Point mustnot contains "," use "." instead';
        },
        onFieldSubmitted: (String submittedValue) {
          widget._callback(submittedValue);
        },
        onChanged: (String submittedValue) {
          widget._callback(submittedValue);
        },
      ),
    );
  }
}

typedef Callback = Function(String _submittedValue);
