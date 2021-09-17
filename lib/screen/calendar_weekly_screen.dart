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
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Text(
                        'تنظیم جلسات اصلی',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ColorPallet.textColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('مرداد 1400' , style: TextStyle(fontSize: 14),),
                            Row(
                              children: [
                                Text('زمان استراحت'),
                                Container(
                                  padding: EdgeInsets.all(3),
                                  margin: EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: ColorPallet.blue,
                                  ),
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
                              style: TextStyle(fontSize: 10),
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
                            24,
                            (index) => Container(
                              padding: EdgeInsets.only(right: 2),
                              height: 60,
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned(
                                      top: 50,
                                      right: 5,
                                      child: Container(
                                          color: ColorPallet.lightGrayBg,
                                          child: index < 23
                                              ? Text((SolarCalendar.clockTime[index + 1]))
                                              : null)),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(),
                                      ),
                                      ...List.generate(
                                        7,
                                        (i) => Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              print(
                                                SolarCalendar.daysOfTheWeek[i] +
                                                    ' | ' +
                                                    'from ' +
                                                    SolarCalendar.clockTime[index] +
                                                    ' to ' +
                                                    SolarCalendar.clockTime[index + 1],
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  // color: Colors.red,
                                                  border: Border.all(
                                                color: Colors.white,
                                              )),
                                            ),
                                          ),
                                        ),
                                      ),
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

