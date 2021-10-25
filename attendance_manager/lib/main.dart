import 'package:attendance_manager/theme.dart';
import 'package:attendance_manager/welcome.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Home/teacherHome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();
  var data = pref.getString('user');
  // Logger().i(data);
  if (data != null) {
    runApp(MaterialApp(
      title: 'Attendance Manager',
      theme: AppTheme.getTheme(),
      debugShowCheckedModeBanner: false,
      home: const TeacherHome(),
    ));
  }
  // else if (data != null) {
  //   runApp(MaterialApp(
  //     theme: AppTheme.getTheme(),
  //     debugShowCheckedModeBanner: false,
  //     home: const TeacherHome(),
  //   ));
  // }
  else {
    runApp(MaterialApp(
      title: 'Attendance Manager',
      theme: AppTheme.getTheme(),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen6(),
    ));
  }
}

// This widget is the root of your application.
// @override
// Widget build(BuildContext context) {
//   return MaterialApp(
//     title: 'Attendance Manager',
//     theme: AppTheme.getTheme(),
//     home: const TeacherHome(),
//   );
// }
