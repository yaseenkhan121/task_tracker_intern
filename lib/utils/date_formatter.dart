import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DateFormatter {
  // Format: "Wednesday, 27 March" (Used on the Schedule Screen header)
  static String formatFullDate(DateTime date) {
    return DateFormat('EEEE, d MMMM').format(date);
  }

  // Format: "09:00 am - 10:30 am" (Used for schedule blocks or task time ranges)
  static String formatTimeRange(TimeOfDay startTime, TimeOfDay endTime) {
    final now = DateTime.now();

    final startDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      startTime.hour,
      startTime.minute,
    );
    final endDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      endTime.hour,
      endTime.minute,
    );

    final format = DateFormat('hh:mm a'); // Format like '09:00 AM' or '03:30 PM'

    return '${format.format(startDateTime)} - ${format.format(endDateTime)}';
  }

  // Format: "9:00 am" (Used for single time stamps)
  static String formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, time.hour, time.minute);

    // Uses 'j' for flexible hour format (h or hh) and 'm' for minutes, 'a' for AM/PM
    return DateFormat('h:mm a').format(dateTime);
  }
}