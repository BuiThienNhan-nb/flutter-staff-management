import 'package:flutter/material.dart';
import 'package:staff_management/const_value/value.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          // primary: Palette.myColor,
          shadowColor: Colors.grey,
          minimumSize: Size(150, 60),
          shape: StadiumBorder(),
          primary: color,
        ),
        child: FittedBox(
          child: Text(
            text,
            style: TextStyle(
              fontSize: ConsInsurancetValue.AuthFontSize,
              color: Colors.white,
            ),
          ),
        ),
        onPressed: onClicked,
      );
}
