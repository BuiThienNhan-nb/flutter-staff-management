import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staff_management/screens/dashboard/addAddition.dart';
import 'package:staff_management/screens/dashboard/addPosition.dart';
import 'package:staff_management/screens/dashboard/addUnit.dart';
import 'package:staff_management/screens/dashboard/homeItem.dart';
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
    UpdateSalaryScreen(),
  ];
  List<HomeItemModel> _listHomeItem = [];
  int _selectedIndex = -1;

  @override
  void initState() {
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
        title: "Update Salary",
        icon: Icons.money_rounded,
      ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size _deviceSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 50),
        Container(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          // height: _deviceSize.height * 0.05,
          child: Text(
            "Update University database",
            style: GoogleFonts.varelaRound(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          // padding: EdgeInsets.only(top: _deviceSize.height * 0.13),
          height: _deviceSize.height * 0.6,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.0,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemCount: _listHomeItem.length,
            itemBuilder: (BuildContext context, int index) => GestureDetector(
              onTap: () => setState(() {
                _selectedIndex = index;
              }),
              onDoubleTap: () => Get.to(() => _list[index]),
              child: HomeItem(
                  title: _listHomeItem[index].title,
                  icon: _listHomeItem[index].icon,
                  isSelected: _selectedIndex == index),
            ),
          ),
        ),
      ],
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
