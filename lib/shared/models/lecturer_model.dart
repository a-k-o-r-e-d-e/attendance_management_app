import 'package:attendance_management_app/shared/models/user_model.dart';

import 'institution_model.dart';

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
    institution: json["institution"] == null
        ? null
        : Institution.fromJson(json["institution"]),
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
