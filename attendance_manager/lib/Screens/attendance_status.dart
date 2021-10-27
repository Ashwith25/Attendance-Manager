import 'package:attendance_manager/constants.dart';
import 'package:attendance_manager/models/attendance_model.dart';
import 'package:attendance_manager/models/stud_att.dart';
import 'package:attendance_manager/services/attendance_service.dart';
import 'package:attendance_manager/widgets/attendance_status_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceStatus extends StatefulWidget {
  final String className;
  final String classId;
  final String studentId;
  const AttendanceStatus(
      {Key? key,
      required this.className,
      required this.classId,
      required this.studentId})
      : super(key: key);

  @override
  State<AttendanceStatus> createState() => _AttendanceStatusState();
}

class _AttendanceStatusState extends State<AttendanceStatus> {
  List<AttendanceModel> attendance = [];
  List<StudentAttendance> studentAttendance = [];
  bool loading = true;

  getAttendance() async {
    var data = await AttendanceService().getAttendance(widget.classId);
    if (data.isNotEmpty) {
      setState(() {
        attendance = data
            .map<AttendanceModel>((json) => AttendanceModel.fromJson(json))
            .toList();
        for (var element in attendance) {
          bool found = false;
          for (var i = 0; i < element.studentPresent!.length; i++) {
            if (element.studentPresent![i].student![0].id == widget.studentId) {
              found = true;
              break;
            }
          }
          if (found) {
            studentAttendance.add(StudentAttendance(element, true));
          } else {
            studentAttendance.add(StudentAttendance(element, false));
          }
        }
        studentAttendance.toSet().toList();
        loading = false;
      });
    } else {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAttendance();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? const Scaffold(
            // appBar: A,
            backgroundColor: Colors.blueGrey,
            body: Center(child: CircularProgressIndicator()),
          )
        : Scaffold(
            appBar: AppBar(
              centerTitle: false,
              // leadingWidth: 0,
              elevation: 10,
              leading: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.arrow_back_ios_outlined),
                onPressed: () {
                  ScaffoldMessenger.of(context).clearMaterialBanners();
                  Navigator.of(context).pop();
                },
              ),
              title: const Text(
                'Attendance',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              foregroundColor: Theme.of(context).primaryColor,
            ),
            body: Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: attendance.isEmpty
                  ? Center(
                      child: Text('No attendance found',
                          style: TextStyle(
                            color: goldenColor,
                            fontSize: 15,
                          )))
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              "Attendance for class ${widget.className}",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: goldenColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          for (int i = 0; i < studentAttendance.length; i++)
                            Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: AttendanceStatusCard(
                                  status: studentAttendance[i].isPresent
                                      ? 'Present'
                                      : 'Absent',
                                  date: DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(studentAttendance[i]
                                          .attendance
                                          .publishedAt!)),
                                ))
                        ],
                      ),
                    ),
            ),
          );
  }
}
