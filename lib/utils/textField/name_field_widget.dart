import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:staff_management/const_value/value.dart';

class NameFieldWidget extends StatefulWidget {
  final TextEditingController controller;

  const NameFieldWidget({Key? key, required this.controller}) : super(key: key);

  @override
  _EmailFieldWidgetState createState() => _EmailFieldWidgetState();
}

class _EmailFieldWidgetState extends State<NameFieldWidget> {
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
    return Container(
      height: ConsInsurancetValue.TextFormFieldContainerHieght,
      child: TextFormField(
        style: TextStyle(fontSize: ConsInsurancetValue.AuthFontSize),
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'Name',
          prefixIcon: Icon(
            Icons.person,
            size: ConsInsurancetValue.AuthFontSize * 1.3,
          ),
          suffixIcon: widget.controller.text.isEmpty
              ? Container(
                  width: 0,
                )
              : IconButton(
                  onPressed: () => widget.controller.clear(),
                  icon: Icon(Icons.close),
                ),
        ),
        keyboardType: TextInputType.emailAddress,
        autofillHints: [AutofillHints.email],
      ),
    );
  }
}
