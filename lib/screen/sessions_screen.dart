import 'dart:ui';

import 'package:didar_app/constants/them_conf.dart';
import 'package:didar_app/routes/routeController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class SessionsScreen extends StatefulWidget {
  @override
  State<SessionsScreen> createState() => _SessionsScreenState();
}

class _SessionsScreenState extends State<SessionsScreen> {
  bool makeupClassSwitch = false;
  int _makeupSessionNum = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      // floatingActionButton: FloatingActionButton(
      //     child: Icon(Icons.add),
      //     onPressed: () {
      //       // TODO : this is temporary it should navigate this to New Session Screen
      //       Get.to(() => SessionEditBS());
      //     }),
      body: Container(
        // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                    ...List.generate(
                      3,
                      (index) => GestureDetector(
                        onTap: () {
                          // Get.bottomSheet(SessionEditBS(), isDismissible: true, isScrollControlled: true, useRootNavigator: true, backgroundColor: Colors.white, ignoreSafeArea: false);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          decoration: BoxDecoration(color: _c[index], borderRadius: BorderRadius.circular(8)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text('موسیقی',
                                      style: MyTextStyle.base.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[900],
                                      )),
                                  // Container(
                                  //     padding: EdgeInsets.symmetric(horizontal: 10),
                                  //     margin: EdgeInsets.symmetric(horizontal: 10),
                                  //     decoration: BoxDecoration(border: Border.symmetric(vertical: BorderSide(color: ColorPallet.textColor))),
                                  //     child: Text(
                                  //       'آواز تخصصی',
                                  //       style: MyTextStyle.base,
                                  //     )),
                                  // Text(
                                  //   '45 دقیقه',
                                  //   style: MyTextStyle.base,
                                  // ),
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
                                    child: Center(
                                        child: Text(
                                      '3',
                                      style: MyTextStyle.small.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                    )),
                                    width: 22,
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
                        Get.dialog(Dialog(
                          alignment: AlignmentDirectional.center,
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

// TODO : this is for test. Must remove latter.
List<Color> _c = [
  ColorPallet.lightBlue,
  ColorPallet.green,
  ColorPallet.yellow,
  ColorPallet.cyan,
  ColorPallet.pink,
  ColorPallet.violet,
  ColorPallet.lightRed,
];

//==============================================================================
//     session edit bottom sheet -- should Extract to new file
//==============================================================================
// class SessionEditBS extends StatefulWidget {
//   @override
//   State<SessionEditBS> createState() => _SessionEditBSState();
// }

// class _SessionEditBSState extends State<SessionEditBS> {
//   String? _dropDownCategory;
//   String? _dropDownProperAge;
//   String? _dropDownDuration;
//   String? _dropDownSessionNum;
//   String? _dropDownCapacity;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           title: Text(
//             'جلسه موسیقی',
//             style: MyTextStyle.pageTitle,
//           ),
//           centerTitle: true,
//         ),
//         body: Container(
//           padding: EdgeInsets.symmetric(),
//           child: Column(
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   child: ListView(
//                     children: [
//                       SizedBox(
//                         height: 20,
//                       ),
//                       DropdownButton<String>(
//                         borderRadius: BorderRadius.circular(10),
//                         value: _dropDownCategory,
//                         hint: Text('دسته بندی جلسه'),
//                         icon: Icon(LineIcons.angleDown),
//                         iconSize: 24,
//                         alignment: AlignmentDirectional.center,
//                         isExpanded: true,
//                         elevation: 16,
//                         style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
//                         underline: Container(
//                           height: 1,
//                           color: Colors.deepPurpleAccent,
//                         ),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             _dropDownCategory = newValue!;
//                           });
//                         },
//                         items: <String>['موسیقی', 'آواز', 'نقاشی', 'پیانو'].map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             onTap: () {
//                               setState(() {
//                                 _dropDownCategory = value;
//                               });
//                             },
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       ),
//                       DropdownButton<String>(
//                         borderRadius: BorderRadius.circular(10),
//                         value: _dropDownProperAge,
//                         hint: Text('مناسب برای'),
//                         icon: Icon(LineIcons.angleDown),
//                         iconSize: 24,
//                         alignment: AlignmentDirectional.center,
//                         isExpanded: true,
//                         elevation: 16,
//                         style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
//                         underline: Container(
//                           height: 1,
//                           color: Colors.deepPurpleAccent,
//                         ),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             _dropDownProperAge = newValue!;
//                           });
//                         },
//                         items: <String>['تمامی سنین', 'کودکان', 'بزرگسالان'].map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             onTap: () {
//                               setState(() {
//                                 _dropDownProperAge = value;
//                               });
//                             },
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       ),
//                       DropdownButton<String>(
//                         borderRadius: BorderRadius.circular(10),
//                         value: _dropDownDuration,
//                         hint: Text('مدت زمان'),
//                         icon: Icon(LineIcons.angleDown),
//                         iconSize: 24,
//                         alignment: AlignmentDirectional.center,
//                         isExpanded: true,
//                         elevation: 16,
//                         style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
//                         underline: Container(
//                           height: 1,
//                           color: Colors.deepPurpleAccent,
//                         ),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             _dropDownDuration = newValue!;
//                           });
//                         },
//                         items: <String>[
//                           ' 30 دقیقه',
//                           '60 دقیقه',
//                           '45 دقیقه',
//                         ].map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             onTap: () {
//                               setState(() {
//                                 _dropDownDuration = value;
//                               });
//                             },
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       ),
//                       DropdownButton<String>(
//                         borderRadius: BorderRadius.circular(10),
//                         value: _dropDownSessionNum,
//                         hint: Text('طول دوره'),
//                         icon: Icon(LineIcons.angleDown),
//                         iconSize: 24,
//                         alignment: AlignmentDirectional.center,
//                         isExpanded: true,
//                         elevation: 16,
//                         style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
//                         underline: Container(
//                           height: 1,
//                           color: Colors.deepPurpleAccent,
//                         ),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             _dropDownSessionNum = newValue!;
//                           });
//                         },
//                         items: <String>[
//                           '1 جلسه',
//                           '2 جلسه',
//                           '3 جلسه',
//                           '4 جلسه',
//                           '5 جلسه',
//                           '6 جلسه',
//                           '7 جلسه',
//                           '8 جلسه',
//                         ].map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             onTap: () {
//                               setState(() {
//                                 _dropDownSessionNum = value;
//                               });
//                             },
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       ),
//                       DropdownButton<String>(
//                         borderRadius: BorderRadius.circular(10),
//                         value: _dropDownCapacity,
//                         hint: Text('ظرفیت جلسه'),
//                         icon: Icon(LineIcons.angleDown),
//                         iconSize: 24,
//                         alignment: AlignmentDirectional.center,
//                         isExpanded: true,
//                         elevation: 16,
//                         style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
//                         underline: Container(
//                           height: 1,
//                           color: Colors.deepPurpleAccent,
//                         ),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             _dropDownCapacity = newValue!;
//                           });
//                         },
//                         items: <String>[
//                           '1 نفر',
//                           '2 نفر',
//                         ].map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             onTap: () {
//                               setState(() {
//                                 _dropDownCapacity = value;
//                               });
//                             },
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       ),
//                       TextField(
//                         keyboardType: TextInputType.number,
//                         decoration: InputDecoration(
//                             label: Text('قیمت دوره'),
//                             // prefix: Container(
//                             //   padding: EdgeInsets.only(left: 20),
//                             //   child: Text('قیمت دوره'),
//                             // ),
//                             suffix: Text('دلار')),
//                       ),
//                       TextField(
//                         keyboardType: TextInputType.multiline,
//                         maxLines: 4,
//                         minLines: 2,
//                         decoration: InputDecoration(
//                           label: Text('درباره جلسه'),
//                           // prefix: Container(
//                           //   padding: EdgeInsets.only(left: 20),
//                           //   child: Text('درباره جلسه'),
//                           // ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'انتخاب رنگ',
//                             style: MyTextStyle.base,
//                           ),
//                           Row(
//                             children: [
//                               Container(
//                                 margin: EdgeInsets.symmetric(horizontal: 10),
//                                 width: 20,
//                                 height: 20,
//                                 color: ColorPallet.lightRed,
//                               ),
//                               Container(
//                                 margin: EdgeInsets.symmetric(horizontal: 10),
//                                 width: 20,
//                                 height: 20,
//                                 color: ColorPallet.violet,
//                               ),
//                               Container(
//                                 margin: EdgeInsets.symmetric(horizontal: 10),
//                                 width: 20,
//                                 height: 20,
//                                 color: ColorPallet.pink,
//                               ),
//                               Container(
//                                 margin: EdgeInsets.symmetric(horizontal: 10),
//                                 width: 20,
//                                 height: 20,
//                                 color: ColorPallet.yellow,
//                               ),
//                               Container(
//                                 margin: EdgeInsets.symmetric(horizontal: 10),
//                                 width: 20,
//                                 height: 20,
//                                 color: ColorPallet.green,
//                               ),
//                               Container(
//                                 margin: EdgeInsets.symmetric(horizontal: 10),
//                                 width: 20,
//                                 height: 20,
//                                 color: ColorPallet.lightBlue,
//                               )
//                             ],
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Material(
//                       color: ColorPallet.blue,
//                       child: InkWell(
//                         splashColor: Colors.lightBlue[400],
//                         // highlightColor: Colors.green ,
//                         onTap: () {},
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           child: Text(
//                             'ذخیره',
//                             style: MyTextStyle.large.copyWith(
//                               color: Colors.white,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }
// }
// ++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++
//==============================================================================
//     session edit bottom sheet -- should Extract to new file
//==============================================================================
class EditSessional extends StatefulWidget {
  @override
  State<EditSessional> createState() => _EditSessionalState();
}

class _EditSessionalState extends State<EditSessional> {
  int? selectedColorIndex;
  String? _dropDownCategory;
  String? _dropDownProperAge;
  String? _dropDownDuration;
  String? _dropDownSessionNum;
  String? _dropDownCapacity;
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
                  DropdownButton<String>(
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
                        _dropDownCategory = newValue!;
                      });
                    },
                    items: <String>['موسیقی', 'آواز', 'نقاشی', 'پیانو'].map<DropdownMenuItem<String>>((String value) {
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
                  ),
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
                      '2 جلسه',
                      '3 جلسه',
                      '4 جلسه',
                      '5 جلسه',
                      '6 جلسه',
                      '7 جلسه',
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
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        label: Text('قیمت دوره'),
                        // prefix: Container(
                        //   padding: EdgeInsets.only(left: 20),
                        //   child: Text('قیمت دوره'),
                        // ),
                        suffix: Text('دلار')),
                  ),
                  TextField(
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
                                  _c.length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedColorIndex = index;
                                      });
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: _c[index],
                                        border: selectedColorIndex == index ? Border.all(width: 1, color: Colors.white) : null,
                                        boxShadow: selectedColorIndex == index
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
          )
        ],
      ),
    );
  }
}
