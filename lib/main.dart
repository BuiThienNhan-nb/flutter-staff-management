import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staff_management/controllers/employeeController.dart';
import 'package:staff_management/controllers/positionController.dart';
import 'package:staff_management/controllers/salaryRecordController.dart';
import 'package:staff_management/screens/intro/loadingScreen.dart';
import 'package:staff_management/screens/login/loginScreen.dart';
import 'package:staff_management/screens/mainContainer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(PositionController());
    Get.put(EmployeeController());
    Get.put(SalaryRecordController());
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Flutter Demo',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      // home: SafeArea(
      //   child: Container(
      //     color: Colors.white,
      //     child: Center(
      //       child: FlatButton(
      //         onPressed: () {
      //           Get.to(() => LoadBE());
      //         },
      //         child: Text('Click to Test BE'),
      //       ),
      //     ),
      //   ),
      // ),

      getPages: [
        GetPage(
          name: "/loadingScreen",
          page: () => LoadingScreen(),
          // transition: Transition.rightToLeft,
          // transitionDuration: Duration(milliseconds: 350),
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
