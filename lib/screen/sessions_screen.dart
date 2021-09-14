import 'package:didar_app/Constants/them_conf.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class SessionsScreen extends StatelessWidget {
  const SessionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListView(
          children: List.generate(
        5,
        (index) => GestureDetector(
          onTap: () {
            Get.bottomSheet(SessionEditBS(), isDismissible: true, isScrollControlled: true, useRootNavigator: true, backgroundColor: Colors.white, ignoreSafeArea: false);
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            decoration: BoxDecoration(color: _c[index], borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Text(
                  'موسیقی',
                  style: MyTextStyle.base,
                ),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(border: Border.symmetric(vertical: BorderSide(color: ColorPallet.textColor))),
                    child: Text(
                      'آواز تخصصی',
                      style: MyTextStyle.base,
                    )),
                Text(
                  '45 دقیقه',
                  style: MyTextStyle.base,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

// TODO : this is for test. Must remove latter.
List<Color> _c = [
  ColorPallet.lightBlue,
  ColorPallet.lightRed,
  ColorPallet.green,
  ColorPallet.violet,
  ColorPallet.pink,
];

//==============================================================================
//     session edit bottom sheet -- should Extract to new file
//==============================================================================
class SessionEditBS extends StatefulWidget {
  @override
  State<SessionEditBS> createState() => _SessionEditBSState();
}

class _SessionEditBSState extends State<SessionEditBS> {
  String? _dropDownCategory;
  String? _dropDownProperAge;
  String? _dropDownDuration;
  String? _dropDownSessionNum;
  String? _dropDownCapacity;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'جلسه موسیقی',
            style: MyTextStyle.pageTitle,
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    DropdownButton<String>(
                      value: _dropDownCategory,
                      hint: Text('دسته بندی جلسه'),
                      icon: Icon(LineIcons.chevronDown),
                      iconSize: 24,
                      alignment: AlignmentDirectional.center,
                      isExpanded: true,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                      underline: Container(
                        height: 2,
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
                      value: _dropDownProperAge,
                      hint: Text('مناسب برای'),
                      icon: Icon(LineIcons.chevronDown),
                      iconSize: 24,
                      alignment: AlignmentDirectional.center,
                      isExpanded: true,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _dropDownProperAge = newValue!;
                        });
                      },
                      items: <String>['تمامی سنین', 'کودکان', 'بزرگسالان'].map<DropdownMenuItem<String>>((String value) {
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
                      value: _dropDownDuration,
                      hint: Text('مدت زمان'),
                      icon: Icon(LineIcons.chevronDown),
                      iconSize: 24,
                      alignment: AlignmentDirectional.center,
                      isExpanded: true,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                      underline: Container(
                        height: 2,
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
                      value: _dropDownSessionNum,
                      hint: Text('طول دوره'),
                      icon: Icon(LineIcons.chevronDown),
                      iconSize: 24,
                      alignment: AlignmentDirectional.center,
                      isExpanded: true,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                      underline: Container(
                        height: 2,
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
                      value: _dropDownCapacity,
                      hint: Text('ظرفیت جلسه'),
                      icon: Icon(LineIcons.chevronDown),
                      iconSize: 24,
                      alignment: AlignmentDirectional.center,
                      isExpanded: true,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
                      underline: Container(
                        height: 2,
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
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      color: Colors.blue[700],
                      child: Center(
                        child: Text(
                          'ذخیره',
                          style: MyTextStyle.large.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
