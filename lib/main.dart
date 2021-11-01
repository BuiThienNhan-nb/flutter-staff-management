import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/controllers/employeeController.dart';
import 'package:staff_management/controllers/positionController.dart';
import 'package:staff_management/screens/firstLoadBE.dart';
import 'package:staff_management/screens/testBE.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(PositionController());
    Get.put(EmployeeController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(
        child: Container(
          color: Colors.white,
          child: Center(
            child: FlatButton(
              onPressed: () {
                Get.to(() => LoadBE());
              },
              child: Text('Click to Test BE'),
            ),
          ),
        ),
      ),
    );
  }
}
