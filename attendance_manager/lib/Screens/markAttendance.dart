// ignore_for_file: file_names

import 'package:attendance_manager/constants.dart';
import 'package:flutter/material.dart';

class MarkAttendancePage extends StatefulWidget {
  const MarkAttendancePage({Key? key}) : super(key: key);

  @override
  _MarkAttendancePageState createState() => _MarkAttendancePageState();
}

class _MarkAttendancePageState extends State<MarkAttendancePage> {
  List student = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      student.add(CheckBoxForStudent(
          email: "student@gmail.com",
          name: "Student${i + 1}",
          selected: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 10,
          title: const Text(
            'Mark Attendance',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          foregroundColor: Theme.of(context).primaryColor,
        ),
        body: Container(
          color: Theme.of(context).primaryColor,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < student.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 10, right: 5),
                          width: 5,
                          height: 75,
                          // color: Theme.of(context).accentColor,
                          color: const Color(0xFFF5C35A),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 75,
                          width: MediaQuery.of(context).size.width * 0.9,
                          // width: double.infinity,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  stops: const [
                                0.3,
                                1
                              ],
                                  colors: [
                                Colors.black38,
                                // Color.fromRGBO(0, 0, 0, 0.0)
                                Theme.of(context).primaryColor
                                // Colors.white
                              ])),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      student[i].name,
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: goldenColor,
                                      ),
                                    ),
                                    Text(
                                      student[i].email,
                                      // style:
                                      style: const TextStyle(
                                        letterSpacing: 1,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w100,
                                        // fontWeight: FontWeight.,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Checkbox(
                                      activeColor: goldenColor,
                                      checkColor:
                                          Theme.of(context).primaryColor,
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return goldenColor; // the color when checkbox is selected;
                                        }
                                        return Colors
                                            .white; //the color when checkbox is unselected;
                                      }),
                                      value: student[i].selected,
                                      onChanged: (bool? value) {
                                        student[i].selected =
                                            !student[i].selected;
                                        setState(() {});
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
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

class CheckBoxForStudent {
  String? email;
  String? name;
  bool? selected;

  CheckBoxForStudent({
    this.email,
    this.name,
    this.selected,
  });
}
