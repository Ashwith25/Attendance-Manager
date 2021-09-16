import 'package:attendance_manager/constants.dart';
import 'package:attendance_manager/theme.dart';
import 'package:flutter/material.dart';
import 'package:attendance_manager/auth/login.dart'


void main() {
  runApp(MaterialApp(
    theme: AppTheme.getTheme(),
    debugShowCheckedModeBanner: false,
    home: login(),
  ));
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          color: Theme.of(context).primaryColor,
        ),
        
      ),
    );
  }
}
