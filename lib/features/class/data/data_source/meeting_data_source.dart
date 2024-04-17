import 'dart:ui';
import 'package:attendance_management_app/features/class/domain/models/meeting_model.dart';

abstract class MeetingDataSourceRepository {
  List<Meeting> getDataSource();
}

class MeetingDataSource extends MeetingDataSourceRepository {
  @override
  List<Meeting> getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}
