import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showSnackbar(mContext,message) {
  final snackbar = SnackBar(
    duration: Duration(seconds: 1),
    content: Text(message),
  );
  Scaffold.of(mContext).showSnackBar(snackbar);
}

void showToast(BuildContext mContext, String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black54,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
