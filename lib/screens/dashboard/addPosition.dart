import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_management/utils/textField/textField.dart';

class AddPositionScreen extends StatefulWidget {
  const AddPositionScreen({Key? key}) : super(key: key);

  @override
  _AddPositionScreenState createState() => _AddPositionScreenState();
}

class _AddPositionScreenState extends State<AddPositionScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController(text: "");
  TextEditingController _2015Controller = TextEditingController(text: "0.0");
  TextEditingController _2016Controller = TextEditingController(text: "0.0");
  TextEditingController _2017Controller = TextEditingController(text: "0.0");
  TextEditingController _2018Controller = TextEditingController(text: "0.0");
  TextEditingController _2019Controller = TextEditingController(text: "0.0");
  TextEditingController _2020Controller = TextEditingController(text: "0.0");
  TextEditingController _2021Controller = TextEditingController(text: "0.0");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Add Position",
            style: GoogleFonts.varelaRound(
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Position name"),
                SizedBox(height: 5),
                TextFieldWidget(
                    controller: _nameController,
                    icon: null,
                    hintText: "Position Name",
                    onEdit: true,
                    textInputFormatter:
                        FilteringTextInputFormatter.singleLineFormatter,
                    callback: (String _newValue) =>
                        _nameController.text = _newValue),
                SizedBox(height: 5),
                Text("List allowance Points"),
                SizedBox(height: 5),
                TextFormField(),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Add"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     centerTitle: true,
    //     title: Text("Add Position"),
    //   ),
    //   body: Container(color: Colors.white),
    // );
  }
}
