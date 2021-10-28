import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../services/auth_service.dart';
import '../services/toast_service.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _newpassword = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  final TextEditingController _email = TextEditingController();

  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;
  final _formKey = GlobalKey<FormState>();

  Map user = {};

  fillData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user = jsonDecode(prefs.getString('user')!)["user"];
    _email.text = user['email'];
    setState(() {});
  }

  changePassword(password) async {
    await Auth().changePassword({
      "password": password.trim(),
    }, user['id']);
    ToastService.showToast("Password updated", context);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    fillData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Text(
                    "Change Password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: goldenColor),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                    child: TextFormField(
                        controller: _email,
                        readOnly: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email Address can't be empty";
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                            helperStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: "Email Address",
                            labelStyle: TextStyle(color: Colors.white))),
                  ),

                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: TextFormField(
                      controller: _newpassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password can't be empty";
                        }
                        return null;
                      },
                      obscureText: !_passwordVisible2,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible2 = !_passwordVisible2;
                            });
                          },
                        ),
                        helperStyle: const TextStyle(color: Colors.white),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "New Password",
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: TextFormField(
                      controller: _confirm,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Confirm Password can't be empty";
                        } else if (_newpassword.text != value) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      obscureText: !_passwordVisible1,
                      style: const TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible1
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible1 = !_passwordVisible1;
                            });
                          },
                        ),
                        helperStyle: const TextStyle(color: Colors.white),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Confirm New Password",
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      color: goldenColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        "Update",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          changePassword(_confirm.text);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
