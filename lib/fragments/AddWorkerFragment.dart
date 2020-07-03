import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labour_management/service/WebService.dart';
import 'package:labour_management/utils/Alerts.dart';
import 'package:labour_management/utils/Colors.dart';
import 'package:labour_management/utils/Constants.dart';
import 'package:labour_management/utils/CustomPaint.dart';
import 'package:labour_management/utils/SizeConfig.dart';

class AddWorkerFragment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddWorkerFragmentState();
  }
}

class AddWorkerFragmentState extends State<AddWorkerFragment> {
  final _newWorkerFormKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();

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
                              WebService()
                                  .addWorker(context, _nameController.text.trim(), _amountController.text.trim())
                                  .then((value) {
                                if (value == true) {
                                  _nameController.clear();
                                  _amountController.clear();
                                  showToast(context, "Worker added");
                                } else {
                                  showToast(context, "Error");
                                }
                              });
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
}
