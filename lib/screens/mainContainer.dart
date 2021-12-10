import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:staff_management/screens/dashboard/home.dart';
import 'package:staff_management/screens/employee/employeeDGV.dart';
import 'package:staff_management/screens/employee/searchScreen/searchEmployee.dart';
import 'package:staff_management/screens/notification/notifcationScreen.dart';
import 'package:staff_management/screens/revenue/revenueScreen.dart';

class MainContainer extends StatefulWidget {
  const MainContainer({Key? key}) : super(key: key);

  @override
  _MainContainerState createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  // List of app bar title
  List<String> _titles = [
    "Navigator",
    "List Employees",
    "Revenue Chart",
    "Notifications",
  ];

  String _title = "Navigator";

  // update app bar title
  void updateTitle(int index) {
    setState(() {
      _title = "${_titles[index]}";
    });
  }

  @override
  Widget build(BuildContext context) {
    //List screen navigate by bottom bar
    List<Widget> _buildScreens() {
      return [
        HomeScreen(),
        EmployeeDataGridView(),
        RevenueScreen(),
        NotificationScreen(),
      ];
    }

    //Building bottom navigation bar UI
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.home,
            size: 32,
          ),
          title: ("Home"),
          activeColorPrimary: Colors.blue,
          // activeColorSecondary: Colors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey2,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.person,
            size: 32,
          ),
          title: ("Employee"),
          activeColorPrimary: Colors.blue,
          // activeColorSecondary: Colors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey2,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.bar_chart,
            size: 32,
          ),
          title: ("Revenue"),
          activeColorPrimary: Colors.blue,
          // activeColorSecondary: Colors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey2,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(
            Icons.notifications_on_rounded,
            size: 32,
          ),
          title: ("Notifications"),
          activeColorPrimary: Colors.blue,
          // activeColorSecondary: Colors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey2,
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(_title),
        automaticallyImplyLeading: false,
        actions: [
          _title == "List Employees"
              ? IconButton(
                  onPressed: () => showSearch(
                      context: context, delegate: EmployeeSearchData()),
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
              : _title == "Navigator"
                  ? IconButton(
                      onPressed: () async =>
                          await FirebaseAuth.instance.signOut().then(
                                (value) => Get.offAllNamed('/loginScreen'),
                              ),
                      icon: Icon(
                        Icons.logout_outlined,
                        color: Colors.white,
                      ),
                    )
                  : SizedBox(),
        ],
      ),
      body: PersistentTabView(
        context,
        onItemSelected: (index) {
          updateTitle(index); // update app bar title
        },
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : 60,
        hideNavigationBarWhenKeyboardShows: true,
        margin: EdgeInsets.only(bottom: 0),
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        stateManagement: true,
        decoration: NavBarDecoration(
            colorBehindNavBar: Colors.white,
            borderRadius: BorderRadius.circular(0.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 3,
                blurRadius: 3,
                offset: Offset(0, 3),
              ),
            ]),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style6, // Choose the nav bar style with this property
      ),
    );
  }
}
