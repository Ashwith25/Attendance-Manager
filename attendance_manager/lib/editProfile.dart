import 'package:attendance_manager/Home/teacherHome.dart';
import 'package:attendance_manager/auth/change_password.dart';
import 'package:attendance_manager/auth/signup.dart';
import 'package:attendance_manager/profile.dart';
import 'package:attendance_manager/widgets/homeScreenCard.dart';
import 'package:flutter/material.dart';
import 'package:attendance_manager/constants.dart';
import 'package:attendance_manager/theme.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            )
          ],
          elevation: 10,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          foregroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: IconButton(
                      // padding: EdgeInsets.all(40),
                      iconSize: 90,
                      color: Colors.white,
                      icon: Icon(
                        Icons.person_add_alt_1_rounded,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                // Neumorphic(
                //   margin: EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                //   style: NeumorphicStyle(border:  ),

                // HomeScreenCard(
                //   icon: IconButton(
                //     icon: Icon(Icons.person_add_alt_1_rounded),
                //     onPressed: () {},
                //   ),
                // ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 50, 20, 10),
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email Address can't be empty";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                helperStyle: TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                labelText: "College Email Address",
                                labelStyle: TextStyle(color: Colors.white))),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Name can't be empty";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                helperStyle: TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                labelText: "Name",
                                labelStyle: TextStyle(color: Colors.white))),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Role can't be empty";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                helperStyle: TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                labelText: "Role",
                                labelStyle: TextStyle(color: Colors.white))),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Address can't be empty";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                helperStyle: TextStyle(color: Colors.white),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                border: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                labelText: "Address",
                                labelStyle: TextStyle(color: Colors.white))),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.red,
                              size: 10,
                            ),
                            Text(
                              "Tap on the address to update",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 10,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "Update",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate())
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChangePasswordPage()));
                          },
                        ),
                      ),
                      //     Spacer(),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      //       children: [Text("Version 1.0.1")],
                      //     )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
