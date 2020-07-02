import 'package:flutter/material.dart';
import 'package:labour_management/activities/SplashActivity.dart';
import 'package:labour_management/utils/Colors.dart';
import 'package:labour_management/utils/Constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.APP_NAME,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        primaryColorDark: primaryDarkColor,
        primaryColorLight: primaryLightColor,
        accentColor: accentColor,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.red,
      ),
      home: SplashActivity(),
    );
  }
}
