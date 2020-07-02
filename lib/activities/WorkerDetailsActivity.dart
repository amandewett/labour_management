import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labour_management/utils/Colors.dart';
import 'package:labour_management/utils/Constants.dart';
import 'package:labour_management/utils/CustomPaint.dart';
import 'package:labour_management/utils/SizeConfig.dart';
import 'package:shimmer/shimmer.dart';

class WorkerDetailsActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return WorkerDetailsActivityState();
  }
}

class WorkerDetailsActivityState extends State<WorkerDetailsActivity> {
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
    return new WillPopScope(
      onWillPop: () async => true,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: Stack(
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
                    automaticallyImplyLeading: true,
                    centerTitle: true,
                    backgroundColor: primaryColor,
                    title: Text(
                      "Bhaiya ji naam",
                      style: TextStyle(
                        fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.safeBlockHorizontal * 6.0,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                      top: SizeConfig.safeBlockVertical * 20.0,
                      left: SizeConfig.safeBlockVertical * 5.0,
                      right: SizeConfig.safeBlockVertical * 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MaterialButton(
                          color: Colors.white,
                          onPressed: () {},
                          child: Text(
                            "Absent",
                            style: TextStyle(
                                color: primaryColor, fontFamily: Constants.OPEN_SANS_FONT_FAMILY, fontWeight: FontWeight.w600),
                          ),
                        ),
                        MaterialButton(
                          color: primaryColor,
                          onPressed: () {},
                          child: Text(
                            "Present",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: FutureBuilder(
                          future: null,
                          builder: (BuildContext futureContext, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Container();
                            } else {
                              return Container(
                                child: DataTable(
                                  columns: [
                                    DataColumn(
                                      label: Text(
                                        "Date",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                                          fontSize: SizeConfig.safeBlockHorizontal * 5.0,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Amount",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                                          fontSize: SizeConfig.safeBlockHorizontal * 5.0,
                                        ),
                                      ),
                                    ),
                                    DataColumn(
                                      label: Text(
                                        "Attendance",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                                          fontSize: SizeConfig.safeBlockHorizontal * 5.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(Shimmer.fromColors(
                                        child: Container(
                                          width: SizeConfig.safeBlockHorizontal * 15.0,
                                          height: 10.0,
                                          color: Colors.grey,
                                        ),
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.white,
                                      )),
                                      DataCell(Shimmer.fromColors(
                                        child: Container(
                                          width: SizeConfig.safeBlockHorizontal * 15.0,
                                          height: 10.0,
                                          color: Colors.grey,
                                        ),
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.white,
                                      )),
                                      DataCell(Shimmer.fromColors(
                                        child: Container(
                                          width: SizeConfig.safeBlockHorizontal * 15.0,
                                          height: 10.0,
                                          color: Colors.grey,
                                        ),
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.white,
                                      )),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Shimmer.fromColors(
                                        child: Container(
                                          width: SizeConfig.safeBlockHorizontal * 15.0,
                                          height: 10.0,
                                          color: Colors.grey,
                                        ),
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.white,
                                      )),
                                      DataCell(Shimmer.fromColors(
                                        child: Container(
                                          width: SizeConfig.safeBlockHorizontal * 15.0,
                                          height: 10.0,
                                          color: Colors.grey,
                                        ),
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.white,
                                      )),
                                      DataCell(Shimmer.fromColors(
                                        child: Container(
                                          width: SizeConfig.safeBlockHorizontal * 15.0,
                                          height: 10.0,
                                          color: Colors.grey,
                                        ),
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.white,
                                      )),
                                    ]),
                                    DataRow(cells: [
                                      DataCell(Shimmer.fromColors(
                                        child: Container(
                                          width: SizeConfig.safeBlockHorizontal * 15.0,
                                          height: 10.0,
                                          color: Colors.grey,
                                        ),
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.white,
                                      )),
                                      DataCell(Shimmer.fromColors(
                                        child: Container(
                                          width: SizeConfig.safeBlockHorizontal * 15.0,
                                          height: 10.0,
                                          color: Colors.grey,
                                        ),
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.white,
                                      )),
                                      DataCell(Shimmer.fromColors(
                                        child: Container(
                                          width: SizeConfig.safeBlockHorizontal * 15.0,
                                          height: 10.0,
                                          color: Colors.grey,
                                        ),
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.white,
                                      )),
                                    ]),
                                  ],
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
