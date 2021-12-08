import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/models/quota.dart';
import 'package:staff_management/services/quotaRepo.dart';
import 'package:staff_management/utils/textField/textField.dart';
import 'package:staff_management/utils/textField/textNumField.dart';

class AddQuotaScreen extends StatefulWidget {
  const AddQuotaScreen({Key? key}) : super(key: key);

  @override
  _AddQuotaScreenState createState() => _AddQuotaScreenState();
}

class _AddQuotaScreenState extends State<AddQuotaScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(text: "");
  final TextEditingController _durationController =
      TextEditingController(text: "1");
  final List<TextEditingController> _ranksController = [];

  @override
  void initState() {
    for (int i = 0; i < 7; i++) {
      _ranksController.add(TextEditingController(text: "0.0"));
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    _ranksController.forEach((element) => element.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Quota",
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
                      hintText: "Quota name",
                      onEdit: true,
                      textInputFormatter:
                          FilteringTextInputFormatter.singleLineFormatter,
                      callback: (String _newValue) {},
                    ),
                    SizedBox(height: 10),
                    TextNumFieldWidget(
                      controller: _durationController,
                      hintText: "Durations",
                      callback: (String _newValue) {},
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        "List rank point of the quota:",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      height: 500,
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _ranksController.length,
                        itemBuilder: (context, index) => TextNumFieldWidget(
                            controller: _ranksController[index],
                            hintText: "Rank ${index + 1}",
                            callback: (String _newValue) {}),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () async => addQuota().then(
                    (value) => showSnackBar(context, value),
                  ),
                  child: Text("Add Quota"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> addQuota() async {
    if (quotaController.listQuotaName.contains(_nameController.text) ||
        !_formKey.currentState!.validate()) {
      return false;
    } else {
      List<double> ranks = [];
      _ranksController
          .forEach((element) => ranks.add(double.parse(element.text)));
      Quota quota = Quota(
          uid: "uid",
          duration: int.parse(_durationController.text),
          name: _nameController.text,
          ranks: ranks);
      await QuotaRepo().addQuota(quota);
      return true;
    }
  }

  void showSnackBar(BuildContext context, bool flag) {
    if (flag) {
      Get.back();
      final snackBar = SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(
          "Add quota successful",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(
          "Some fields are invalid or This quota already provided",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
