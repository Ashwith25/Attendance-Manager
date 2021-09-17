import 'package:attendance_manager/auth/login.dart';
import 'package:attendance_manager/constants.dart';
import 'package:attendance_manager/theme.dart';
import 'package:attendance_manager/welcome.dart';
import 'package:flutter/material.dart';

class AddNewClassPage extends StatefulWidget {
  AddNewClassPage({Key? key}) : super(key: key);

  @override
  _AddNewClassPageState createState() => _AddNewClassPageState();
}

class _AddNewClassPageState extends State<AddNewClassPage> {
  TextEditingController _password = TextEditingController();
  TextEditingController _confirm = TextEditingController();

  bool _passwordVisible = false;
  var _currentSelectedValue1;
  var _currentSelectedValue2;
  var _currentSelectedValue3;

  var _year = ["FE", "SE", "TE", "BE"];
  var _branch = ["COMPS", "IT", "EXTC", "ETRX", "AUTOMOBILE", "MECHANICAL"];
  var _subject = ["Artifical Intelligence", "Enterprise Network design", "CSL"];

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _passwordVisible = false;
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          centerTitle: false,
          elevation: 10,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Add new class',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
                  child: FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                            helperStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: "Select Year",
                            labelStyle: TextStyle(color: Colors.white)),
                        isEmpty: _currentSelectedValue1 == '',
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            dropdownColor: Theme.of(context).primaryColor,
                            value: _currentSelectedValue1,
                            isDense: true,
                            onChanged: (newValue) {
                              setState(() {
                                _currentSelectedValue1 = newValue;
                                state.didChange(newValue);
                              });
                            },
                            // validator: (value) => value == null
                            //     ? 'Please fill in your year'
                            //     : null,
                            items: _year.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.white),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  // child: TextFormField(
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return "Email Address can't be empty";
                  //       }
                  //       return null;
                  //     },
                  //     style: TextStyle(color: Colors.white),
                  //     decoration: InputDecoration(
                  //         helperStyle: TextStyle(color: Colors.white),
                  //         focusedBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.white)),
                  //         enabledBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.white)),
                  //         border: OutlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.white)),
                  //         labelText: "College Email Address",
                  //         labelStyle: TextStyle(color: Colors.white))),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                          decoration: InputDecoration(
                              helperStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: "Select Branch",
                              // hintText: "Select Branch",
                              // hintStyle: TextStyle(color: Colors.white),
                              labelStyle: TextStyle(color: Colors.white)),
                          isEmpty: _currentSelectedValue2 == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: Theme.of(context).primaryColor,
                              value: _currentSelectedValue2,
                              isDense: true,
                              onChanged: (newValue) {
                                setState(() {
                                  _currentSelectedValue2 = newValue;
                                  state.didChange(newValue);
                                });
                              },
                              items: _branch.map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                            ),
                          ));
                    },
                  ),
                  // child: TextFormField(
                  //     validator: (value) {
                  //       if (value!.isEmpty) {
                  //         return "Name can't be empty";
                  //       }
                  //       return null;
                  //     },
                  //     style: TextStyle(color: Colors.white),
                  //     decoration: InputDecoration(
                  //         helperStyle: TextStyle(color: Colors.white),
                  //         focusedBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.white)),
                  //         enabledBorder: OutlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.white)),
                  //         border: OutlineInputBorder(
                  //             borderSide: BorderSide(color: Colors.white)),
                  //         labelText: "Name",
                  //         labelStyle: TextStyle(color: Colors.white))),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                          decoration: InputDecoration(
                              helperStyle: TextStyle(color: Colors.white),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              labelText: "Select Subject",
                              labelStyle: TextStyle(color: Colors.white)),
                          isEmpty: _currentSelectedValue3 == '',
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: Theme.of(context).primaryColor,
                              value: _currentSelectedValue3,
                              isDense: true,
                              onChanged: (newValue) {
                                setState(() {
                                  _currentSelectedValue3 = newValue;
                                  state.didChange(newValue);
                                });
                              },
                              items: _subject.map((String value) {
                                return DropdownMenuItem(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                            ),
                          ));
                    },
                  ),
                  // child: TextFormField(
                  //   controller: _password,
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return "Password can't be empty";
                  //     } else if (value.trim().length < 8) {
                  //       return 'Password must be atleast 8 charcters long';
                  //     }
                  //     return null;
                  //   },
                  //   obscureText: !_passwordVisible,
                  //   style: TextStyle(color: Colors.white),
                  //   cursorColor: Colors.white,
                  //   decoration: InputDecoration(
                  //     suffixIcon: IconButton(
                  //       icon: Icon(
                  //         _passwordVisible
                  //             ? Icons.visibility
                  //             : Icons.visibility_off,
                  //         color: Colors.white,
                  //       ),
                  //       onPressed: () {
                  //         setState(() {
                  //           _passwordVisible = !_passwordVisible;
                  //         });
                  //       },
                  //     ),
                  //     helperStyle: TextStyle(color: Colors.white),
                  //     focusedBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.white)),
                  //     enabledBorder: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.white)),
                  //     border: OutlineInputBorder(
                  //         borderSide: BorderSide(color: Colors.white)),
                  //     labelText: "Password",
                  //     labelStyle: TextStyle(color: Colors.white),
                  //   ),
                  // ),
                ),
                // Container(
                //   padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                //   child: TextFormField(
                //     controller: _confirm,
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return "Confirm Password can't be empty";
                //       } else if (_password.text != value) {
                //         return 'Passwords do not match';
                //       }
                //       return null;
                //     },
                //     obscureText: !_passwordVisible,
                //     style: TextStyle(color: Colors.white),
                //     cursorColor: Colors.white,
                //     decoration: InputDecoration(
                //       suffixIcon: IconButton(
                //         icon: Icon(
                //           _passwordVisible
                //               ? Icons.visibility
                //               : Icons.visibility_off,
                //           color: Colors.white,
                //         ),
                //         onPressed: () {
                //           setState(() {
                //             _passwordVisible = !_passwordVisible;
                //           });
                //         },
                //       ),
                //       helperStyle: TextStyle(color: Colors.white),
                //       focusedBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.white)),
                //       enabledBorder: OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.white)),
                //       border: OutlineInputBorder(
                //           borderSide: BorderSide(color: Colors.white)),
                //       labelText: "Confirm Password",
                //       labelStyle: TextStyle(color: Colors.white),
                //     ),
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "Add class",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate())
                        Navigator.of(context).pop();
                    },
                  ),
                ),
                // Spacer(),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [
                //     Text(
                //       "Already have an account? ",
                //       style: TextStyle(color: Colors.white, fontSize: 12),
                //     ),
                //     GestureDetector(
                //       onTap: () {
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => LoginPage()));
                //       },
                //       child: Text(
                //         "Login",
                //         style: TextStyle(
                //           decoration: TextDecoration.underline,
                //           fontWeight: FontWeight.bold,
                //           fontSize: 12,
                //           color: Colors.white,
                //         ),
                //       ),
                //     )
                //   ],
                // ),
                // SizedBox(
                //   height: 20,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
