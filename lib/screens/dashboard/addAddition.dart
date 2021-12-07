import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';

class AddAdditionScreen extends StatefulWidget {
  const AddAdditionScreen({Key? key}) : super(key: key);

  @override
  _AddAdditionScreenState createState() => _AddAdditionScreenState();
}

class _AddAdditionScreenState extends State<AddAdditionScreen> {
  String _selectedAddition = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Addition",
          style: GoogleFonts.varelaRound(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyDropdownButton(
                selectedValue: _selectedAddition,
                values: additionController.listAdditionName,
                icon: Icons.image_aspect_ratio_rounded,
                lable: "Unit",
                callback: (String _newValue) {
                  setState(() {
                    _selectedAddition = _newValue;
                  });
                },
                size: Size(200, 60)),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
