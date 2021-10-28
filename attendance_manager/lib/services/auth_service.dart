import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class Auth {
  Logger logger = Logger();

  Future login(String email, String password) async {
    var url = Uri.parse('$baseUrl/auth/local');
    Map<String, String> header = {
      "Content-type": "application/json",
    };
    try {
      http.Response response = await http
          .post(url,
              headers: header,
              body: jsonEncode({
                "identifier": email.trim(),
                "password": password.trim(),
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user', json.encode(data));
        logger.i(data);
        return data;
      }
    } catch (error) {
      logger.i('Catch $error');
      rethrow;
    }
  }

  Future register(String email, String name, String password) async {
    var url = Uri.parse('$baseUrl/auth/local/register');
    Map<String, String> header = {
      "Content-type": "application/json",
    };
    try {
      http.Response response = await http
          .post(url,
              headers: header,
              body: jsonEncode({
                "email": email.trim(),
                "password": password.trim(),
                "username": name.trim(),
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
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user', json.encode(data));
        logger.i(data);
        return data;
      }
    } catch (error) {
      logger.i('Catch $error');
      rethrow;
    }
  }

  Future changePassword(Map body, String userid) async {
    var url = Uri.parse('$baseUrl/users/$userid');
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
              body: jsonEncode(body))
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
