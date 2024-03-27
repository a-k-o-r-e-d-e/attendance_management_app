// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

import '../../../authentication/domain/models/institution_model.dart';

Course courseFromJson(String str) => Course.fromJson(json.decode(str));

String courseToJson(Course data) => json.encode(data.toJson());

class Course {
  final String? id;
  final String? title;
  final String? courseCode;
  final String? category;
  final int? unit;
  final String? session;
  final int? minAttendancePercentage;
  final String? description;
  final Institution? institution;
  final Lecturer? lecturer;

  Course({
    this.id,
    this.title,
    this.courseCode,
    this.category,
    this.unit,
    this.session,
    this.minAttendancePercentage,
    this.description,
    this.institution,
    this.lecturer,
  });

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    id: json["id"],
    title: json["title"],
    courseCode: json["course_code"],
    category: json["category"],
    unit: json["unit"],
    session: json["session"],
    minAttendancePercentage: json["min_attendance_percentage"],
    description: json["description"],
    institution: json["institution"] == null ? null : Institution.fromJson(json["institution"]),
    lecturer: json["lecturer"] == null ? null : Lecturer.fromJson(json["lecturer"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "course_code": courseCode,
    "category": category,
    "unit": unit,
    "session": session,
    "min_attendance_percentage": minAttendancePercentage,
    "description": description,
    "institution": institution?.toJson(),
    "lecturer": lecturer?.toJson(),
  };
}


class Lecturer {
  final String? id;
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? phoneNumber;
  final String? department;
  final String? faculty;
  final User? user;
  final Institution? institution;

  Lecturer({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.gender,
    this.phoneNumber,
    this.department,
    this.faculty,
    this.user,
    this.institution,
  });

  factory Lecturer.fromJson(Map<String, dynamic> json) => Lecturer(
    id: json["id"],
    title: json["title"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    gender: json["gender"],
    phoneNumber: json["phone_number"],
    department: json["department"],
    faculty: json["faculty"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    institution: json["institution"] == null ? null : Institution.fromJson(json["institution"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "first_name": firstName,
    "last_name": lastName,
    "gender": gender,
    "phone_number": phoneNumber,
    "department": department,
    "faculty": faculty,
    "user": user?.toJson(),
    "institution": institution?.toJson(),
  };
}

class User {
  final String? id;
  final String? username;
  final String? email;
  final List<String>? roles;

  User({
    this.id,
    this.username,
    this.email,
    this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
  };
}
