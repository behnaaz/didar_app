import 'package:didar_app/constants/them_conf.dart';
import 'package:didar_app/model/user_profile_model.dart';
import 'package:didar_app/routes/routeController.dart';
import 'package:didar_app/services/calendar/solar_calendar.dart';
import 'package:didar_app/services/database/fb_availability%20_service.dart';
import 'package:didar_app/services/database/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shamsi_date/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class CalendarWeeklyScreen extends StatefulWidget {
  const CalendarWeeklyScreen({Key? key}) : super(key: key);

  @override
  State<CalendarWeeklyScreen> createState() => _CalendarWeeklyScreenState();
}

class _CalendarWeeklyScreenState extends State<CalendarWeeklyScreen> {
  UserProfile parseProfileInfo(Object responseBody) {
    return UserProfile.fromJson(responseBody);
  }

  // instance of my solar calendar
  SolarCalendar cal = new SolarCalendar();

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
                StreamBuilder<Object>(
                    stream: FBAvailableTimeService().availability,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        var _mapData = {};
                        if (snapshot.data.data() != null) {
                          List _data = snapshot.data.data()['available_List'] ?? [];
                          _mapData = Map.fromIterable(_data, key: (e) => e['time_slot'], value: (e) => e['session_type']);
                        }

                        return Expanded(
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
                                                  ...List.generate(7, (i) {
                                                    var _thisTime =
                                                        '${date.toGregorian().year}-${date.toGregorian().month}-${date.addDays(i).toGregorian().day}|${SolarCalendar.clockTime[index]}-${SolarCalendar.clockTime[index + 1]}';
                                                    return Expanded(
                                                      child: GestureDetector(
                                                        onLongPress: () {
                                                          FBAvailableTimeService().deleteAvailableTime(timeSlot: _thisTime, type: _mapData[_thisTime]);
                                                        },
                                                        onTap: () {
                                                          print(
                                                            SolarCalendar.daysOfTheWeek[i] + ' | ' + 'from ' + SolarCalendar.clockTime[index] + ' to ' + SolarCalendar.clockTime[index + 1],
                                                          );

                                                          if (_mapData.containsKey(
                                                              '${date.toGregorian().year}-${date.toGregorian().month}-${date.addDays(i).toGregorian().day}|${SolarCalendar.clockTime[index]}-${SolarCalendar.clockTime[index + 1]}')) {
                                                            Get.defaultDialog(
                                                              title: 'ویرایش',
                                                              middleText: '',
                                                              confirm: StreamBuilder<Object>(
                                                                  stream: FirestoreServiceDB().userProfile,
                                                                  builder: (context, snapshot) {
                                                                    if (snapshot.connectionState == ConnectionState.active) {
                                                                      UserProfile userProfileDocument = parseProfileInfo(snapshot.data!);
                                                                      List<String> listToString(List list) {
                                                                        List<String> stringList = [];
                                                                        list.forEach((element) {
                                                                          stringList.add(element.toString());
                                                                        });
                                                                        return stringList;
                                                                      }

                                                                      List<String> items = listToString(userProfileDocument.sessionTopics);
                                                                      String? _dropDownCategory;
                                                                      return Container(
                                                                        width: 150,
                                                                        child: DropdownButton<String>(
                                                                          borderRadius: BorderRadius.circular(10),
                                                                          value: _dropDownCategory,
                                                                          hint: Text('دسته بندی جلسه'),
                                                                          icon: Icon(LineIcons.angleDown),
                                                                          iconSize: 24,
                                                                          alignment: AlignmentDirectional.center,
                                                                          isExpanded: true,
                                                                          elevation: 16,
                                                                          style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                                                                          underline: Container(
                                                                            height: 1,
                                                                            color: Colors.deepPurpleAccent,
                                                                          ),
                                                                          onChanged: (String? newValue) {
                                                                            setState(() {
                                                                              _dropDownCategory = newValue;
                                                                            });
                                                                          },
                                                                          items: items.map<DropdownMenuItem<String>>((String value) {
                                                                            return DropdownMenuItem<String>(
                                                                              onTap: () {
                                                                                setState(() {
                                                                                  // _dropDownCategory = value;

                                                                                  FBAvailableTimeService().deleteAvailableTime(timeSlot: _thisTime, type: _mapData[
                                                                                          '${date.toGregorian().year}-${date.toGregorian().month}-${date.addDays(i).toGregorian().day}|${SolarCalendar.clockTime[index]}-${SolarCalendar.clockTime[index + 1]}']);
                                                                                  FBAvailableTimeService().updateAvailableTime(timeSlot: _thisTime, sessionType: value);
                                                                                  Get.back();
                                                                                });
                                                                              },
                                                                              value: value,
                                                                              child: Text(value),
                                                                            );
                                                                          }).toList(),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return CircularProgressIndicator();
                                                                    }
                                                                  }),
                                                            );
                                                          } else {
                                                            FBAvailableTimeService().updateAvailableTime(timeSlot: _thisTime);
                                                            print('done');
                                                          }
                                                        },
                                                        child: AnimatedContainer(
                                                          duration: Duration(milliseconds: 400),
                                                          decoration: BoxDecoration(
                                                              color: _mapData.containsKey(
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
                                                                    text: _mapData[
                                                                            '${date.toGregorian().year}-${date.toGregorian().month}-${date.addDays(i).toGregorian().day}|${SolarCalendar.clockTime[index]}-${SolarCalendar.clockTime[index + 1]}'] ??
                                                                        ''),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
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
                        );
                      }
                      return Expanded(child: Center(child: CircularProgressIndicator()));
                    }),
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
                                  print(_box.get(_userUid));
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
        _box.get(_userUid) == 'CalendarHint' || _box.get(_userUid) == 'calendarSessionHint'
            ? Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _box.get(_userUid) == 'CalendarHint' ? routeController('Calendar') : routeController('Passed');
                    });
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
                              _box.get(_userUid) == 'CalendarHint'
                                  ? 'با ضربه زدن بر روی خانه های تقویم روز و ساعت جلسات خود را مشخص کنید'
                                  : 'برای مشخص کردن نوع جلسه بر روی زمان های انتخاب شده بر روی تقویم ضربه بزنید',
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
