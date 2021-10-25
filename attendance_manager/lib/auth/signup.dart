import 'package:attendance_manager/Home/teacherHome.dart';
import 'package:attendance_manager/auth/login.dart';
import 'package:attendance_manager/constants.dart';
import 'package:attendance_manager/services/auth_service.dart';
import 'package:attendance_manager/services/toast_service.dart';
import 'package:attendance_manager/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirm = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();

  bool _passwordVisible = false;
  bool _passwordVisible1 = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          // leading: Container(),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: 10,
                // ),
                Text(
                  "SignUp",
                  style: TextStyle(
                      fontSize: 50,
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
                      validator: (email) {
                        if (email!.isEmpty) {
                          return "Email Address can't be empty";
                        } else if (!RegExp(
                                r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                            .hasMatch(email)) {
                          return 'Enter your correct email';
                        } else if (!email.contains("mes.ac.in")) {
                          return 'Enter your college email id';
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
                          labelText: "College Email Address",
                          labelStyle: TextStyle(color: Colors.white))),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: TextFormField(
                      controller: _name,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Name can't be empty";
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
                          labelText: "Name",
                          labelStyle: TextStyle(color: Colors.white))),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: TextFormField(
                    controller: _password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password can't be empty";
                      }
                      return null;
                    },
                    obscureText: !_passwordVisible,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
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
                      labelText: "Password",
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
                      } else if (_password.text != value) {
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
                      labelText: "Confirm Password",
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
                      "SignUp",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Loader.show(
                          context,
                          isAppbarOverlay: true,
                          isBottomBarOverlay: true,
                          progressIndicator: const CircularProgressIndicator(),
                          themeData: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.fromSwatch().copyWith(
                                  secondary: Colors.black38,
                                  primary: HexColor(primaryColorString))),
                          // overlayColor: const Color(0x99E8EAF6)
                        );
                        dynamic data = await Auth()
                            .register(_email.text, _name.text, _password.text);
                        Loader.hide();
                        if (data != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TeacherHome(),
                            ),
                          );
                          ToastService.showToast(
                              "Account successfully created", context,
                              isTop: false);
                        } else {
                          ToastService.showToast(
                              "Email already in use", context,
                              isTop: true);
                        }
                      }
                    },
                  ),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
