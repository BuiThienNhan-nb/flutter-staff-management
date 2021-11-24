import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_management/controllers/addtitionController.dart';
import 'package:staff_management/controllers/employeeController.dart';
import 'package:staff_management/controllers/positionController.dart';
import 'package:staff_management/controllers/quotaController.dart';
import 'package:staff_management/controllers/salaryRecordController.dart';
import 'package:staff_management/controllers/unitController.dart';
import 'package:staff_management/screens/intro/loadingScreen.dart';
import 'package:staff_management/screens/login/loginScreen.dart';
import 'package:staff_management/screens/mainContainer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(PositionController());
    Get.put(EmployeeController());
    Get.put(SalaryRecordController());
    Get.put(UnitController());
    Get.put(QuotaController());
    Get.put(AdditionController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: "/loadingScreen",
          page: () => LoadingScreen(),
        ),
        GetPage(
          name: "/loginScreen",
          page: () => LoginScreen(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 350),
        ),
        GetPage(
          name: "/mainContainer",
          page: () => MainContainer(),
          transition: Transition.rightToLeft,
          transitionDuration: Duration(milliseconds: 350),
        ),
      ],
      initialRoute: "/loadingScreen",
    );
  }
}
