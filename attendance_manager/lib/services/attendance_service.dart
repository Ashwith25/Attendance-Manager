import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class AttendanceService {
  Logger logger = Logger();

  Future markAttendance(Map body) async {
    var url = Uri.parse('$baseUrl/attendances');
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = jsonDecode(pref.getString("user")!)["jwt"];
    Map<String, String> header = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    try {
      http.Response response = await http
          .post(url, headers: header, body: jsonEncode(body))
          .catchError((err) {
        logger.i('Post error $err');
      });
      Logger().i(response.statusCode);
      Logger().i(response.body);
      if (response.statusCode != 200) {
        // logger.i('Check your Credentials');
        // String errorMsg = jsonDecode(response.body)["error"];
        // logger.i(errorMsg);
        return null;
      } else {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (error) {
      logger.i('Catch $error');
      rethrow;
    }
  }

  Future getAttendance(String classId) async {
    var url = Uri.parse('$baseUrl/attendances?class.id=$classId');
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = jsonDecode(pref.getString("user")!)["jwt"];
    Map<String, String> header = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    try {
      http.Response response = await http
          .get(url, headers: header)
          .catchError((err) {
        logger.i('Post error $err');
      });
      Logger().i(response.statusCode);
      Logger().i(response.body);
      if (response.statusCode != 200) {
        // logger.i('Check your Credentials');
        // String errorMsg = jsonDecode(response.body)["error"];
        // logger.i(errorMsg);
        return null;
      } else {
        var data = jsonDecode(response.body);
        return data;
      }
    } catch (error) {
      logger.i('Catch $error');
      rethrow;
    }
  }
}
