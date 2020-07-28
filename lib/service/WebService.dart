import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:labour_management/activities/LoginActivity.dart';
import 'package:labour_management/activities/MainActivity.dart';
import 'package:labour_management/models/AttendanceModel.dart';
import 'package:labour_management/models/DashboardCountersModel.dart';
import 'package:labour_management/models/WorkersListModel.dart';
import 'package:labour_management/utils/Alerts.dart';
import 'package:labour_management/utils/Constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebService {
  static const STATIC_HEADERS = {"Accept": "application/json"};
  static const BASE_URL = "http://100.100.100.4:3000/"; //localhost
//  static const BASE_URL = ""; //production
  static const SIGNUP = BASE_URL + "users/signup"; //(POST)
  static const LOGIN = BASE_URL + "users/login"; //(POST)
  static const ADD_WORKER = BASE_URL + "workers/add"; //(POST)
  static const WORKERS_LIST = BASE_URL + "workers/list"; //(GET)
  static const DASHBOARD_COUNTER = BASE_URL + "workers/counters"; //(GET)
  static const MARK_ATTENDANCE = BASE_URL + "attendance/markAttendance"; //(POST)
  static const ATTENDANCE_LIST = BASE_URL + "attendance/myAttendance"; //(POST)

  //user login
  login(context, email, password) async {
    SharedPreferences mSharedPreferences = await SharedPreferences.getInstance();

    Map loginData = {
      'email': email,
      'password': password,
    };

    var loginResponse = await http.post(
      Uri.encodeFull(LOGIN),
      headers: STATIC_HEADERS,
      body: loginData,
    );

    if (loginResponse.statusCode == 200) {
      var jsonData = json.decode(loginResponse.body);
      if (jsonData['status'] == true) {
        await mSharedPreferences.setString(Constants.LOGIN_STATUS, "true");
        await mSharedPreferences.setInt(Constants.USER_ID, jsonData['result']['user_id']);
        await mSharedPreferences.setString(Constants.USER_NAME, jsonData['result']['user_name']);
        await mSharedPreferences.setString(Constants.USER_EMAIL, jsonData['result']['user_email']);
        await mSharedPreferences.setString(Constants.JWT_TOKEN, jsonData['result']['token']);
        showToast(context, "Welcome Mr. ${jsonData['result']['user_name']}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => MainActivity(),
          ),
        );
      } else {
        showToast(context, jsonData['message']);
      }
    } else {
      showToast(context, "Error");
    }
  } //login

  logout(context) async {
    SharedPreferences mSharedPreferences = await SharedPreferences.getInstance();
    await mSharedPreferences.setString(Constants.LOGIN_STATUS, "false");
    await mSharedPreferences.remove(Constants.JWT_TOKEN);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => LoginActivity(),
      ),
    );
  }

  signup(context, name, email, password) async {
    Map postData = {
      'name': name,
      'email': email,
      'password': password,
    };

    var response = await http.post(
      Uri.encodeFull(SIGNUP),
      headers: STATIC_HEADERS,
      body: postData,
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['status'] == true) {
        showToast(context, jsonData['message']);
        Navigator.pop(context);
      } else {
        showToast(context, jsonData['message']);
      }
    } else {
      showToast(context, "Error");
    }
  } //signup

  Future<bool> addWorker(context, name, wage) async {
    SharedPreferences mSharedPreferences = await SharedPreferences.getInstance();

    Map postData = {
      'name': name,
      'wage': wage,
    };

    var response = await http.post(
      Uri.encodeFull(ADD_WORKER),
      headers: {
        "Authorization": "Bearer " + mSharedPreferences.getString(Constants.JWT_TOKEN),
      },
      body: postData,
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['status'] == true) {
        return true;
      } else {
        return false;
      }
    } else if (response.statusCode == 401) {
      logout(context);
      showToast(context, "Invalid session");
      return false;
    } else {
      return false;
    }
  } //addWorker

  Future<List<WorkersListModel>> getWorkersList(context) async {
    SharedPreferences mSharedPreferences = await SharedPreferences.getInstance();
    List<WorkersListModel> workersList = [];

    var response = await http.get(
      Uri.encodeFull(WORKERS_LIST),
      headers: {
        "Authorization": "Bearer " + mSharedPreferences.getString(Constants.JWT_TOKEN),
      },
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['status'] == true) {
        for (var data in jsonData['result']) {
          WorkersListModel workersListModel = WorkersListModel(
            data['worker_id'],
            data['user_id'],
            data['worker_name'],
            data['worker_wage'].toString(),
          );
          workersList.add(workersListModel);
        }
        return workersList;
      } else {
        showToast(context, "Error");
        return null;
      }
    } else if (response.statusCode == 401) {
      logout(context);
      showToast(context, "Invalid session");
      return null;
    } else {
      showToast(context, "Error");
      return null;
    }
  } //getWorkersList

  Future<DashboardCountersModel> getCounters(context) async {
    SharedPreferences mSharedPreferences = await SharedPreferences.getInstance();

    var response = await http.get(
      Uri.encodeFull(DASHBOARD_COUNTER),
      headers: {
        "Authorization": "Bearer " + mSharedPreferences.getString(Constants.JWT_TOKEN),
      },
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['status'] == true) {
        DashboardCountersModel dashboardCountersModel = DashboardCountersModel(
          jsonData['labour'],
        );
        return dashboardCountersModel;
      } else {
        showToast(context, jsonData['error']);
        return null;
      }
    } else if (response.statusCode == 401) {
      logout(context);
      showToast(context, "Invalid session");
      return null;
    } else {
      showToast(context, "Error");
      return null;
    }
  } //getCounters

  markAttendance(context, workerId, attendance, date) async {
    SharedPreferences mSharedPreferences = await SharedPreferences.getInstance();

    Map postData = {
      'workerId': workerId.toString(),
      'attendance': attendance,
      'date': date,
    };

    var response = await http.post(
      Uri.encodeFull(MARK_ATTENDANCE),
      headers: {
        "Authorization": "Bearer " + mSharedPreferences.getString(Constants.JWT_TOKEN),
      },
      body: postData,
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['status'] == true) {
        showToast(context, jsonData['message']);
      } else {
        showToast(context, "Error");
      }
    } else if (response.statusCode == 401) {
      logout(context);
      showToast(context, "Invalid session");
    }
  } //markAttendance

  Future<List<AttendanceModel>> getAttendance(context, workerId) async {
    SharedPreferences mSharedPreferences = await SharedPreferences.getInstance();
    List<AttendanceModel> attendanceList = [];
    AttendanceModel attendanceModel;

    Map postData = {
      'workerId': workerId.toString(),
    };

    var response = await http.post(
      Uri.encodeFull(ATTENDANCE_LIST),
      headers: {
        "Authorization": "Bearer " + mSharedPreferences.getString(Constants.JWT_TOKEN),
      },
      body: postData,
    );

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      if (jsonData['status'] == true) {
        for (var data in jsonData['result']) {
          attendanceModel = AttendanceModel(
            data['attendance'],
            data['unixDate'],
          );
          attendanceList.add(attendanceModel);
        }
        return attendanceList;
      } else {
        showToast(context, "Error");
        return attendanceList;
      }
    } else if (response.statusCode == 401) {
      logout(context);
      showToast(context, "Invalid session");
      return attendanceList;
    }
  } //markAttendance
}
