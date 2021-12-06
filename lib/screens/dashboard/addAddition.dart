import 'package:flutter/material.dart';

class AddAdditionScreen extends StatefulWidget {
  const AddAdditionScreen({Key? key}) : super(key: key);

  @override
  _AddAdditionScreenState createState() => _AddAdditionScreenState();
}

class _AddAdditionScreenState extends State<AddAdditionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Addition"),
      ),
      body: Container(color: Colors.white),
    );
  }
}
