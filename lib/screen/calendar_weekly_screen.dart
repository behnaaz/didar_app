import 'package:didar_app/constants/them_conf.dart';
import 'package:didar_app/routes/routeController.dart';
import 'package:didar_app/services/calendar/solar_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shamsi_date/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

var fakeData = {
  '2021-9-25|02:00-03:00': 'پیانو',
  '2021-9-25|04:00-05:00': 'پیانو',
  '2021-9-26|04:00-05:00': 'آواز',
  '2021-9-27|03:00-04:00': 'آواز',
  '2021-9-25|08:00-09:00': 'پیانو',
  '2021-9-24|08:00-09:00': 'پیانو',
  '2021-9-24|01:00-02:00': 'پیانو',
  '2021-9-28|01:00-02:00': 'پیانو',
  '2021-9-29|05:00-06:00': 'پیانو',
  '2021-9-30|01:00-02:00': 'پیانو',
  '2021-10-2|01:00-02:00': 'پیانو',
  '2021-10-4|01:00-02:00': 'پیانو و ساز های زهی',
  '2021-10-4|03:00-04:00': 'یککلمهخیلیبزرگ چطوری اخه ها ها ها',
};

class CalendarWeeklyScreen extends StatefulWidget {
  const CalendarWeeklyScreen({Key? key}) : super(key: key);

  @override
  State<CalendarWeeklyScreen> createState() => _CalendarWeeklyScreenState();
}

class _CalendarWeeklyScreenState extends State<CalendarWeeklyScreen> {
  // instance of my solar calendar
  SolarCalendar cal = new SolarCalendar();
  //TODO - initial page must be implement
  int _currentIndex = 999;
  late PageController _pageViewController = PageController(initialPage: _currentIndex);
  late Jalali now;
  late Jalali date = now;
  @override
  void initState() {
    now = cal.now();
    logger.d(now); //REMOVE
    super.initState();
  }

  Box _box = Hive.box('status');
  final String _userUid = auth.FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    logger.i(now.toDateTime());
    // logger.i(now.weekDay);
    // double numberToRound = 5.3;
    // print(numberToRound.round());
    // print( roundedX);
    return Stack(
      children: [
        Container(
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
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: ColorPallet.textColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  //ANCHOR - Year and month of calendar
                                  SolarCalendar.monthNameList[date.month - 1] + ' ' + date.year.toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
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
                                        style: TextStyle(fontSize: 12, color: Colors.white),
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
                          Row(children: <Widget>[
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
                                  padding: EdgeInsets.symmetric(vertical: 6),
                                  margin: EdgeInsets.symmetric(horizontal: 12),
                                  decoration: BoxDecoration(color: now == date.addDays(index) ? ColorPallet.blue.withOpacity(.6) : null, borderRadius: BorderRadius.circular(50)),
                                  child: Text(
                                    // ANCHOR : weekly days
                                    (date.addDays(index).day).toString(),
                                    textAlign: TextAlign.center,
                                    style: MyTextStyle.small.copyWith(fontWeight: FontWeight.bold),
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
                  //ANCHOR : pageView builder ---------------------
                  child: PageView.builder(
                      controller: _pageViewController,
                      onPageChanged: (index) {
                        print('pageView page index : $index'); //REMOVE
                        setState(() {
                          _currentIndex < index ? date = date.addDays(7) : date = date.addDays(-7);
                          _currentIndex = index;
                          logger.d(date); //REMOVE
                        });
                      },
                      // itemCount: 12,
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
                                      Positioned(top: 50, right: 5, child: Container(color: ColorPallet.lightGrayBg, child: index < 23 ? Text((SolarCalendar.clockTime[index + 1])) : null)),
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
                                                  // print(
                                                  //   SolarCalendar.daysOfTheWeek[i] + ' | ' + 'from ' + SolarCalendar.clockTime[index] + ' to ' + SolarCalendar.clockTime[index + 1],
                                                  // );
                                                  // print(date.addDays(i).toDateTime());
                                                  print(
                                                      '${date.toGregorian().year}-${date.toGregorian().month}-${date.toGregorian().day}|${SolarCalendar.clockTime[index]}-${SolarCalendar.clockTime[index + 1]}');
                                                  print(fakeData[
                                                      '${date.toGregorian().year}-${date.toGregorian().month}-${date.toGregorian().day}|${SolarCalendar.clockTime[index]}-${SolarCalendar.clockTime[index + 1]}']);
                                                  print(fakeData['2021-9-25|02:00-03:00']);
                                                  print(fakeData.containsKey('2021-9-25|02:00-03:00'));
                                                },
                                                child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 400),
                                                  decoration: BoxDecoration(
                                                      color: fakeData.containsKey(
                                                                  '${date.toGregorian().year}-${date.toGregorian().month}-${date.addDays(i).toGregorian().day}|${SolarCalendar.clockTime[index]}-${SolarCalendar.clockTime[index + 1]}') ==
                                                              true
                                                          ? ColorPallet.blue
                                                          : null,
                                                      border: Border.all(
                                                        color: Colors.white,
                                                      )),
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: RichText(
                                                        overflow: TextOverflow.ellipsis,
                                                        text: TextSpan(
                                                            style: TextStyle(color: Colors.black, fontSize: 12),
                                                            text: fakeData[
                                                                    '${date.toGregorian().year}-${date.toGregorian().month}-${date.addDays(i).toGregorian().day}|${SolarCalendar.clockTime[index]}-${SolarCalendar.clockTime[index + 1]}'] ??
                                                                ''),
                                                      ),
                                                    ),
                                                  ),
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
                ),
                Row(
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.blue,
                        child: InkWell(
                          splashColor: Colors.blue[400],
                          // highlightColor: Colors.green ,
                          onTap: _box.get(_userUid) == 'Passed'
                              ? () {}
                              : () {
                                  routeController('session');
                                },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              _box.get(_userUid) == 'Passed' ? 'ذخیره' : 'مرحله بعدی',
                              style: MyTextStyle.large.copyWith(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        _box.get(_userUid) == 'CalendarHint'
            ? Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    routeController('Calendar');
                  },
                  child: Container(
                    color: Colors.black.withOpacity(.7),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35),
                            child: Text(
                              'با ضربه زدن بر روی خانه های تقویم روز و ساعت جلسات خود را مشخص کنید',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Image.asset(
                            AssetImages.calendarHint,
                            height: 90,
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
            : Center(),
      ],
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
