import 'package:didar_app/services/calendar/solar_calendar.dart';
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
  final eventNum = 10;
  _DayEventsScreenState(this.date);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${date.day}  ${SolarCalendar.monthNameList[date.month - 1]} ${date.year}',
          textDirection: TextDirection.rtl,
        ),
      ),
      body: ListView.builder(
          itemCount: eventNum,
          itemBuilder: (context, int index) {
            return Column(
              children: [
                ListTile(
                  leading: Text('${index < 10 ? 0 : ""}$index:00'),
                  title: Container(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6)),
                      child: Text('data')),
                ),
                Divider(),
                ListTile(
                  leading: Text('${index < 10 ? 0 : ""}$index:15'),
                ),
                Divider(),
                ListTile(
                  leading: Text('${index < 10 ? 0 : ""}$index:30'),
                ),
                Divider(),
                ListTile(
                  leading: Text('${index < 10 ? 0 : ""}$index:45'),
                ),
                Divider(),
              ],
            );
          }),
    );
  }
}
