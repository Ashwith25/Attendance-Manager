
class ClassModel {
    String? id;
    String? className;
    String? subject;
    String? publishedAt;
    List<Students>? students;
    String? createdAt;
    String? updatedAt;
    int? v;
    Teacher? teacher;

    ClassModel({this.className, this.subject, this.publishedAt, this.students, this.createdAt, this.updatedAt, this.v, this.teacher, this.id});

    ClassModel.fromJson(Map<String, dynamic> json) {
        this.id = json["_id"];
        this.className = json["className"];
        this.subject = json["subject"];
        this.publishedAt = json["published_at"];
        this.students = json["students"]==null ? null : (json["students"] as List).map((e)=>Students.fromJson(e)).toList();
        this.createdAt = json["createdAt"];
        this.updatedAt = json["updatedAt"];
        this.v = json["__v"];
        this.teacher = json["teacher"] == null ? null : Teacher.fromJson(json["teacher"]);
        this.id = json["id"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data["_id"] = this.id;
        data["className"] = this.className;
        data["subject"] = this.subject;
        data["published_at"] = this.publishedAt;
        if(this.students != null)
            data["students"] = this.students?.map((e)=>e.toJson()).toList();
        data["createdAt"] = this.createdAt;
        data["updatedAt"] = this.updatedAt;
        data["__v"] = this.v;
        if(this.teacher != null)
            data["teacher"] = this.teacher?.toJson();
        data["id"] = this.id;
        return data;
    }
}

class Teacher {
    bool? confirmed;
    bool? blocked;
    String? userType;
    String? id;
    String? username;
    String? email;
    String? provider;
    String? createdAt;
    String? updatedAt;
    int? v;
    String? role;

    Teacher({this.confirmed, this.blocked, this.userType, this.username, this.email, this.provider, this.createdAt, this.updatedAt, this.v, this.role, this.id});

    Teacher.fromJson(Map<String, dynamic> json) {
        this.confirmed = json["confirmed"];
        this.blocked = json["blocked"];
        this.userType = json["userType"];
        this.id = json["_id"];
        this.username = json["username"];
        this.email = json["email"];
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
        data["username"] = this.username;
        data["email"] = this.email;
        data["provider"] = this.provider;
        data["createdAt"] = this.createdAt;
        data["updatedAt"] = this.updatedAt;
        data["__v"] = this.v;
        data["role"] = this.role;
        data["id"] = this.id;
        return data;
    }
}

class Students {
    List<Student>? student;
    String? id;
    int? v;

    Students({this.student, this.id, this.v});

    Students.fromJson(Map<String, dynamic> json) {
        this.student = json["student"]==null ? null : (json["student"] as List).map((e)=>Student.fromJson(e)).toList();
        this.id = json["_id"];
        this.v = json["__v"];
        this.id = json["id"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if(this.student != null)
            data["student"] = this.student?.map((e)=>e.toJson()).toList();
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

    Student({this.confirmed, this.blocked, this.userType, this.email, this.username, this.provider, this.createdAt, this.updatedAt, this.v, this.role, this.id});

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