import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:staff_management/screens/employee/employeeDGV.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //List screen navigate by bottom bar
    List<Widget> _buildScreens() {
      return [
        EmployeeDataGridView(),
        EmployeeDataGridView(),
        EmployeeDataGridView(),
        EmployeeDataGridView(),
      ];
    }

    //Building bottom navigation bar UI
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
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
            Icons.home,
            size: 32,
          ),
          title: ("Units"),
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
            Icons.settings,
            size: 32,
          ),
          title: ("Settings"),
          activeColorPrimary: Colors.blue,
          // activeColorSecondary: Colors.white,
          inactiveColorPrimary: CupertinoColors.systemGrey2,
        ),
      ];
    }

    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      // handleAndroidBackButtonPress: true,
      // resizeToAvoidBottomInset: true,
      // stateManagement: true,
      navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0 ? 0.0 : 60,
      hideNavigationBarWhenKeyboardShows: true,
      margin: EdgeInsets.only(bottom: 0),
      popActionScreens: PopActionScreensType.all,
      bottomScreenMargin: 0.0,
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
    );
  }
}
