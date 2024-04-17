// To parse this JSON data, do
//
//     final course = courseFromJson(jsonString);

import 'dart:convert';

import '../../../../shared/models/institution_model.dart';
import '../../../../shared/models/lecturer_model.dart';

List<Course> courseFromJson(String str) => List<Course>.from(json.decode(str).map((x) => Course.fromJson(x)));

String courseToJson(List<Course> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Course {
  final String? id;
  final String? title;
  final String? courseCode;
  final String? category;
  final int? unit;
  final String? session;
  final int? minAttendancePercentage;
  final String? description;
  final List<StudentsEnrollment>? studentsEnrollments;
  final Institution? institution;
  final Lecturer? lecturer;
  bool? isStudentEnrolled;

  Course({
    this.id,
    this.title,
    this.courseCode,
    this.category,
    this.unit,
    this.session,
    this.minAttendancePercentage,
    this.description,
    this.studentsEnrollments,
    this.institution,
    this.lecturer,
    this.isStudentEnrolled,
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
    studentsEnrollments: json["studentsEnrollments"] == null ? [] : List<StudentsEnrollment>.from(json["studentsEnrollments"]!.map((x) => StudentsEnrollment.fromJson(x))),
    institution: json["institution"] == null ? null : Institution.fromJson(json["institution"]),
    lecturer: json["lecturer"] == null ? null : Lecturer.fromJson(json["lecturer"]),
    isStudentEnrolled: json["is_student_enrolled"],
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
    "studentsEnrollments": studentsEnrollments == null ? [] : List<dynamic>.from(studentsEnrollments!.map((x) => x.toJson())),
    "institution": institution?.toJson(),
    "lecturer": lecturer?.toJson(),
    "is_student_enrolled": isStudentEnrolled,
  };
}

class StudentsEnrollment {
  final String? id;
  final String? studentId;
  final String? courseId;

  StudentsEnrollment({
    this.id,
    this.studentId,
    this.courseId,
  });

  factory StudentsEnrollment.fromJson(Map<String, dynamic> json) => StudentsEnrollment(
    id: json["id"],
    studentId: json["studentId"],
    courseId: json["courseId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "studentId": studentId,
    "courseId": courseId,
  };
}
