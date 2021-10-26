import 'dart:convert';
import 'dart:io';

import 'package:attendance_manager/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

class ClassService {
  Logger logger = Logger();

  Future addClass(String teacherId, String subject, String className) async {
    var url = Uri.parse('$baseUrl/classes');
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = jsonDecode(pref.getString("user")!)["jwt"];
    Map<String, String> header = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    try {
      http.Response response = await http
          .post(url,
              headers: header,
              body: jsonEncode({
                "className": className,
                "subject": subject,
                "teacher": teacherId,
              }))
          .catchError((err) {
        logger.i('Post error $err');
      });
      if (response.statusCode != 200) {
        // logger.i('Check your Credentials');
        String errorMsg = jsonDecode(response.body)["error"];
        logger.i(errorMsg);
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

  Future getClass() async {
    var url = Uri.parse('$baseUrl/classes');
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = jsonDecode(pref.getString("user")!)["jwt"];
    Map<String, String> header = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    try {
      http.Response response = await http
          .get(url,
              headers: header)
          .catchError((err) {
        logger.i('Post error $err');
      });
      if (response.statusCode != 200) {
        // logger.i('Check your Credentials');
        String errorMsg = jsonDecode(response.body)["error"];
        logger.i(errorMsg);
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

  Future getEachClassDetails(String classId) async {
    var url = Uri.parse('$baseUrl/classes/$classId');
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = jsonDecode(pref.getString("user")!)["jwt"];
    Map<String, String> header = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    try {
      http.Response response = await http
          .get(url,
              headers: header)
          .catchError((err) {
        logger.i('Post error $err');
      });
      if (response.statusCode != 200) {
        // logger.i('Check your Credentials');
        String errorMsg = jsonDecode(response.body)["error"];
        logger.i(errorMsg);
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

  getStudents() async{
    var url = Uri.parse('$baseUrl/users');
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = jsonDecode(pref.getString("user")!)["jwt"];
    Map<String, String> header = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    try {
      http.Response response = await http
          .get(url,
              headers: header)
          .catchError((err) {
        logger.i('Post error $err');
      });
      if (response.statusCode != 200) {
        // logger.i('Check your Credentials');
        String errorMsg = jsonDecode(response.body)["error"];
        logger.i(errorMsg);
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

  Future addStudent(data, String classId) async {
    var url = Uri.parse('$baseUrl/classes/$classId');
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = jsonDecode(pref.getString("user")!)["jwt"];
    Map<String, String> header = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token",
    };
    try {
      http.Response response = await http
          .put(url,
              headers: header,
              body: jsonEncode(data))
          .catchError((err) {
        logger.i('Post error $err');
      });
      if (response.statusCode != 200) {
        // logger.i('Check your Credentials');
        String errorMsg = jsonDecode(response.body)["error"];
        logger.i(errorMsg);
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
