// To parse this JSON data, do
//
//     final upcomingClassModel = upcomingClassModelFromJson(jsonString);

import 'dart:convert';

import '../../../../shared/models/base_model.dart';

List<UpcomingClassModel> upcomingClassModelFromJson(dynamic data) =>
    List<UpcomingClassModel>.from(
        data.map((x) => UpcomingClassModel.fromJson(x)));

String upcomingClassModelToJson(List<UpcomingClassModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpcomingClassModel {
  final String? id;
  final String? status;
  final DateTime? date;
  final String? baseId;
  final DateTime? startTime;
  final DateTime? endTime;
  final Base? base;

  UpcomingClassModel({
    this.id,
    this.status,
    this.date,
    this.baseId,
    this.startTime,
    this.endTime,
    this.base,
  });

  factory UpcomingClassModel.fromJson(Map<String, dynamic> json) =>
      UpcomingClassModel(
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

