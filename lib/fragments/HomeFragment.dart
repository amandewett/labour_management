import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labour_management/activities/WorkerDetailsActivity.dart';
import 'package:labour_management/models/DashboardCountersModel.dart';
import 'package:labour_management/models/WorkersListModel.dart';
import 'package:labour_management/service/WebService.dart';
import 'package:labour_management/utils/Colors.dart';
import 'package:labour_management/utils/Constants.dart';
import 'package:labour_management/utils/CustomPaint.dart';
import 'package:labour_management/utils/SizeConfig.dart';
import 'package:shimmer/shimmer.dart';

class HomeFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeFragmentState();
  }
}

class HomeFragmentState extends State<HomeFragment> {
  int _totalLabour = 0;
  int _totalPresent = 0;
  int _totalAmount = 0;
  Future<List<WorkersListModel>> getWorkersList;
  Future<DashboardCountersModel> getCounter;

  @override
  void initState() {
    getWorkersList = WebService().getWorkersList(context);
    getCounter = WebService().getCounters(context);
    getCounter.then((value) {
      setState(() {
        _totalLabour = value.labourCount;
      });
    });
    super.initState();
  }

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
                  future: getWorkersList,
                  builder: (BuildContext futureContext, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext listContext, int index) {
                            return Container(
                              child: Card(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) => WorkerDetailsActivity(
                                            snapshot.data[index].workersId, snapshot.data[index].workerName),
                                      ),
                                    );
                                  },
                                  title: Text(snapshot.data[index].workerName),
                                  subtitle: Text(snapshot.data[index].workerWage),
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
}
