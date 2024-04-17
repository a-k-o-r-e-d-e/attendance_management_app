import '../../features/course/domain/models/course_model.dart';

class Base {
  final String? id;
  final String? title;
  final String? mode;
  final String? frequency;
  final String? startTime;
  final String? endTime;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? venue;
  final dynamic classLink;
  final Course? course;

  Base({
    this.id,
    this.title,
    this.mode,
    this.frequency,
    this.startTime,
    this.endTime,
    this.startDate,
    this.endDate,
    this.venue,
    this.classLink,
    this.course,
  });

  factory Base.fromJson(Map<String, dynamic> json) => Base(
        id: json["id"],
        title: json["title"],
        mode: json["mode"],
        frequency: json["frequency"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        venue: json["venue"],
        classLink: json["class_link"],
        course: json["course"] == null ? null : Course.fromJson(json["course"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "mode": mode,
        "frequency": frequency,
        "start_time": startTime,
        "end_time": endTime,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
        "venue": venue,
        "class_link": classLink,
        "course": course?.toJson(),
      };
}
