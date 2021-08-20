import 'package:flutter/material.dart';
import 'package:shamsi_date/extensions.dart';

/// DataModel of event
class CalendarEvent {
  final String eventID;
  final String eventName;
  final Jalali eventDate;
  final TimeOfDay startingTime;
  final TimeOfDay endTime;
  final Color backgroundColor;
  final Color textColor;


  CalendarEvent({
    required this.eventID,
    required this.eventName,
    required this.eventDate,
    required this.startingTime,
    required this.endTime,
    required this.backgroundColor,
    required this.textColor,
  });


}

