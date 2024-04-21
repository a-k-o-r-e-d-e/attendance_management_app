// To parse this JSON data, do
//
//     final joinClassModel = joinClassModelFromJson(jsonString);

import 'dart:convert';

import '../../../../shared/models/base_model.dart';
import '../../../../shared/models/institution_model.dart';
import '../../../../shared/models/user_model.dart';

JoinClassModel joinClassModelFromJson(String str) => JoinClassModel.fromJson(json.decode(str));

String joinClassModelToJson(JoinClassModel data) => json.encode(data.toJson());

class JoinClassModel {
  final String? id;
  final bool? currentlyTakingAttendance;
  final ClassInstance? classInstance;
  final List<PresentEnrolledStudent>? presentEnrolledStudents;
  final int? countOfEnrolledStudents;

  JoinClassModel({
    this.id,
    this.currentlyTakingAttendance,
    this.classInstance,
    this.presentEnrolledStudents,
    this.countOfEnrolledStudents,
  });

  factory JoinClassModel.fromJson(Map<String, dynamic> json) => JoinClassModel(
    id: json["id"],
    currentlyTakingAttendance: json["currently_taking_attendance"],
    classInstance: json["class_instance"] == null ? null : ClassInstance.fromJson(json["class_instance"]),
    presentEnrolledStudents: json["present_enrolled_students"] == null ? [] : List<PresentEnrolledStudent>.from(json["present_enrolled_students"]!.map((x) => PresentEnrolledStudent.fromJson(x))),
    countOfEnrolledStudents: json["count_of_enrolled_students"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "currently_taking_attendance": currentlyTakingAttendance,
    "class_instance": classInstance?.toJson(),
    "present_enrolled_students": presentEnrolledStudents == null ? [] : List<dynamic>.from(presentEnrolledStudents!.map((x) => x.toJson())),
    "count_of_enrolled_students": countOfEnrolledStudents,
  };
}

class ClassInstance {
  final String? id;
  final String? status;
  final DateTime? date;
  final String? baseId;
  final DateTime? startTime;
  final DateTime? endTime;
  final Base? base;

  ClassInstance({
    this.id,
    this.status,
    this.date,
    this.baseId,
    this.startTime,
    this.endTime,
    this.base,
  });

  factory ClassInstance.fromJson(Map<String, dynamic> json) => ClassInstance(
        id: json["id"],
        status: json["status"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        baseId: json["baseId"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        base: json["base"] == null ? null : Base.fromJson(json["base"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "baseId": baseId,
        "start_time": startTime?.toIso8601String(),
        "end_time": endTime?.toIso8601String(),
        "base": base?.toJson(),
      };
}

class Student {
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
  final String? matricNo;

  Student({
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
    this.matricNo,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
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
    matricNo: json["matric_no"],
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
    "matric_no": matricNo,
  };
}

class PresentEnrolledStudent {
  final String? id;
  final String? studentId;
  final String? courseId;
  final Student? student;

  PresentEnrolledStudent({
    this.id,
    this.studentId,
    this.courseId,
    this.student,
  });

  factory PresentEnrolledStudent.fromJson(Map<String, dynamic> json) => PresentEnrolledStudent(
    id: json["id"],
    studentId: json["studentId"],
    courseId: json["courseId"],
    student: json["student"] == null ? null : Student.fromJson(json["student"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "studentId": studentId,
    "courseId": courseId,
    "student": student?.toJson(),
  };
}
