import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_management/const_value/controller.dart';
import 'package:staff_management/screens/dashboard/addAddition/addAddition.dart';
import 'package:staff_management/screens/dashboard/addPosition/addPosition.dart';
import 'package:staff_management/screens/dashboard/addQuota/addQuota.dart';
import 'package:staff_management/screens/dashboard/addUnit/addUnit.dart';
import 'package:staff_management/screens/dashboard/homeItem.dart';
import 'package:staff_management/screens/dashboard/relativeScreen/relative.dart';
import 'package:staff_management/screens/dashboard/retirementScreen/retirementEmployee.dart';
import 'package:staff_management/screens/dashboard/updateSalary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> _list = [
    AddPositionScreen(),
    AddUnitScreen(),
    AddAdditionScreen(),
    AddQuotaScreen(),
    RetirementEmployee(),
    RelativeScreen(),
  ];
  List<HomeItemModel> _listHomeItem = [];
  int _selectedIndex = -1;

  void initListName() {
    additionController.initListAdditionName();
    quotaController.initListQuoataName();
    positionController.initListPositionName();
    unitController.initListUnitName();
  }

  @override
  void initState() {
    initListName();
    _listHomeItem
      ..add(HomeItemModel(
        title: "Add Position",
        icon: Icons.work_rounded,
      ))
      ..add(HomeItemModel(
        title: "Add Unit",
        icon: Icons.home_work_sharp,
      ))
      ..add(HomeItemModel(
        title: "Add Addition",
        icon: Icons.card_giftcard_rounded,
      ))
      ..add(HomeItemModel(
        title: "Add Quota",
        icon: Icons.assignment_ind_rounded,
      ))
      ..add(HomeItemModel(
        title: 'Retirement Employee',
        icon: Icons.person,
      ))
      ..add(HomeItemModel(
        title: 'Relative',
        icon: Icons.family_restroom,
      ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _deviceSize = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: AlwaysScrollableScrollPhysics(),
      child: Container(
        // height: _deviceSize.height,
        padding: const EdgeInsets.only(bottom: 55),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.only(left: 20, bottom: 20),
              // height: _deviceSize.height * 0.05,
              child: Text(
                "Dashboard",
                style: GoogleFonts.varelaRound(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              // padding: EdgeInsets.only(top: _deviceSize.height * 0.13),
              height: _deviceSize.height * 0.8,
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: _listHomeItem.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () => setState(() {
                    _selectedIndex = index;
                  }),
                  onDoubleTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                    if (_selectedIndex == 4) {
                      Get.to(_list[_selectedIndex]);
                    } else if (_selectedIndex == 5) {
                      Get.to(() => _list[_selectedIndex]);
                    } else {
                      Get.bottomSheet(_list[_selectedIndex]);
                    }
                    Get.to(() => _list[_selectedIndex]);
                  },
                  child: HomeItem(
                      title: _listHomeItem[index].title,
                      icon: _listHomeItem[index].icon,
                      isSelected: _selectedIndex == index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeItemModel {
  final String title;
  final IconData icon;
  const HomeItemModel({
    required this.title,
    required this.icon,
  });
}
