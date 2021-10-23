import 'package:didar_app/constants/them_conf.dart';
import 'package:didar_app/controller/sessions_screen_controller.dart';
import 'package:didar_app/routes/routeController.dart';
import 'package:didar_app/screen/session/session_edit_card.dart';
import 'package:didar_app/screen/session/session_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class SessionsScreen extends StatefulWidget {
  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  bool makeupClassSwitch = false;
  int _makeupSessionNum = 1;

  final SessionsController _getController = Get.put(SessionsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Center(
        child: Container(constraints: BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: ListView(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                '**برای دوره های 1 و 4 جلسه ای کلاس جبرانی برگزار نمیشود**',
                                style: MyTextStyle.small.copyWith(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'برای دوره های 8 جلسه ای کلاس جبرانی برگزار میکنم',
                                    style: MyTextStyle.small.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Switch(
                                      value: makeupClassSwitch,
                                      onChanged: (value) {
                                        setState(() {
                                          makeupClassSwitch = value;
                                        });
                                      })
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'جلسه جبرانی تا چند روز بعد از جلسه اصلی برگزار میشود؟',
                                    style: MyTextStyle.small.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  DropdownButton(
                                    value: _makeupSessionNum,
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        _makeupSessionNum = newValue!;
                                      });
                                    },
                                    borderRadius: BorderRadius.circular(10),
                                    items: <int>[1, 2, 3, 4].map<DropdownMenuItem<int>>((int value) {
                                      return DropdownMenuItem<int>(
                                        onTap: () {
                                          setState(() {
                                            _makeupSessionNum = value;
                                          });
                                        },
                                        value: value,
                                        child: Text(value.toString()),
                                      );
                                    }).toList(),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      MySessionList(),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(children: [
                                    Text('مشخصات جلسه'),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                                      child: Center(
                                          child: GetBuilder<SessionsController>(
                                        init: SessionsController(),
                                        initState: (_) {},
                                        builder: (_) {
                                          return Text(
                                            _getController.sessionIndexToModify != 0 ? _getController.sessionIndexToModify.toString() : 'جدید', 
                                            style: MyTextStyle.small.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                          );
                                        },
                                      )),
                                      // width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: ColorPallet.violet,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                            EditSession()
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: ColorPallet.blue,
                      child: InkWell(
                        splashColor: Colors.lightBlue[400],
                        onTap: () {
                          // FBUserSessionService().fake();
                          Get.dialog(Dialog(
                            // remove this gives error  alignment: AlignmentDirectional.center,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
                            insetPadding: EdgeInsets.all(20),
                            backgroundColor: Colors.white,
                            child: Container(
                              height: 250,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: Colors.blue),
                                            child: Icon(
                                              LineIcons.times,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'با توجه به این که شما چند نوع جلسه دارید آیا می خواهید نوع جلسات خود را بر روی تقویم مشخص کنید؟',
                                    textAlign: TextAlign.center,
                                    style: MyTextStyle.small,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              routeController('calendarSessionHint');
                                              Get.back();
                                            },
                                            child: Text('بله، مشخص میکنم', style: MyTextStyle.small.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.resolveWith(
                                                  (states) => RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                ),
                                                padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.all(2)),
                                                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              routeController('Passed');
                                              Get.back();
                                            },
                                            child: Text('خیر همه ی ساعت ها برای همه ی جلسات قابل ارائه هستند',
                                                textAlign: TextAlign.center, style: MyTextStyle.small.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.resolveWith(
                                                  (states) => RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                ),
                                                padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.all(6)),
                                                backgroundColor: MaterialStateColor.resolveWith((states) => Colors.red)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'ذخیره',
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
    );
  }
}
