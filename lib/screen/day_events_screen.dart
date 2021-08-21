import 'package:flutter/material.dart';
import 'package:shamsi_date/extensions.dart';

class DayEventsScreen extends StatefulWidget {
  final Jalali date;
  const DayEventsScreen({
    Key? key,
    required this.date,
  }) : super(key: key);
  @override
  _DayEventsScreenState createState() => _DayEventsScreenState(date);
}

class _DayEventsScreenState extends State<DayEventsScreen> {
  final Jalali date;

  _DayEventsScreenState(this.date);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text(date.toString()),
      )),
    );
  }
}
