import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labour_management/fragments/AddWorkerFragment.dart';
import 'package:labour_management/fragments/HomeFragment.dart';
import 'package:labour_management/fragments/SettingsFragment.dart';
import 'package:labour_management/utils/Colors.dart';
import 'package:labour_management/utils/SizeConfig.dart';

class MainActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainActivityState();
  }
}

class MainActivityState extends State<MainActivity> {
  int selectedBottomOption = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    final List<Widget> _pages = <Widget>[
      HomeFragment(),
      AddWorkerFragment(),
      SettingsFragment(),
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundColor,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          backgroundColor: backgroundColor,
          height: 50.0,
          animationDuration: Duration(milliseconds: 200),
          items: <Widget>[
            Icon(Icons.home, size: 30, color: primaryColor),
            Icon(Icons.add, size: 30, color: primaryColor),
            Icon(Icons.settings, size: 30, color: primaryColor),
          ],
          index: selectedBottomOption,
          onTap: (index) {
            setState(() {
              selectedBottomOption = index;
            });
          },
        ),
        body: _pages.elementAt(selectedBottomOption),
      ),
    );
  }
}
