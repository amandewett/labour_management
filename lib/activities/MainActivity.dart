import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labour_management/activities/WorkerDetailsActivity.dart';
import 'package:labour_management/utils/Alerts.dart';
import 'package:labour_management/utils/Colors.dart';
import 'package:labour_management/utils/Constants.dart';
import 'package:labour_management/utils/CustomPaint.dart';
import 'package:labour_management/utils/SizeConfig.dart';
import 'package:shimmer/shimmer.dart';

class MainActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainActivityState();
  }
}

class MainActivityState extends State<MainActivity> {
  final int _totalLabour = 0;
  final int _totalPresent = 0;
  final int _totalAmount = 0;
  int _selectedBottomOption = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  var _newWorkerFormKey = GlobalKey<FormState>();
  var _nameController = TextEditingController();
  var _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    final List<Widget> _pages = <Widget>[
      _homePage(context, _totalLabour, _totalPresent, _totalAmount),
      _addPage(context, _totalLabour, _totalPresent, _totalAmount, _newWorkerFormKey, _nameController, _amountController),
      _settingsPage(context, _totalLabour, _totalPresent, _totalAmount),
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
          index: _selectedBottomOption,
          onTap: (index) {
            setState(() {
              _selectedBottomOption = index;
            });
          },
        ),
        body: _pages.elementAt(_selectedBottomOption),
      ),
    );
  }

  static Widget _homePage(context, _totalLabour, _totalPresent, _totalAmount) {
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
                Constants.APP_NAME,
                style: TextStyle(
                  fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.safeBlockHorizontal * 6.0,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(
                top: SizeConfig.safeBlockVertical * 16.0,
                left: SizeConfig.safeBlockHorizontal * 5.0,
                right: SizeConfig.safeBlockHorizontal * 5.0,
              ),
              child: Card(
                elevation: 3.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(
                    SizeConfig.safeBlockHorizontal * 5.0,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Total Labour",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                _totalLabour.toString(),
                                style: TextStyle(
                                  fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                                  fontWeight: FontWeight.w600,
                                  color: dashboardCounterColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Total Present",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                _totalPresent.toString(),
                                style: TextStyle(
                                  fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                                  fontWeight: FontWeight.w600,
                                  color: dashboardCounterColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Total Amount",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                _totalAmount.toString(),
                                style: TextStyle(
                                  fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                                  fontWeight: FontWeight.w600,
                                  color: dashboardCounterColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(
                  top: SizeConfig.safeBlockVertical * 0.0,
                  left: SizeConfig.safeBlockHorizontal * 2.0,
                  right: SizeConfig.safeBlockHorizontal * 2.0,
                ),
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future: null,
                  builder: (BuildContext futureContext, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (BuildContext listContext, int index) {
                            return Container(
                              child: Card(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => WorkerDetailsActivity(),
                                      ),
                                    );
                                  },
                                  title: Text("Bhaiya da naam"),
                                  subtitle: Text("500"),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Container(
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (BuildContext listContext, int index) {
                            return Shimmer.fromColors(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.all(10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: SizeConfig.safeBlockHorizontal * 15.0,
                                        height: SizeConfig.safeBlockHorizontal * 15.0,
                                        color: Colors.grey,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context).size.width,
                                              height: SizeConfig.safeBlockHorizontal * 3.0,
                                              margin: EdgeInsets.all(10.0),
                                              color: Colors.grey,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context).size.width / 2,
                                              height: SizeConfig.safeBlockHorizontal * 3.0,
                                              margin: EdgeInsets.all(10.0),
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                baseColor: Colors.grey.shade400,
                                highlightColor: Colors.white);
                          },
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget _addPage(
      context, _totalLabour, _totalPresent, _totalAmount, _newWorkerFormKey, _nameController, _amountController) {
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
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            AppBar(
              elevation: 0.0,
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: primaryColor,
              title: Text(
                "Add New Worker",
                style: TextStyle(
                  fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.safeBlockHorizontal * 6.0,
                ),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: SizeConfig.safeBlockVertical * 20.0,
                left: SizeConfig.safeBlockHorizontal * 5.0,
                right: SizeConfig.safeBlockHorizontal * 5.0,
              ),
              child: Form(
                key: _newWorkerFormKey,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: TextStyle(
                          color: dashboardCounterColor,
                          fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                        ),
                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(
                            color: primaryColor,
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                            fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                          ),
                          hintText: "Please enter worker's name",
                          hintStyle: TextStyle(
                            fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                            color: dashboardCounterColor,
                          ),
                          border: OutlineInputBorder(),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return Constants.EMPTY_FIELD_ERROR;
                          } else {
                            return null;
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: TextFormField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          style: TextStyle(
                            color: dashboardCounterColor,
                            fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                          ),
                          decoration: InputDecoration(
                            labelText: "Wage",
                            labelStyle: TextStyle(
                              color: primaryColor,
                              fontSize: SizeConfig.safeBlockHorizontal * 4,
                              fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                            ),
                            hintText: "Please enter worker's wage",
                            hintStyle: TextStyle(
                              fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                              color: dashboardCounterColor,
                            ),
                            border: OutlineInputBorder(),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.red,
                              ),
                            ),
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return Constants.EMPTY_FIELD_ERROR;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockSizeVertical * 3.0,
                          left: SizeConfig.safeBlockHorizontal * 4.0,
                          right: SizeConfig.safeBlockHorizontal * 4.0,
                        ),
                        child: MaterialButton(
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                            side: BorderSide(
                              color: primaryColor,
                            ),
                          ),
                          color: primaryColor,
                          onPressed: () {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            if (_newWorkerFormKey.currentState.validate()) {
                              showToast(context, "Logged in");
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Add",
                              style: TextStyle(
                                color: textColor,
                                fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                                fontSize: SizeConfig.safeBlockHorizontal * 5.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static Widget _settingsPage(context, _totalLabour, _totalPresent, _totalAmount) {
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
