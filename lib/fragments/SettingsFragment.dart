import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labour_management/utils/Colors.dart';
import 'package:labour_management/utils/Constants.dart';
import 'package:labour_management/utils/CustomPaint.dart';
import 'package:labour_management/utils/SizeConfig.dart';

class SettingsFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SettingsFragmentState();
  }
}

class SettingsFragmentState extends State<SettingsFragment> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: SizeConfig.safeBlockVertical * 25.0,
          child: CustomPaint(
            painter: CustomDesign(),
          ),
        ),
        Column(
          children: <Widget>[
            AppBar(
              elevation: 0.0,
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: primaryColor,
              title: Text(
                "Settings",
                style: TextStyle(
                  fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.safeBlockHorizontal * 6.0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
