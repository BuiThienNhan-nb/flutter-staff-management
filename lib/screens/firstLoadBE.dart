import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/screens/testBE.dart';

class LoadBE extends StatefulWidget {
  const LoadBE({Key? key}) : super(key: key);

  @override
  _LoadBEState createState() => _LoadBEState();
}

class _LoadBEState extends State<LoadBE> {
  @override
  Widget build(BuildContext context) {
    employeeController.retreiveDetailData();
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Center(
          child: FlatButton(
            onPressed: () {
              Get.to(() => TestBE());
            },
            child: Text('Dzô test BE nè'),
          ),
        ),
      ),
    );
  }
}
