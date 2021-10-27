// ignore_for_file: file_names

import 'package:attendance_manager/constants.dart';
import 'package:attendance_manager/models/class_model.dart';
import 'package:attendance_manager/services/attendance_service.dart';
import 'package:attendance_manager/services/toast_service.dart';
import 'package:attendance_manager/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:logger/logger.dart';

class MarkAttendancePage extends StatefulWidget {
  final List<Students> students;
  final String classId;
  const MarkAttendancePage(
      {Key? key, required this.students, required this.classId})
      : super(key: key);

  @override
  _MarkAttendancePageState createState() => _MarkAttendancePageState();
}

class _MarkAttendancePageState extends State<MarkAttendancePage> {
  List student = [];
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < widget.students.length; i++) {
      student.add(CheckBoxForStudent(
          studentid: widget.students[i].student![0].id!,
          email: widget.students[i].student![0].email,
          name: widget.students[i].student![0].username,
          selected: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            color: Colors.white,
            icon: const Icon(Icons.arrow_back_ios_outlined),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).primaryColor,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for (int i = 0; i < student.length; i++)
                        Padding(
                          padding: const EdgeInsets.only(left: 14),
                          child: Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(top: 10, right: 5),
                                width: 5,
                                height: 75,
                                // color: Theme.of(context).accentColor,
                                color: goldenColor,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                        padding:
                                            const EdgeInsets.only(left: 25),
                                        child: Checkbox(
                                            activeColor: goldenColor,
                                            checkColor:
                                                Theme.of(context).primaryColor,
                                            fillColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) {
                                              if (states.contains(
                                                  MaterialState.selected)) {
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
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  color: goldenColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    "Mark attendance",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  onPressed: () async {
                    List studentsPresent = [];
                    student.forEach((element) {
                      if (element.selected) {
                        // Logger().i(element);
                        studentsPresent.add({
                          "student": [
                            {"id": element.studentid, "_id": element.studentid}
                          ]
                        });
                      }
                    });
                    Map body = {
                      "class": widget.classId,
                      "studentPresent": studentsPresent
                    };
                    Logger().i(body);
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
                    dynamic data =
                        await AttendanceService().markAttendance(body);
                    Loader.hide();
                    if (data != null) {
                      Navigator.of(context).pop();
                      ToastService.showToast("Attendance recorded", context,
                          isTop: false);
                    } else {
                      ToastService.showToast("Something went wrong", context,
                          isTop: false);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CheckBoxForStudent {
  String studentid;
  String? email;
  String? name;
  bool selected;

  CheckBoxForStudent({
    required this.studentid,
    this.email,
    this.name,
    required this.selected,
  });
}
