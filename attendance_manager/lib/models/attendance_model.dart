import 'package:attendance_manager/models/class_model.dart';

class AttendanceModel {
  String? id;
  String? publishedAt;
  List<Students>? studentPresent;
  String? createdAt;
  String? updatedAt;
  int? v;
  Class? classs;

  AttendanceModel(
      {this.publishedAt,
      this.studentPresent,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.classs,
      this.id});

  AttendanceModel.fromJson(Map<String, dynamic> json) {
    this.id = json["_id"];
    this.publishedAt = json["published_at"];
    this.studentPresent = json["studentPresent"] == null
        ? null
        : (json["studentPresent"] as List)
            .map((e) => Students.fromJson(e))
            .toList();
    this.createdAt = json["createdAt"];
    this.updatedAt = json["updatedAt"];
    this.v = json["__v"];
    this.classs = json["class"] == null ? null : Class.fromJson(json["class"]);
    this.id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["_id"] = this.id;
    data["published_at"] = this.publishedAt;
    if (this.studentPresent != null)
      data["studentPresent"] =
          this.studentPresent?.map((e) => e.toJson()).toList();
    data["createdAt"] = this.createdAt;
    data["updatedAt"] = this.updatedAt;
    data["__v"] = this.v;
    if (this.classs != null) data["class"] = this.classs?.toJson();
    data["id"] = this.id;
    return data;
  }
}

class Class {
  String? id;
  String? publishedAt;
  String? subject;
  String? className;
  List<dynamic>? students;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? teacher;

  Class(
      {this.publishedAt,
      this.subject,
      this.className,
      this.students,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.teacher,
      this.id});

  Class.fromJson(Map<String, dynamic> json) {
    this.id = json["_id"];
    this.publishedAt = json["published_at"];
    this.subject = json["subject"];
    this.className = json["className"];
    this.students = json["students"] ?? [];
    this.createdAt = json["createdAt"];
    this.updatedAt = json["updatedAt"];
    this.v = json["__v"];
    this.teacher = json["teacher"];
    this.id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["_id"] = this.id;
    data["published_at"] = this.publishedAt;
    data["subject"] = this.subject;
    data["className"] = this.className;
    if (this.students != null) data["students"] = this.students;
    data["createdAt"] = this.createdAt;
    data["updatedAt"] = this.updatedAt;
    data["__v"] = this.v;
    data["teacher"] = this.teacher;
    data["id"] = this.id;
    return data;
  }
}

class StudentPresent {
  List<Student>? student;
  String? id;
  int? v;

  StudentPresent({this.student, this.id, this.v});

  StudentPresent.fromJson(Map<String, dynamic> json) {
    this.student = json["student"] == null
        ? null
        : (json["student"] as List).map((e) => Student.fromJson(e)).toList();
    this.id = json["_id"];
    this.v = json["__v"];
    this.id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.student != null)
      data["student"] = this.student?.map((e) => e.toJson()).toList();
    data["_id"] = this.id;
    data["__v"] = this.v;
    data["id"] = this.id;
    return data;
  }
}

class Student {
  bool? confirmed;
  bool? blocked;
  String? userType;
  String? id;
  String? email;
  String? username;
  String? provider;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? role;

  Student(
      {this.confirmed,
      this.blocked,
      this.userType,
      this.email,
      this.username,
      this.provider,
      this.createdAt,
      this.updatedAt,
      this.v,
      this.role,
      this.id});

  Student.fromJson(Map<String, dynamic> json) {
    this.confirmed = json["confirmed"];
    this.blocked = json["blocked"];
    this.userType = json["userType"];
    this.id = json["_id"];
    this.email = json["email"];
    this.username = json["username"];
    this.provider = json["provider"];
    this.createdAt = json["createdAt"];
    this.updatedAt = json["updatedAt"];
    this.v = json["__v"];
    this.role = json["role"];
    this.id = json["id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["confirmed"] = this.confirmed;
    data["blocked"] = this.blocked;
    data["userType"] = this.userType;
    data["_id"] = this.id;
    data["email"] = this.email;
    data["username"] = this.username;
    data["provider"] = this.provider;
    data["createdAt"] = this.createdAt;
    data["updatedAt"] = this.updatedAt;
    data["__v"] = this.v;
    data["role"] = this.role;
    data["id"] = this.id;
    return data;
  }
}
