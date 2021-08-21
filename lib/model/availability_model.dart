import 'package:flutter/material.dart';
import 'package:shamsi_date/extensions.dart';

class Availability {
  //TODO this class represents a free time slot in the calander

  List<TimeSlot> availableTimeSlotList;
  Availability({
    required this.availableTimeSlotList,
  });
}

  /// List of my free time slot [Date] of the Day +
  /// starting time: [From_Time] +
  /// End time duration: [To_Time]
class TimeSlot {
  Jalali date;
  TimeOfDay timeFrom;
  TimeOfDay timeTo;
  TimeSlot({
    required this.date,
    required this.timeFrom,
    required this.timeTo,
  });
}
