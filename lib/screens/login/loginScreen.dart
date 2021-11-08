import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/screens/mainContainer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoadBEState createState() => _LoadBEState();
}

class _LoadBEState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    employeeController.retreiveDetailData();
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Center(
          child: FlatButton(
            onPressed: () {
              Get.to(() => MainContainer());
            },
            child: Text('Dzô test BE nè'),
          ),
        ),
      ),
    );
  }
}
