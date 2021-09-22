// ignore_for_file: file_names
import 'package:attendance_manager/Screens/profile.dart';
import 'package:attendance_manager/constants.dart';
import 'package:attendance_manager/widgets/chart.dart';
import 'package:attendance_manager/widgets/homeScreenCard.dart';
import 'package:attendance_manager/widgets/nameCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
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
        body: Container(
          padding: const EdgeInsets.all(10),
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            // color: Colors.grey,
            // color: Colors.red
          ),
          child: SingleChildScrollView(
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
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Student name",
                    style: TextStyle(
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
                                  builder: (context) => const ProfilePage()));
                        },
                        child: const HomeScreenCard(
                          title: "Profile",
                          // icon: 'assets/profile.png',
                          icon: Icons.person_outline_outlined,
                        ),
                      ),
                      const HomeScreenCard(
                          title: "Logout",
                          // icon: 'assets/logout.png',
                          icon: Icons.logout),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                Neumorphic(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                  style: NeumorphicStyle(
                      shape: NeumorphicShape.convex,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(10)),
                      depth: 3,
                      intensity: 0.7,
                      surfaceIntensity: 0.15,
                      shadowDarkColor: Colors.black87,
                      shadowDarkColorEmboss: Colors.black,
                      shadowLightColor: Colors.grey[700],
                      lightSource: LightSource.topLeft,
                      color: Theme.of(context).primaryColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Text(
                          "Attendance",
                          style:
                              Theme.of(context).textTheme.bodyText2!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: goldenColor,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 50),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width,
                        color: goldenColor,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          child: const AttendanceBarChart(
                            value: [
                              [0, "10"],
                              [1, "20"],
                              [2, "30"],
                              [3, "40"],
                              [4, "50"],
                            ],
                            interval: 25,
                            maxValue: 100,
                            data: ["Mon", "Tue", "Wed", "Thu", "Fri"],
                            expandValue: 1,
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Your subjects",
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
                for (int i = 0; i < 10; i++)
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: NameCard(
                      title: "Subject ${i + 1}",
                      subtitle: "Teacher name ${i + 1}",
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
    );
  }
}
