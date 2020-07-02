import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:labour_management/utils/Alerts.dart';
import 'package:labour_management/utils/Colors.dart';
import 'package:labour_management/utils/Constants.dart';
import 'package:labour_management/utils/SizeConfig.dart';

class LoginActivity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginActivityState();
  }
}

class LoginActivityState extends State<LoginActivity> {
  var _loginFormKey = GlobalKey<FormState>();
  var _usernameController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    );
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Constants.LOGIN_BG),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: blueGreyTransparentColor,
          ),
          SingleChildScrollView(
            child: Form(
              key: _loginFormKey,
              child: Container(
                color: Colors.transparent,
                margin: EdgeInsets.only(
                  top: SizeConfig.blockSizeVertical * 4.0,
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Container(
                        child: Image.asset(
                      Constants.LOGO,
                      width: SizeConfig.safeBlockHorizontal * 30.0,
                      height: SizeConfig.safeBlockVertical * 30.0,
                    )),
                    Container(
                      margin: EdgeInsets.only(
                        top: SizeConfig.safeBlockVertical * 0.0,
                      ),
                      child: Text(
                        Constants.APP_NAME,
                        style: TextStyle(
                          color: textColor,
                          fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.safeBlockHorizontal * 7.5,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 5.0,
                        left: SizeConfig.safeBlockHorizontal * 4.0,
                        right: SizeConfig.safeBlockHorizontal * 4.0,
                      ),
                      child: TextFormField(
                        controller: _usernameController,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        style: TextStyle(
                          color: textColor,
                          fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                        ),
                        decoration: InputDecoration(
                          labelText: "Username",
                          labelStyle: TextStyle(
                            color: accentColor,
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                            fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                          ),
                          hintText: "Please enter your username",
                          hintStyle: TextStyle(
                            fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                            color: textColor,
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
                      margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeVertical * 3.0,
                        left: SizeConfig.safeBlockHorizontal * 4.0,
                        right: SizeConfig.safeBlockHorizontal * 4.0,
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        keyboardType: TextInputType.text,
                        maxLines: 1,
                        obscureText: true,
                        style: TextStyle(
                          color: textColor,
                          fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                        ),
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: accentColor,
                            fontSize: SizeConfig.safeBlockHorizontal * 4,
                            fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                          ),
                          hintText: "Please enter your password",
                          hintStyle: TextStyle(
                            fontFamily: Constants.OPEN_SANS_FONT_FAMILY,
                            color: textColor,
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
                          if (_loginFormKey.currentState.validate()) {
                            showToast(context, "Logged in");
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Login",
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
    );
  }
}
