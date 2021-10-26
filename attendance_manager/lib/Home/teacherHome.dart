// ignore_for_file: file_names

import 'dart:convert';

import 'package:attendance_manager/Screens/addNewClass.dart';
import 'package:attendance_manager/Screens/eachClass.dart';
import 'package:attendance_manager/Screens/profile.dart';
import 'package:attendance_manager/auth/login.dart';
import 'package:attendance_manager/constants.dart';
import 'package:attendance_manager/models/class_model.dart';
import 'package:attendance_manager/services/class_service.dart';
import 'package:attendance_manager/theme.dart';
import 'package:attendance_manager/widgets/homeScreenCard.dart';
import 'package:attendance_manager/widgets/nameCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({Key? key}) : super(key: key);

  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  late bool loading;
  late String name;

  MaterialBanner materialBanner(BuildContext context) {
    return MaterialBanner(
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginPage()));
                ScaffoldMessenger.of(context).clearMaterialBanners();
              },
              child: Text(
                "Yes",
                style: TextStyle(color: Theme.of(context).errorColor),
              )),
          TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text("No")),
        ]);
  }

  List<ClassModel> classes = [];

  getClasses() async {
    List data = await ClassService().getClass();
    // Logger().i(data);
    if (data.isNotEmpty) {
      setState(() {
        classes =
            data.map<ClassModel>((json) => ClassModel.fromJson(json)).toList();
        classes.removeWhere(
            (element) => element.teacher!.id != user["user"]["_id"]);
        classes.addAll(
            data.map<ClassModel>((json) => ClassModel.fromJson(json)).toList());
        loading = false;
        Loader.hide();
        // print(classes.length);
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  Map user = {};

  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = jsonDecode(prefs.getString('user')!);
      name = user['user']['username'];
      // loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loading = true;
    name = "Name";
    getName();
    getClasses();
  }

  @override
  void dispose() {
    Loader.hide();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: loading
          ? const Scaffold(
              // appBar: A,
              backgroundColor: Colors.blueGrey,
              body: Center(child: CircularProgressIndicator()),
            )
          : Scaffold(
              appBar: AppBar(
                centerTitle: false,
                leadingWidth: 0,
                elevation: 10,
                leading: Container(
                  width: 0,
                ),
                title: const Text(
                  'Attendance Manager',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                foregroundColor: Theme.of(context).primaryColor,
              ),
              body: RefreshIndicator(
                backgroundColor: Colors.white,
                onRefresh: () async {
                  setState(() {
                    // loading = true;
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
                  });
                  await getClasses();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: size.height,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    // color: Colors.grey,
                    // color: Colors.red
                  ),
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Welcome,",
                            style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: goldenColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            name,
                            style: const TextStyle(
                              letterSpacing: 1,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AddNewClassPage()));
                                },
                                child: const HomeScreenCard(
                                  title: "Add Class",
                                  // icon: 'assets/add.png',
                                  icon: Icons.add,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfilePage()));
                                },
                                child: const HomeScreenCard(
                                  title: "Profile",
                                  // icon: 'assets/profile.png',
                                  icon: Icons.person_outline_outlined,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context)
                                      .showMaterialBanner(
                                          materialBanner(context));
                                },
                                child: const HomeScreenCard(
                                    title: "Logout",
                                    // icon: 'assets/logout.png',
                                    icon: Icons.logout),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Your classes",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: goldenColor,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        for (int i = 0; i < classes.length; i++)
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EachClass(
                                        className: classes[i].className!,
                                        classId: classes[i].id!,
                                        teacherId: user["user"]["_id"]!,
                                      )));
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: NameCard(
                                title: classes[i].className!,
                                subtitle:
                                    "${classes[i].students!.length} students",
                              ),
                            ),
                          )
                        // Container(
                        //     height: size.height * .7,
                        //     width: size.width,
                        //     child: ListView.builder(
                        //         padding:
                        //             EdgeInsets.only(left: 10, right: 10, bottom: 10),
                        //         itemCount: 10,
                        //         itemBuilder: (context, index) => TeacherNameCard(
                        //               className: "Class ${index + 1}",
                        //               studentCount: index + 10,
                        //             )))
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
