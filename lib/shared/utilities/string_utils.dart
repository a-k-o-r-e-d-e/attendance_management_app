import 'package:flutter/material.dart';

class StringUtils {
  StringUtils._();

  static String capitalize(String val) {
    return "${val[0].toUpperCase()}${val.substring(1)}";
  }

  static String formatTime(String time) {
    List<String> parts = time.split(':');
    if (parts.length >= 2) {
      return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
    }
    return time;
  }

  static TimeOfDay parseTime(String timeString) {
    List<String> parts = timeString.split(':');
    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
