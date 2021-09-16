import 'package:attendance_manager/auth/login.dart';
import 'package:attendance_manager/constants.dart';
import 'package:attendance_manager/theme.dart';
import 'package:attendance_manager/welcome.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    theme: AppTheme.getTheme(),
    debugShowCheckedModeBanner: false,
    home: LoginPage(),
  ));
}


