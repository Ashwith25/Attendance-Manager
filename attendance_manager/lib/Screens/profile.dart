import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth/change_password.dart';
import '../constants.dart';
import '../services/auth_service.dart';
import '../services/get_location.dart';
import '../services/toast_service.dart';
import '../theme.dart';
import 'add_address.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  String? imagePath;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _role = TextEditingController();
  final TextEditingController _address = TextEditingController();

  Map user = {};

  fillData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user = jsonDecode(prefs.getString('user')!)["user"];
    var address = prefs.getString('address').toString();
    imagePath = prefs.getString('imagePath');
    _email.text = user['email'];
    _name.text = user['username'];
    _role.text = user['userType'].toString().toUpperCase();
    _address.text = address != "null" ? address : "Address not found";
    setState(() {});
  }

  changeUsername(username) async {
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
    var data = await Auth().changePassword({
      "username": username.trim(),
    }, user['id']);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user = jsonDecode(prefs.getString('user')!);
    user['user'] = data;
    Logger().i(user);
    prefs.setString('user', json.encode(user));
    Loader.hide();
    ToastService.showToast("Profile updated", context);
    isEditing = false;
    setState(() {});
    // Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    fillData();
    checkLocationPermission();
  }

  @override
  void dispose() {
    Loader.hide();
    super.dispose();
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
              color: Colors.white,
              icon:
                  !isEditing ? const Icon(Icons.edit) : const Icon(Icons.close),
              onPressed: () {
                isEditing = !isEditing;
                setState(() {});
              },
            )
          ],
          leading: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 10,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'Profile',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          foregroundColor: Theme.of(context).primaryColor,
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Neumorphic(
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: const NeumorphicBoxShape.circle(),
                      depth: 3,
                      intensity: 0.7,
                      surfaceIntensity: 0.15,
                      shadowDarkColor: Colors.black87,
                      shadowDarkColorEmboss: Colors.black,
                      shadowLightColor: Colors.grey[700],
                      lightSource: LightSource.topLeft,
                      color: Theme.of(context).primaryColor),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: imagePath != null
                        ? GestureDetector(
                            onTap: () async {
                              var pickedFile = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                                // preferredCameraDevice: CameraDevice.rear,
                                maxWidth: 1800,
                                maxHeight: 1800,
                              );
                              if (pickedFile != null) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString("imagePath", pickedFile.path);
                                fillData();
                              }
                            },
                            child: Image.file(
                              File(imagePath!),
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          )
                        : IconButton(
                            // padding: EdgeInsets.all(40),
                            iconSize: 90,
                            color: Colors.white,
                            icon: Icon(
                              Icons.person_add_alt_1_rounded,
                              color: goldenColor,
                            ),
                            onPressed: () async {
                              var pickedFile = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                                // preferredCameraDevice: CameraDevice.rear,
                                maxWidth: 1800,
                                maxHeight: 1800,
                              );
                              if (pickedFile != null) {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString("imagePath", pickedFile.path);
                                fillData();
                              }
                            },
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
                        padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
                        child: TextFormField(
                            readOnly: true,
                            controller: _email,
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: TextFormField(
                            readOnly: !isEditing,
                            controller: _name,
                            onTap: () {
                              if (!isEditing) {
                                ToastService.showToast(
                                    "Tap on the edit icon to make changes",
                                    context);
                              }
                            },
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: TextFormField(
                            readOnly: true,
                            controller: _role,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Role can't be empty";
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: const InputDecoration(
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                        child: TextFormField(
                            readOnly: true,
                            controller: _address,
                            onTap: () async {
                              // await checkLocationPermission();
                              // if (isEditing) {
                              //   var address = await MyLocation().getLocation();
                              //   setState(() {
                              //     _address.text = address;
                              //   });
                              // }

                              if (isEditing) {
                                Position position =
                                    await MyLocation().getLocation();

                                var address = await Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AddressScreen(position: position)));
                                setState(() {
                                  _address.text = address;
                                });
                              } else {
                                ToastService.showToast(
                                    "Tap on the edit icon to make changes",
                                    context);
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Address can't be empty";
                              }
                              return null;
                            },
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: const InputDecoration(
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
                          margin: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          child: Row(
                            children: const [
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
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20, 20, 10),
                              child: MaterialButton(
                                minWidth: 100,
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
                                    changeUsername(
                                      _name.text,
                                    );
                                  }
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
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20, 20, 10),
                              child: MaterialButton(
                                minWidth: 100,
                                height: 60,
                                color: goldenColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                child: const Text(
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
                                              const ChangePasswordPage()));
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

  Future checkLocationPermission() async {
    var permission = await Geolocator.checkPermission();
    print("Checking location permisiion = $permission");
    if (permission == LocationPermission.denied) {
      print("Location permission denied (not Forever)");
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        print("Permission is forever denied");
        // noLocationDialogBox(context);
        permission = await Geolocator.requestPermission();
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    }

    bool serviceEnabled;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("Location status = $serviceEnabled");
    if (!serviceEnabled) {
      print("Service Not enabled");
      noLocationDialogBox(context);
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }
  }

  noLocationDialogBox(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              "Location is disabled",
              textAlign: TextAlign.center,
            ),
            content: SizedBox(
                height: 80,
                child: Column(children: const [
                  Icon(
                    Icons.location_off_rounded,
                    color: Colors.red,
                    size: 30,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please turn on Location and try again",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ])),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("Okay"))
            ],
          );
        });
  }
}
