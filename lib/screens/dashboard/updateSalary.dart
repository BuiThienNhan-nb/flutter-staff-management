import 'package:flutter/material.dart';

class UpdateSalaryScreen extends StatefulWidget {
  const UpdateSalaryScreen({Key? key}) : super(key: key);

  @override
  _UpdateSalaryScreenState createState() => _UpdateSalaryScreenState();
}

class _UpdateSalaryScreenState extends State<UpdateSalaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Update Salary"),
      ),
      body: Container(color: Colors.white),
    );
  }
}
