//==============================================================================
//                      session edit Card
//==============================================================================
import 'package:didar_app/constants/them_conf.dart';
import 'package:didar_app/controller/sessions_screen_controller.dart';
import 'package:didar_app/model/session_model.dart';
import 'package:didar_app/model/user_profile_model.dart';
import 'package:didar_app/services/database/fb_user_session_service.dart';
import 'package:didar_app/services/database/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class EditSession extends StatefulWidget {
  @override
  State<EditSession> createState() => _EditSessionState();
}

class _EditSessionState extends State<EditSession> {
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

  final SessionsController _getController = Get.put(SessionsController());
  @override
  void initState() {
    if (_getController.sessionIndexToModify != 0) {
      _dropDownProperAge = _getController.session['audience'];
      _dropDownDuration = _getController.session['duration'];
      _dropDownSessionNum = _getController.session['session_num'];
      _dropDownCapacity = _getController.session['capacity'];
      _priceController.text = _getController.session['price'];
      _infoController.text = _getController.session['info'];
      _selectedColorIndex = int.parse(_getController.session['color']);
      _dropDownCategory = _getController.session['session_type'];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(),
      child: GetBuilder<SessionsController>(
        init: SessionsController(),
        builder: (_) {
          return Column(
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

                              // if (items.contains(_getController.session['session_type'])) {
                              //   _dropDownCategory = _getController.session['session_type'];
                              // }
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
                                      sessionsColorList.length,
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
                                            color: sessionsColorList[index],
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
                          _dropDownSessionNum != null &&
                          _selectedColorIndex != null &&
                          _priceController != '' &&
                          _infoController != '') {
                        FBUserSessionService().deleteSession(_getController.session).then((value) => printInfo(info: 'Delete item'));
                        SessionModel session = SessionModel(
                            type: _dropDownCategory!,
                            audience: _dropDownProperAge!,
                            durationTime: _dropDownDuration!,
                            numOfSessions: _dropDownSessionNum!,
                            capacity: _dropDownCapacity!,
                            price: _priceController.text,
                            info: _infoController.text,
                            color: _selectedColorIndex!.toString());
                        FBUserSessionService().sessionUpdate(session);
                        reset();
                      } else {
                        Get.snackbar('لطفا اطلاعات جلسه کامل رو پر کنید', '', snackPosition: SnackPosition.TOP, backgroundColor: ColorPallet.red);
                      }
                      // this will pop the keyboard onPress
                      try {
                        FocusScope.of(context).requestFocus(FocusNode());
                      } catch (e) {
                        print('there is no context, [keyboard] is already closed');
                      }
                    },
                    child: _getController.sessionIndexToModify != 0
                        ? Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: ColorPallet.blue),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'ذخیره تغییرات',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ))
                        : CircleAvatar(child: Icon(Icons.add))),
              ),
            ],
          );
        },
      ),
    );
  }

  void reset() {
    _dropDownCategory = null;
    _dropDownProperAge = null;
    _dropDownDuration = null;
    _dropDownCapacity = null;
    _dropDownSessionNum = null;
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
