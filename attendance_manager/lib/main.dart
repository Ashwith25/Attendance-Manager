import 'package:attendance_manager/theme.dart';
import 'package:attendance_manager/welcome.dart';
import 'package:flutter/material.dart';
import 'Home/teacherHome.dart';

void main() {
  runApp(MaterialApp(
    theme: AppTheme.getTheme(),
    debugShowCheckedModeBanner: false,
    home: SplashScreen6(),
  ));
}

// This widget is the root of your application.
@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Attendance Manager',
    theme: AppTheme.getTheme(),
    home: TeacherHome(),
  );
}
