import 'package:attendance_manager/widgets/homeScreenCard.dart';
import 'package:attendance_manager/widgets/teacherCard.dart';
import 'package:flutter/material.dart';

class TeacherHome extends StatefulWidget {
  const TeacherHome({Key? key}) : super(key: key);

  @override
  _TeacherHomeState createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 10,
          leading: Container(
            width: 0,
          ),
          title: Text(
            'Attendance Manager',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          foregroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            // color: Colors.red
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome,",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "Teacher name",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      HomeScreenCard(
                        title: "Add class",
                        icon: 'assets/add.png',
                      ),
                      HomeScreenCard(
                        title: "Profile",
                        icon: 'assets/profile.png',
                      ),
                      HomeScreenCard(
                        title: "Logout",
                        icon: 'assets/logout.png',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: size.height * .6,
                  width: size.width,
                  child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListView.builder(
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          itemCount: 10,
                          itemBuilder: (context, index) => TeacherNameCard(
                                className: "Class ${index + 1}",
                                studentCount: index + 10,
                              ))),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
