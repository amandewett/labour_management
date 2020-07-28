import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labour_management/service/WebService.dart';
import 'package:labour_management/utils/Colors.dart';
import 'package:labour_management/utils/Constants.dart';
import 'package:labour_management/utils/CustomPaint.dart';
import 'package:labour_management/utils/SizeConfig.dart';
import 'package:shimmer/shimmer.dart';

class WorkerDetailsActivity extends StatefulWidget {
  final int workerId;
  final String workerName;
  final String workerWage;

  WorkerDetailsActivity(this.workerId, this.workerName, this.workerWage);

  @override
  State<StatefulWidget> createState() {
    return WorkerDetailsActivityState(this.workerId, this.workerName, this.workerWage);
  }
}

class WorkerDetailsActivityState extends State<WorkerDetailsActivity> with SingleTickerProviderStateMixin {
  var _newPaymentFormKey = GlobalKey<FormState>();
  var _paymentAmountController = TextEditingController();
  TabController _tabController;
  String _selectedDate = "";
  String _selectedPaymentDate = "";
  String _selectedPostDate = "";
  String _selectedPostPaymentDate = "";
  static DateTime _currentDate = DateTime.now();
  final int workerId;
  final String workerName;
  final String workerWage;
  Future<List<Map<String, dynamic>>> getAttendance;
  List<Map<String, dynamic>> dataList = [];

  WorkerDetailsActivityState(this.workerId, this.workerName, this.workerWage);

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    _selectedDate = "${_currentDate.day}-${_currentDate.month}-${_currentDate.year}";
    _selectedPaymentDate = "${_currentDate.day}-${_currentDate.month}-${_currentDate.year}";
    _selectedPostDate = "${_currentDate.year}-${_currentDate.month}-${_currentDate.day}";
    _selectedPostPaymentDate = "${_currentDate.year}-${_currentDate.month}-${_currentDate.day}";
    getAttendance = WebService().getAttendance(context, workerId);
    getAttendance.then((value) => {
          for (var object in value) {dataList.add(object)}
        });
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
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _addPaymentDialog();
            },
            tooltip: "Add new payment",
            child: Icon(
              Icons.add,
            ),
          ),
          body: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: SizeConfig.safeBlockVertical * 13.0,
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
                      workerName,
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
                      top: SizeConfig.safeBlockVertical * 5.0,
                      left: SizeConfig.safeBlockVertical * 5.0,
                      right: SizeConfig.safeBlockVertical * 5.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          child: Text(
                            "₹ 5000",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                              fontSize: SizeConfig.safeBlockHorizontal * 10.0,
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Balance",
                            style: TextStyle(
                              fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                              fontSize: SizeConfig.safeBlockHorizontal * 4.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                      top: SizeConfig.safeBlockVertical * 2.0,
                      left: SizeConfig.safeBlockVertical * 5.0,
                      right: SizeConfig.safeBlockVertical * 5.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MaterialButton(
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              dataList.clear();
                              WebService().markAttendance(context, workerId, Constants.ABSENT, _selectedPostDate).then((value) {
                                setState(() {
                                  getAttendance = WebService().getAttendance(context, workerId);
                                  getAttendance.then((value) => {
                                        for (var object in value) {dataList.add(object)}
                                      });
                                });
                              });
                            });
                          },
                          child: Text(
                            "Absent",
                            style: TextStyle(
                                color: primaryColor, fontFamily: Constants.OPEN_SANS_FONT_FAMILY, fontWeight: FontWeight.w600),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _datePicker();
                          },
                          child: Shimmer.fromColors(
                            child: Text(
                              _selectedDate,
                              style: TextStyle(
                                fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            baseColor: primaryColor,
                            highlightColor: primaryLightColor,
                          ),
                        ),
                        MaterialButton(
                          color: primaryColor,
                          onPressed: () {
                            setState(() {
                              dataList.clear();
                              WebService().markAttendance(context, workerId, Constants.PRESENT, _selectedPostDate).then((value) {
                                setState(() {
                                  getAttendance = WebService().getAttendance(context, workerId);
                                  getAttendance.then((value) => {
                                    for (var object in value) {dataList.add(object)}
                                  });
                                });
                              });
                            });
                          },
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
                    child: Column(
                      children: <Widget>[
                        TabBar(
                          controller: _tabController,
                          unselectedLabelColor: Colors.grey.shade500,
                          indicatorColor: accentColor,
                          indicatorSize: TabBarIndicatorSize.tab,
                          tabs: <Widget>[
                            new Tab(
                              text: "Attendance",
                            ),
                            new Tab(
                              text: "Payments",
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: <Widget>[
                              new Container(
                                width: MediaQuery.of(context).size.width,
                                child: SingleChildScrollView(
                                  child: FutureBuilder(
                                    future: getAttendance,
                                    builder: (BuildContext futureContext, AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
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
                                                  "Attendance",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                                                    fontSize: SizeConfig.safeBlockHorizontal * 5.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                            rows: dataList.map((element) {
                                              return DataRow(
                                                cells: [
                                                  DataCell(Text(dateFormat
                                                      .format(DateTime.fromMillisecondsSinceEpoch(element['unixDate']))
                                                      .toString())),
                                                  DataCell(Text(element['attendance'])),
                                                ],
                                              );
                                            }).toList(),
                                          ),
                                        );
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
                                              ]),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                              new Container(
                                color: Colors.lightGreenAccent,
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
                            ],
                          ),
                        ),
                      ],
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

  _datePicker() {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(4000),
    ).then((newDate) {
      setState(() {
        _selectedPostDate = "${newDate.year}-${newDate.month}-${newDate.day}";
        _selectedDate = "${newDate.day}-${newDate.month}-${newDate.year}";
      });
    });
  }

  _paymentDatePicker(setState) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(4000),
    ).then((newDate) {
      setState(() {
        _selectedPostPaymentDate = "${newDate.year}-${newDate.month}-${newDate.day}";
        _selectedPaymentDate = "${newDate.day}-${newDate.month}-${newDate.year}";
      });
    });
  }

  _addPaymentDialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext dialogContext) {
          return StatefulBuilder(
            builder: (statefulContext, setState) {
              return AlertDialog(
                title: Container(
                  width: MediaQuery.of(dialogContext).size.width,
                  child: Center(child: Text("Add Payment")),
                ),
                content: SingleChildScrollView(
                  child: Form(
                    key: _newPaymentFormKey,
                    child: Container(
                      width: MediaQuery.of(dialogContext).size.width,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              _paymentDatePicker(setState);
                            },
                            child: Shimmer.fromColors(
                              child: Text(
                                _selectedPaymentDate,
                                style: TextStyle(
                                  fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.safeBlockHorizontal * 5.0,
                                ),
                              ),
                              baseColor: primaryColor,
                              highlightColor: primaryLightColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: SizeConfig.safeBlockVertical * 3.0,
                            ),
                            child: TextFormField(
                              controller: _paymentAmountController,
                              keyboardType: TextInputType.number,
                              maxLines: 1,
                              style: TextStyle(
                                color: dashboardCounterColor,
                                fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                              ),
                              decoration: InputDecoration(
                                labelText: "Amount",
                                labelStyle: TextStyle(
                                  color: primaryColor,
                                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                                  fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                                ),
                                hintText: "Please enter a amount",
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
                        ],
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      Navigator.pop(context);
                    },
                    child: Text("Cancel"),
                  ),
                  FlatButton(
                      onPressed: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        Navigator.pop(context);
                      },
                      child: Text("Ok")),
                ],
              );
            },
          );
        });
  }
}
