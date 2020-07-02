import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labour_management/activities/LoginActivity.dart';
import 'package:labour_management/activities/MainActivity.dart';
import 'package:labour_management/utils/Colors.dart';
import 'package:labour_management/utils/Constants.dart';
import 'package:labour_management/utils/SizeConfig.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashActivityState();
  }
}

class SplashActivityState extends State<SplashActivity> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    SharedPreferences mSharedPreferences = await SharedPreferences.getInstance();
    if (mSharedPreferences.getString(Constants.LOGIN_STATUS) == "true") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MainActivity(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MainActivity(),
        ),
      );
    }
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    return Scaffold(
      body: Center(
        child: Image.asset(
          Constants.LOGO,
          width: SizeConfig.safeBlockHorizontal * 50.0,
          height: SizeConfig.safeBlockVertical * 50.0,
        ),
      ),
    );
  }
}
