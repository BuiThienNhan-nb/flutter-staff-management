import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/addition.dart';
import 'package:staff_management/services/additionRepo.dart';
import 'package:staff_management/utils/dropdown/dropdownButton.dart';
import 'package:staff_management/utils/textField/textField.dart';
import 'package:staff_management/utils/textField/textNumField.dart';

class AddNewAddition extends StatefulWidget {
  const AddNewAddition({Key? key}) : super(key: key);

  @override
  _AddNewAdditionState createState() => _AddNewAdditionState();
}

class _AddNewAdditionState extends State<AddNewAddition> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _contentController =
      TextEditingController(text: "");
  final TextEditingController _valueController =
      TextEditingController(text: "500000");
  String _selectedType = "Khen thưởng";

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    controller: _contentController,
                    icon: Icons.card_giftcard_rounded,
                    hintText: "Addition content",
                    onEdit: true,
                    textInputFormatter:
                        FilteringTextInputFormatter.singleLineFormatter,
                    callback: (_newValue) {},
                  ),
                  MyDropdownButton(
                    selectedValue: _selectedType,
                    values: ["Khen thưởng", "Kỷ luật"],
                    icon: Icons.tag_rounded,
                    lable: "Type of addition",
                    callback: (_newValue) => _selectedType = _newValue,
                    size: const Size(200, 70),
                  ),
                  TextNumFieldWidget(
                    controller: _valueController,
                    hintText: "Value of the addition",
                    callback: (_newValue) {},
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () async => await addAddition()
                    .then((value) => showSnackBar(context, value)),
                child: Text("Add addition"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> addAddition() async {
    if (additionController.listAdditionName.contains(_contentController.text) ||
        !_formKey.currentState!.validate()) {
      return false;
    } else {
      Addition addition = Addition(
        uid: "uid",
        content: _contentController.text,
        isReward: _selectedType == "Khen thưởng",
        value: int.parse(_valueController.text) ~/ 1000,
      );
      await AdditionRepo().addAddition(addition);
      await notificationController.createAdditionNotification(addition);
      return true;
    }
  }

  void showSnackBar(BuildContext context, bool flag) {
    if (flag) {
      Get.back();
      final snackBar = SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(
          "Add addition successful",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(
          "Some fields are invalid or This addition already provided",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
