import 'dart:ui';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../data_source/meeting_data_source.dart';

class MeetingRepoImpl extends CalendarDataSource {
  MeetingRepoImpl(MeetingDataSourceRepository source) {
    appointments = source.getDataSource();
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}
