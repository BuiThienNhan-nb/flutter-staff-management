import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/unit.dart';
import 'package:staff_management/services/unitRepo.dart';
import 'package:staff_management/utils/textField/datePickerTextField.dart';
import 'package:staff_management/utils/textField/textField.dart';

class AddUnitScreen extends StatefulWidget {
  const AddUnitScreen({Key? key}) : super(key: key);

  @override
  _AddUnitScreenState createState() => _AddUnitScreenState();
}

class _AddUnitScreenState extends State<AddUnitScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(text: "");
  final TextEditingController _addressController =
      TextEditingController(text: "");
  final TextEditingController _phoneController =
      TextEditingController(text: "057");
  final TextEditingController _foundedDateController = TextEditingController(
      text: "${DateFormat('dd/MM/yyyy').format(DateTime.now())}");

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _foundedDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Unit",
          style: GoogleFonts.varelaRound(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFieldWidget(
                      controller: _nameController,
                      icon: Icons.tag_rounded,
                      hintText: "Unit name",
                      onEdit: true,
                      textInputFormatter:
                          FilteringTextInputFormatter.singleLineFormatter,
                      callback: (String _newValue) {},
                    ),
                    TextFieldWidget(
                      controller: _addressController,
                      icon: Icons.home_rounded,
                      hintText: "Unit address",
                      onEdit: true,
                      textInputFormatter:
                          FilteringTextInputFormatter.singleLineFormatter,
                      callback: (String _newValue) {},
                    ),
                    TextFieldWidget(
                      controller: _phoneController,
                      icon: Icons.phone,
                      hintText: "Unit phone",
                      onEdit: true,
                      textInputFormatter:
                          FilteringTextInputFormatter.digitsOnly,
                      callback: (String _newValue) {},
                    ),
                    DatePickerTextField(
                      labelText: "Founded date",
                      placeholder: "Founded date",
                      textEditingController: _foundedDateController,
                      editable: true,
                      icon: Icons.calendar_today_rounded,
                      callback: (String _newValue) {},
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async => await addUnit()
                    .then((value) => showSnackBar(context, value)),
                child: Text("Add unit"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> addUnit() async {
    if (unitController.listUnitName.contains(_nameController.text) ||
        !_formKey.currentState!.validate()) {
      return false;
    } else {
      Unit unit = Unit(
        uid: "uid",
        address: _addressController.text,
        foundedDate: Timestamp.fromDate(
            DateFormat('dd/MM/yyyy').parse(_foundedDateController.text)),
        hotline: _phoneController.text,
        name: _nameController.text,
      );
      await UnitRepo().addUnit(unit);
      return true;
    }
  }

  void showSnackBar(BuildContext context, bool flag) {
    if (flag) {
      Get.back();
      final snackBar = SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(
          "Add unit successful",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(
          "Some fields are invalid or This unit already provided",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
