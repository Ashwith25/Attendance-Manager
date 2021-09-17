import 'package:attendance_manager/constants.dart';
import 'package:attendance_manager/profile.dart';
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
          centerTitle: false,
          leadingWidth: 0,
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
            // color: Colors.grey,
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
                    color: goldenColor,
                  ),
                ),
                Text(
                  "Teacher name",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: goldenColor,
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
                        // icon: 'assets/add.png',
                        icon: Icons.add,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfilePage()));
                        },
                        child: HomeScreenCard(
                          title: "Profile",
                          // icon: 'assets/profile.png',
                          icon: Icons.person_outline_outlined,
                        ),
                      ),
                      HomeScreenCard(
                          title: "Logout",
                          // icon: 'assets/logout.png',
                          icon: Icons.logout),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                for (int i = 0; i < 10; i++)
                  Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: TeacherNameCard(
                      className: "Class ${i + 1}",
                      studentCount: i + 10,
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
