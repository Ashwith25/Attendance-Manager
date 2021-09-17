import 'package:attendance_manager/auth/change_password.dart';
import 'package:flutter/material.dart';
import 'package:attendance_manager/constants.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _role = TextEditingController();
  TextEditingController _address = TextEditingController();

  @override
  void initState() {
    super.initState();
    _email.text = "defaultEmail@student.mes.ac.in";
    _name.text = "Teacher Name";
    _role.text = "TEACHER";
    _address.text = "Ghansoli, Maharashtra";
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          centerTitle: false,
          actions: [
            IconButton(
              icon: !isEditing ? Icon(Icons.edit) : Icon(Icons.close),
              onPressed: () {
                isEditing = !isEditing;
                setState(() {});
              },
            )
          ],
          elevation: 10,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(
            'Profile',
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
                SizedBox(
                  height: 50,
                ),
                Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.concave,
                      boxShape: NeumorphicBoxShape.circle(),
                      depth: 2,
                      lightSource: LightSource.topLeft,
                      color: Theme.of(context).primaryColor),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: IconButton(
                      // padding: EdgeInsets.all(40),
                      iconSize: 90,
                      color: Colors.white,
                      icon: Icon(
                        Icons.person_add_alt_1_rounded,
                        color: goldenColor,
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
                            readOnly: !isEditing,
                            controller: _email,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email Address can't be empty";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
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
                        //   child: TextFormField(
                        //       validator: (value) {
                        //         if (value!.isEmpty) {
                        //           return "Email Address can't be empty";
                        //         }
                        //         return null;
                        //       },

                        //       style: TextStyle(color: Colors.white),
                        //       decoration: InputDecoration(
                        //           helperStyle: TextStyle(color: Colors.white),
                        //           focusedBorder: OutlineInputBorder(
                        //               borderSide:
                        //                   BorderSide(color: Colors.white)),
                        //           enabledBorder: OutlineInputBorder(
                        //               borderSide:
                        //                   BorderSide(color: Colors.white)),
                        //           border: OutlineInputBorder(
                        //               borderSide:
                        //                   BorderSide(color: Colors.white)),
                        //           labelText: "College Email Address",
                        //           labelStyle: TextStyle(color: Colors.white))),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: TextFormField(
                            readOnly: !isEditing,
                            controller: _name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Name can't be empty";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
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
                            readOnly: true,
                            controller: _role,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Role can't be empty";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
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
                            readOnly: true,
                            controller: _address,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Address can't be empty";
                              }
                              return null;
                            },
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
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
                      if (isEditing)
                        Container(
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: Colors.red,
                                size: 15,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Tap on the address to update",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      isEditing
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                              child: MaterialButton(
                                minWidth: 100,
                                height: 60,
                                color: goldenColor,
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
                                    print("pass");
                                  //   Navigator.push(
                                  //       context,
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               ChangePasswordPage()));
                                },
                              ),
                            )
                          : Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                              child: MaterialButton(
                                minWidth: 100,
                                height: 60,
                                color: goldenColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  "Change Password ?",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ChangePasswordPage()));
                                },
                              ),
                            ),

                      // Spacer(),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      //       children: [Text("Version 1.0.1")],
                      // )
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
