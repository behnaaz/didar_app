import 'package:didar_app/Constants/them_conf.dart';
import 'package:didar_app/services/calendar/solar_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class CalendarWeeklyScreen extends StatelessWidget {
  const CalendarWeeklyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorPallet.lightGrayBg,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Material(
                elevation: 3,
                child: Container(
                  // padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Column(
                    children: [
                      Text(
                        'تنظیم جلسات اصلی',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: ColorPallet.textColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('مرداد 1400'),
                            Row(
                              children: [
                                Text('زمان استراحت'),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  margin: EdgeInsets.only(right: 5),
                                  color: ColorPallet.blue,
                                  child: Text(
                                    '15 دقیقه',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: [
                        Expanded(child: SizedBox()),
                        ...List.generate(
                          7,
                          (index) => Expanded(
                              child: Container(
                            // color: Colors.yellow,
                            child: Text(
                              SolarCalendar.daysOfTheWeek[index],
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12),
                            ),
                          )),
                        ),
                      ]),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Row(children: [
                          Expanded(child: SizedBox()),
                          ...List.generate(
                            7,
                            (index) => Expanded(
                                child: Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                  // color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(50)),
                              child: Text(
                                (index + 1).toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12),
                              ),
                            )),
                          ),
                        ]),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                  itemCount: 12,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      // color:ColorPallet.lightGrayBg,
                      child: ListView(
                        children: [
                          ...List.generate(
                            23,
                            (index) => Container(
                              padding: EdgeInsets.only(right: 2),
                              height: 60,
                              child: Stack(
                             clipBehavior: Clip.none,
                      
                                children: [
                                  
                                  Positioned(
                                      top: 50,
                                      child: Material(color: Colors.white, elevation: 2,
                                        child: Container(
                                            color: ColorPallet.lightGrayBg,
                                            child: Text((_clockTime[index]))),
                                      )),
                               
                                  Row(
                                    children: [
                                      ...List.generate(
                                        8,
                                        (index) => Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                // color: Colors.red,
                                                border: Border.all(
                                              color: Colors.white,
                                            )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

// REMOVE later
List<String> _clockTime = [
  '01:00',
  '02:00',
  '03:00',
  '04:00',
  '05:00',
  '06:00',
  '07:00',
  '08:00',
  '09:00',
  '10:00',
  '11:00',
  '12:00',
  '13:00',
  '14:00',
  '15:00',
  '16:00',
  '17:00',
  '18:00',
  '19:00',
  '20:00',
  '21:00',
  '22:00',
  '23:00',
  '24:00',
];

//REMOVE mock info
List<Color?> _myColors = [
  Colors.blue,
  Colors.cyan,
  Colors.red,
  Colors.yellow,
  Colors.pink,
  Colors.cyan[200],
  Colors.cyan[100],
  Colors.cyan[400],
  Colors.redAccent,
  Colors.green,
  Colors.teal,
  Colors.teal[200],
];
