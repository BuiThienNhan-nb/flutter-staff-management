import 'package:flutter/material.dart';

class AddUnitScreen extends StatefulWidget {
  const AddUnitScreen({Key? key}) : super(key: key);

  @override
  _AddUnitScreenState createState() => _AddUnitScreenState();
}

class _AddUnitScreenState extends State<AddUnitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Unit"),
      ),
      body: Container(color: Colors.white),
    );
  }
}
