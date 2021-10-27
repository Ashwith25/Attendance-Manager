import 'package:attendance_manager/Home/studentHome.dart';
import 'package:attendance_manager/Home/teacherHome.dart';
import 'package:attendance_manager/auth/signup.dart';
import 'package:attendance_manager/services/auth_service.dart';
import 'package:attendance_manager/services/toast_service.dart';
import 'package:attendance_manager/theme.dart';
import 'package:flutter/material.dart';
import 'package:attendance_manager/constants.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  void dispose() {
    Loader.hide();
    super.dispose();
  }

  final textSelectionControl = TextSelectionControls;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          leading: Container(),
        ),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: goldenColor,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                    child: TextFormField(
                        controller: _email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email Address can't be empty";
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        // enableInteractiveSelection: false,
                        // showCursor: true,
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
                        // enableInteractiveSelection: true,
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
                            labelStyle: const TextStyle(color: Colors.white))),
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
                        "Login",
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
                            progressIndicator:
                                const CircularProgressIndicator(),
                            themeData: Theme.of(context).copyWith(
                                colorScheme: ColorScheme.fromSwatch().copyWith(
                                    secondary: Colors.black38,
                                    primary: HexColor(primaryColorString))),
                            // overlayColor: const Color(0x99E8EAF6)
                          );
                          dynamic data =
                              await Auth().login(_email.text, _password.text);
                          Loader.hide();
                          if (data != null) {
                            var userType = data["user"]['userType'];
                            if (userType.toString().toLowerCase() ==
                                'teacher') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TeacherHome(),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const StudentHome(),
                                ),
                              );
                            }
                          } else {
                            ToastService.showToast(
                                "Please enter valid credentials", context,
                                isTop: true);
                          }
                        }
                      },
                    ),
                  ),
                  // SizedBox(
                  //   height: 250,
                  // ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupPage()));
                        },
                        child: const Text(
                          "SignUp",
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
            )),
      ),
    );
  }
}
