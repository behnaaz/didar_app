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
// _____________________________________________________________________________
//         >> Get the stream response and return UserProfile_model<<
//                          ---------
  UserProfile parseProfileInfo(Object responseBody) {
    return UserProfile.fromJson(responseBody);
  }

// -----------------------------------------------------------------------------

  final SessionsController _getController = Get.put(SessionsController());

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

                              return DropdownButton<String>(
                                borderRadius: BorderRadius.circular(10),
                                value: items.contains(_.dropDownCategory.toString()) ? _.dropDownCategory.toString() : null,
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
                                    _.dropDownCategory = RxString(newValue!);
                                  });
                                },
                                items: items.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
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
                        value: _.dropDownAudience.toString() != '' ? _.dropDownAudience.toString() : null,
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
                            _.dropDownAudience = RxString(newValue!);
                          });
                        },
                        items: <String>['کودکان', 'بزرگسالان'].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        value: _.dropDownTimeDuration.toString() != '' ? _.dropDownTimeDuration.toString() : null,
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
                            _.dropDownTimeDuration = RxString(newValue!);
                          });
                        },
                        items: <String>[
                          ' 30 دقیقه',
                          '60 دقیقه',
                          '45 دقیقه',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        value: _.dropDownNumOfSession.toString() != '' ? _.dropDownNumOfSession.toString() : null,
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
                            _.dropDownNumOfSession = RxString(newValue!);
                          });
                        },
                        items: <String>[
                          '1 جلسه',
                          '4 جلسه',
                          '8 جلسه',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        value: _.dropDownCapacity.toString() != '' ? _.dropDownCapacity.toString() : null,
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
                            _.dropDownCapacity = RxString(newValue!);
                          });
                        },
                        items: <String>[
                          '1 نفر',
                          '2 نفر',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      TextField(
                        controller: _.priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(label: Text('قیمت دوره'), hintText: '20 دلار', suffix: Text('دلار')),
                      ),
                      TextField(
                        controller: _.infoController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        minLines: 2,
                        decoration: InputDecoration(
                          label: Text('درباره جلسه'),
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
                                            _.selectedColorIndex = RxInt(index);
                                          });
                                        },
                                        child: Container(
                                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            color: sessionsColorList[index],
                                            border: _.selectedColorIndex == index ? Border.all(width: 1, color: Colors.white) : null,
                                            boxShadow: _.selectedColorIndex == index
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
                      if (_.dropDownCategory.toString() != '' &&
                          _.dropDownAudience.toString() != '' &&
                          _.dropDownTimeDuration.toString() != '' &&
                          _.dropDownCapacity.toString() != '' &&
                          _.dropDownNumOfSession.toString() != '' &&
                          _.selectedColorIndex != null &&
                          _.priceController != '' &&
                          _.infoController != '') {
                        FBUserSessionService().deleteSession(_getController.session).then((value) => printInfo(info: 'Delete item'));
                        SessionModel session = SessionModel(
                            type: _.dropDownCategory.toString(),
                            audience: _.dropDownAudience.toString(),
                            durationTime: _.dropDownTimeDuration.toString(),
                            numOfSessions: _.dropDownNumOfSession.toString(),
                            capacity: _.dropDownCapacity.toString(),
                            price: _.priceController.text,
                            info: _.infoController.text,
                            color: _.selectedColorIndex.toString());
                        FBUserSessionService().sessionUpdate(session);
                        _.emptyTheFields();
                        setState(() {});
                      } else {
                        Get.snackbar('لطفا اطلاعات جلسه کامل رو پر کنید', '', snackPosition: SnackPosition.TOP, backgroundColor: ColorPallet.red);
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
}
