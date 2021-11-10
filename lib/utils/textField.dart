import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final Icon icon;
  final String hintText;
  final bool editable;
  final TextInputFormatter textInputFormatter;

  const TextFieldWidget({
    Key? key,
    required this.controller,
    required this.icon,
    required this.hintText,
    required this.editable,
    required this.textInputFormatter,
  }) : super(key: key);

  @override
  _EmailFieldWidgetState createState() => _EmailFieldWidgetState();
}

class _EmailFieldWidgetState extends State<TextFieldWidget> {
  @override
  void initState() {
    widget.controller.addListener(onListen);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(onListen);
    super.dispose();
  }

  void onListen() => setState(() {});

  @override
  Widget build(BuildContext context) {
    final textFielHiegh = 60.0;
    final textFieldFontSize = 16.0;

    return Container(
      height: textFielHiegh,
      child: TextFormField(
        style: TextStyle(fontSize: textFieldFontSize),
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: "${widget.hintText}",
          labelText: "${widget.hintText}",
          prefixIcon: widget.icon,
          suffixIcon:
              (widget.controller.text.isEmpty || widget.editable == false)
                  ? Container(
                      width: 0,
                    )
                  : IconButton(
                      onPressed: () => widget.controller.clear(),
                      icon: Icon(Icons.close),
                    ),
        ),
        enabled: widget.editable,
        inputFormatters: [widget.textInputFormatter],
        keyboardType: TextInputType.emailAddress,
        // autofillHints: [AutofillHints.email],
        validator: (input) {
          if (input == null || input.isEmpty) return 'This field is required';
        },
      ),
    );
  }
}
