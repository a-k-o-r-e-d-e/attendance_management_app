// To parse this JSON data, do
//
//     final attendanceEventModel = attendanceEventModelFromJson(jsonString);

import 'dart:convert';

import 'join_class_event_model.dart';

AttendanceEventModel attendanceEventModelFromJson(String str) => AttendanceEventModel.fromJson(json.decode(str));

String attendanceEventModelToJson(AttendanceEventModel data) => json.encode(data.toJson());

class AttendanceEventModel {
  final List<AttendanceRecord>? attendanceRecords;

  AttendanceEventModel({
    this.attendanceRecords,
  });

  factory AttendanceEventModel.fromJson(Map<String, dynamic> json) => AttendanceEventModel(
    attendanceRecords: json["attendance_records"] == null ? [] : List<AttendanceRecord>.from(json["attendance_records"]!.map((x) => AttendanceRecord.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "attendance_records": attendanceRecords == null ? [] : List<dynamic>.from(attendanceRecords!.map((x) => x.toJson())),
  };
}

class AttendanceRecord {
  final String? id;
  final String? classInstanceId;
  final String? studentEnrollmentId;
  final bool? isPresent;
  final ClassInstance? classInstance;
  final StudentEnrollment? studentEnrollment;

  AttendanceRecord({
    this.id,
    this.classInstanceId,
    this.studentEnrollmentId,
    this.isPresent,
    this.classInstance,
    this.studentEnrollment,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) => AttendanceRecord(
    id: json["id"],
    classInstanceId: json["classInstanceId"],
    studentEnrollmentId: json["studentEnrollmentId"],
    isPresent: json["is_present"],
    classInstance: json["class_instance"] == null ? null : ClassInstance.fromJson(json["class_instance"]),
    studentEnrollment: json["student_enrollment"] == null ? null : StudentEnrollment.fromJson(json["student_enrollment"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "classInstanceId": classInstanceId,
    "studentEnrollmentId": studentEnrollmentId,
    "is_present": isPresent,
    "class_instance": classInstance?.toJson(),
    "student_enrollment": studentEnrollment?.toJson(),
  };
}

class StudentEnrollment {
  final String? id;
  final String? studentId;
  final String? courseId;
  final Student? student;

  StudentEnrollment({
    this.id,
    this.studentId,
    this.courseId,
    this.student,
  });

  factory StudentEnrollment.fromJson(Map<String, dynamic> json) => StudentEnrollment(
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
