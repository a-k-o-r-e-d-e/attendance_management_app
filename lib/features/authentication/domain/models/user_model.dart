// To parse this JSON data, do
//
//     final userAccount = userAccountFromJson(jsonString);

import 'dart:convert';

UserAccount userAccountFromJson(String str) => UserAccount.fromJson(json.decode(str));

String userAccountToJson(UserAccount data) => json.encode(data.toJson());

class UserAccount {
  final String? accessToken;
  final Profile? profile;

  UserAccount({
    this.accessToken,
    this.profile,
  });

  factory UserAccount.fromJson(Map<String, dynamic> json) => UserAccount(
    accessToken: json["access_token"],
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "profile": profile?.toJson(),
  };
}

class Profile {
  final String? id;
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? phoneNumber;
  final String? department;
  final String? faculty;
  final String? matricNo;
  final User? user;
  final Institution? institution;

  Profile({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.gender,
    this.phoneNumber,
    this.department,
    this.faculty,
    this.matricNo,
    this.user,
    this.institution,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    id: json["id"],
    title: json["title"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    gender: json["gender"],
    phoneNumber: json["phone_number"],
    department: json["department"],
    faculty: json["faculty"],
    matricNo: json["matric_no"],
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
    "matric_no": matricNo,
    "user": user?.toJson(),
    "institution": institution?.toJson(),
  };
}

class Institution {
  final String? id;
  final String? name;
  final String? abbreviation;
  final String? type;
  final String? city;
  final String? state;
  final String? country;

  Institution({
    this.id,
    this.name,
    this.abbreviation,
    this.type,
    this.city,
    this.state,
    this.country,
  });

  factory Institution.fromJson(Map<String, dynamic> json) => Institution(
    id: json["id"],
    name: json["name"],
    abbreviation: json["abbreviation"],
    type: json["type"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "abbreviation": abbreviation,
    "type": type,
    "city": city,
    "state": state,
    "country": country,
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
