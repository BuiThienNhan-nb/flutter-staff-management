import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staff_management/const_value/value.dart';

class PasswordFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String currentPassword;

  const PasswordFieldWidget({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.currentPassword,
  }) : super(key: key);

  @override
  _PasswordFieldWidgetState createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool isHidden = true;

  void togglePasswordVisibity() => setState(() => isHidden = !isHidden);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConsInsurancetValue.TextFormFieldContainerHieght,
      child: TextFormField(
        style: TextStyle(fontSize: ConsInsurancetValue.AuthFontSize),
        controller: widget.controller,
        obscureText: isHidden,
        decoration: InputDecoration(
            hintText: widget.hintText,
            // border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            prefixIcon: Icon(
              Icons.vpn_key_rounded,
              size: ConsInsurancetValue.AuthFontSize * 1.5,
            ),
            suffixIcon: IconButton(
              icon: isHidden
                  ? Icon(Icons.visibility_off)
                  : Icon(Icons.visibility),
              onPressed: togglePasswordVisibity,
            )),
        keyboardType: TextInputType.visiblePassword,
        autofillHints: [AutofillHints.password],
        onEditingComplete: () => TextInput.finishAutofillContext(),
        validator: (input) {
          if (input == null || input.isEmpty)
            return '${widget.hintText} is required';
          if (input.length < 6)
            return '${widget.hintText} has to be at least 6 characters';
          if (widget.currentPassword.trim() != '' &&
              input.trim() != widget.currentPassword.trim()) {
            return 'Retype password is not equal to current type password';
          }
        },
        enableSuggestions: false,
        autocorrect: false,
      ),
    );
  }
}
