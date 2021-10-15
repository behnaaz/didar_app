import 'package:didar_app/constants/them_conf.dart';
import 'package:didar_app/model/user_profile_model.dart';
import 'package:didar_app/routes/routeController.dart';
import 'package:didar_app/services/database/fb_user_session_service.dart';
import 'package:didar_app/services/database/firestore_service.dart';
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
  bool _modifyIsActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //
      //     }),
      body: Container(
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
                                        child: Text(
                                      _modifyIsActive ? '3' : 'جدید',
                                      style: MyTextStyle.small.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
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
                          EditSessional()
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
                        // FBUserSessionService().sessionUpdate();
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
    );
  }
}

// =============================================================================
//              -- firebase Stream List of sessions  --
// =============================================================================
class MySessionList extends StatelessWidget {
  const MySessionList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: FBUserSessionService().sessionList,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Sessions not Available");
          }

          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && !snapshot.data!.exists || snapshot.data['sessionList'].length == 0) {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("هیچ جلسه ای ثبت نشده",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ));
            }

            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            List<dynamic> _list = data['sessionList'];

            return Column(
              children: List.generate(
                _list.length,
                (index) => GestureDetector(
                  onTap: () {
                    // Get.bottomSheet(SessionEditBS(), isDismissible: true, isScrollControlled: true, useRootNavigator: true, backgroundColor: Colors.white, ignoreSafeArea: false);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    decoration: BoxDecoration(color: _colors[int.parse(_list[index]['color'])], borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(_list[index]['session_type'],
                                style: MyTextStyle.base.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900],
                                )),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(LineIcons.edit),
                            SizedBox(
                              width: 60,
                            ),
                            Icon(LineIcons.trash),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return Center(child: CircularProgressIndicator());
        });
  }
}

List<Color> _colors = [
  ColorPallet.lightBlue,
  ColorPallet.green,
  ColorPallet.yellow,
  ColorPallet.cyan,
  ColorPallet.pink,
  ColorPallet.violet,
  ColorPallet.lightRed,
];

//==============================================================================
//                      session edit Card
//==============================================================================
class EditSessional extends StatefulWidget {
  @override
  State<EditSessional> createState() => _EditSessionalState();
}

class _EditSessionalState extends State<EditSessional> {
  int? _selectedColorIndex;
  String? _dropDownCategory;
  String? _dropDownProperAge;
  String? _dropDownDuration;
  String? _dropDownSessionNum;
  String? _dropDownCapacity;
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
// _____________________________________________________________________________
//         >> Get the stream response and return UserProfile_model<<
//                          ---------
  UserProfile parseProfileInfo(Object responseBody) {
    return UserProfile.fromJson(responseBody);
  }

// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(),
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  StreamBuilder<Object>(
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
                          return DropdownButton<String>(
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
                                    _dropDownCategory = value;
                                  });
                                },
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      }),
                  DropdownButton<String>(
                    borderRadius: BorderRadius.circular(10),
                    value: _dropDownProperAge,
                    hint: Text('مناسب برای'),
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
                        _dropDownProperAge = newValue!;
                      });
                    },
                    items: <String>['کودکان', 'بزرگسالان'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        onTap: () {
                          setState(() {
                            _dropDownProperAge = value;
                          });
                        },
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    borderRadius: BorderRadius.circular(10),
                    value: _dropDownDuration,
                    hint: Text('مدت زمان'),
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
                        _dropDownDuration = newValue!;
                      });
                    },
                    items: <String>[
                      ' 30 دقیقه',
                      '60 دقیقه',
                      '45 دقیقه',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        onTap: () {
                          setState(() {
                            _dropDownDuration = value;
                          });
                        },
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    borderRadius: BorderRadius.circular(10),
                    value: _dropDownSessionNum,
                    hint: Text('طول دوره'),
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
                        _dropDownSessionNum = newValue!;
                      });
                    },
                    items: <String>[
                      '1 جلسه',
                      '4 جلسه',
                      '8 جلسه',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        onTap: () {
                          setState(() {
                            _dropDownSessionNum = value;
                          });
                        },
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  DropdownButton<String>(
                    borderRadius: BorderRadius.circular(10),
                    value: _dropDownCapacity,
                    hint: Text('ظرفیت جلسه'),
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
                        _dropDownCapacity = newValue!;
                      });
                    },
                    items: <String>[
                      '1 نفر',
                      '2 نفر',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        onTap: () {
                          setState(() {
                            _dropDownCapacity = value;
                          });
                        },
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  TextField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        label: Text('قیمت دوره'),
                        hintText: '20 دلار',
                        // prefix: Container(
                        //   padding: EdgeInsets.only(left: 20),
                        //   child: Text('قیمت دوره'),
                        // ),
                        suffix: Text('دلار')),
                  ),
                  TextField(
                    controller: _infoController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 4,
                    minLines: 2,
                    decoration: InputDecoration(
                      label: Text('درباره جلسه'),
                      // prefix: Container(
                      //   padding: EdgeInsets.only(left: 20),
                      //   child: Text('درباره جلسه'),
                      // ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'انتخاب رنگ',
                        style: MyTextStyle.base,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Container(
                          height: 30,
                          child: Center(
                            child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                  _colors.length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedColorIndex = index;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: _colors[index],
                                        border: _selectedColorIndex == index ? Border.all(width: 1, color: Colors.white) : null,
                                        boxShadow: _selectedColorIndex == index
                                            ? [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: Offset(0, 3), // changes position of shadow
                                                ),
                                              ]
                                            : null,
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: GestureDetector(
                onTap: () {
                  if (_dropDownCategory != null &&
                      _dropDownProperAge != null &&
                      _dropDownDuration != null &&
                      _dropDownCapacity != null &&
                      _selectedColorIndex != null &&
                      _priceController != '' &&
                      _infoController != '') {
                    FBUserSessionService().sessionUpdate(
                        type: _dropDownCategory!,
                        audience: _dropDownProperAge!,
                        duration: _dropDownDuration!,
                        cap: _dropDownCapacity!,
                        price: _priceController.text,
                        info: _infoController.text,
                        color: _selectedColorIndex!.toString());
                    reset();
                  } else {
                    Get.snackbar('لطفا اطلاعات جلسه کامل رو پر کنید', '', snackPosition: SnackPosition.TOP, backgroundColor: ColorPallet.red);
                  }
                },
                child: CircleAvatar(child: Icon(Icons.add))),
          ),
        ],
      ),
    );
  }

  void reset() {
    _dropDownCategory = null;
    _dropDownProperAge = null;
    _dropDownDuration = null;
    _dropDownCapacity = null;
    _dropDownDuration = null;
    _priceController.text = '';
    _infoController.text = '';
    _selectedColorIndex = null;
    setState(() {});
  }

  @override
  void dispose() {
    _infoController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
