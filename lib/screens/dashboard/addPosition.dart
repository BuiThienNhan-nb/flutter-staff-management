import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/position.dart';
import 'package:staff_management/screens/dashboard/textNumField.dart';
import 'package:staff_management/services/positionRepo.dart';
import 'package:staff_management/utils/textField/textField.dart';

class AddPositionScreen extends StatefulWidget {
  const AddPositionScreen({Key? key}) : super(key: key);

  @override
  _AddPositionScreenState createState() => _AddPositionScreenState();
}

class _AddPositionScreenState extends State<AddPositionScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  TextEditingController _2015Controller = TextEditingController(text: "0.0");
  TextEditingController _2016Controller = TextEditingController(text: "0.0");
  TextEditingController _2017Controller = TextEditingController(text: "0.0");
  TextEditingController _2018Controller = TextEditingController(text: "0.0");
  TextEditingController _2019Controller = TextEditingController(text: "0.0");
  TextEditingController _2020Controller = TextEditingController(text: "0.0");
  TextEditingController _2021Controller = TextEditingController(text: "0.0");

  @override
  void initState() {
    _nameController.text = "";
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _2015Controller.dispose();
    _2016Controller.dispose();
    _2017Controller.dispose();
    _2018Controller.dispose();
    _2019Controller.dispose();
    _2020Controller.dispose();
    _2021Controller.dispose();
    super.dispose();
  }

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
            Container(
              alignment: Alignment.center,
              child: Text(
                "Add Position",
                style: GoogleFonts.varelaRound(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Position name",
                  ),
                  SizedBox(height: 5),
                  TextFieldWidget(
                    controller: _nameController,
                    icon: Icons.work_rounded,
                    hintText: "Position Name",
                    onEdit: true,
                    textInputFormatter:
                        FilteringTextInputFormatter.singleLineFormatter,
                    callback: (String _newValue) {},
                  ),
                  SizedBox(height: 20),
                  Text("List allowance Points"),
                  SizedBox(height: 5),
                  TextNumFieldWidget(
                    controller: _2015Controller,
                    hintText: "2015 allowance point",
                    callback: (String _newValue) {},
                  ),
                  TextNumFieldWidget(
                    controller: _2016Controller,
                    hintText: "2016 allowance point",
                    callback: (String _newValue) {},
                  ),
                  TextNumFieldWidget(
                    controller: _2017Controller,
                    hintText: "2017 allowance point",
                    callback: (String _newValue) {},
                  ),
                  TextNumFieldWidget(
                    controller: _2018Controller,
                    hintText: "2018 allowance point",
                    callback: (String _newValue) {},
                  ),
                  TextNumFieldWidget(
                    controller: _2019Controller,
                    hintText: "2019 allowance point",
                    callback: (String _newValue) {},
                  ),
                  TextNumFieldWidget(
                    controller: _2020Controller,
                    hintText: "2020 allowance point",
                    callback: (String _newValue) {},
                  ),
                  TextNumFieldWidget(
                    controller: _2021Controller,
                    hintText: "2021 allowance point",
                    callback: (String _newValue) {},
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () => addPosition()
                        .then((value) => showSnackBar(context, value)),
                    child: Text("Add"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> addPosition() async {
    if (positionController.listPositionName.contains(_nameController.text)) {
      Map<String, num> allowancePoints = {
        "2015": double.parse(_2015Controller.text),
        "2016": double.parse(_2016Controller.text),
        "2017": double.parse(_2017Controller.text),
        "2018": double.parse(_2018Controller.text),
        "2019": double.parse(_2019Controller.text),
        "2020": double.parse(_2020Controller.text),
        "2021": double.parse(_2021Controller.text),
      };
      Position position = Position(
          uid: "uid",
          name: _nameController.text,
          allowancePoints: allowancePoints);
      await PositionRepo().addPosition(position);
      return true;
    } else {
      return false;
    }
  }

  void showSnackBar(BuildContext context, bool flag) {
    if (flag) {
      Get.back();
      final snackBar = SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(
          "Add position successful",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(
          "This position already provided",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
