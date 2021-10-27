import 'package:attendance_manager/models/attendance_model.dart';

class StudentAttendance {
  final AttendanceModel attendance;
  final bool isPresent;

  StudentAttendance(this.attendance, this.isPresent);
}
