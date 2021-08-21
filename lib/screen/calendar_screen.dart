import 'package:didar_app/screen/day_events_screen.dart';
import 'package:didar_app/services/calendar/solar_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  PageController _pageViewController = PageController(initialPage: 1);
  final Jalali today = Jalali.now();
  Jalali _date = Jalali(1400);

// _____________________________________________________________________________
//                        >>-- Init state --<<
// _____________________________________________________________________________
  @override
  void initState() {
    _date = today.withDay(1);
    super.initState();

    _pageViewController = PageController(initialPage: today.month - 1);
  }

// _____________________________________________________________________________
//                        >>-- Build cycle --<<
// _____________________________________________________________________________

  @override
  Widget build(BuildContext context) {
    dynamic t = today.weekDay;
    dynamic tt = today.monthLength;
    return Container(
      child: Column(
        children: [
          Container(
              child: Padding(
            padding:
                const EdgeInsets.only(right: 14, left: 14, top: 8, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '${SolarCalendar.monthNameList[(_date.month - 1)]}  ${today.year}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ],
            ),
          )),
          Expanded(
            child: PageView.builder(
              onPageChanged: (index) {
                print(index);
                setState(() {
                  _date = Jalali(1400, index + 1);
                  
                });
              },
              controller: _pageViewController,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Row(
                      textDirection: TextDirection.rtl,
                      children: List.generate(
                        7,
                        (index) {
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text(SolarCalendar.daysOfTheWeek[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 11,
                                  )),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: GridView.count(
                            crossAxisCount: 7,
                            childAspectRatio: (1 / 1.5),
                            children: [
                              ...List.generate(
                                  _date.weekDay - 1, (index) => Container()),
                              ...List.generate(
                                _date.monthLength,
                                (index) => GestureDetector(
                                  onTap: () {
                                    Get.to(() => DayEventsScreen(
                                        date: _date.withDay(index + 1)));
                                  },
                                  child: Container(
                                    color: today  == _date.withDay(index+1)
                                        ? Colors.blue
                                        : null,
                                    child: Center(
                                        child: Text((index + 1).toString())),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

// _____________________________________________________________________________
//                        >>-- Dispose --<<
// _____________________________________________________________________________
  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }
}



// REMOVE  This block of code is
// class EX_calendar extends StatelessWidget {
//   const EX_calendar({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: List.generate(
//           5,
//           (index) {
//             return Expanded(
//               child: Row(
//                   textDirection: TextDirection.rtl,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: List.generate(
//                       7,
//                       (index) => Expanded(
//                             child: Container(
//                               color: Colors.black45,
//                               child: Center(
//                                 child: Text('$index'),
//                               ),
//                             ),
//                           ))),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
