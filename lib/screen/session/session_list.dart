// =============================================================================
//              -- firebase Stream List of sessions  --
// =============================================================================
import 'package:didar_app/constants/them_conf.dart';
import 'package:didar_app/controller/sessions_screen_controller.dart';
import 'package:didar_app/services/database/fb_user_session_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class MySessionList extends StatelessWidget {
  MySessionList({
    Key? key,
  }) : super(key: key);
  final SessionsController _getController = Get.put(SessionsController());
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: FBUserSessionService().sessionList,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Sessions not Available");
          }
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.data.data() != null) {
              Map _data = snapshot.data.data();
              if (!_data.containsKey('sessionList') && snapshot.data.data() != null) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("هیچ جلسه ای ثبت نشده",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ));
              }
            }
            if (snapshot.hasData && !snapshot.data!.exists || snapshot.data['sessionList'].length == 0) {
              return Center(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("هیچ جلسه ای ثبت نشده",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ));
            } else {
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
                      decoration: BoxDecoration(color: sessionsColorList[int.parse(_list[index]['color'])], borderRadius: BorderRadius.circular(8)),
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
                              GestureDetector(
                                  onTap: () {
                                    _getController.activeIndexToModify(index + 1, _list[index]);
                                  },
                                  child: Icon(LineIcons.edit)),
                              SizedBox(
                                width: 60,
                              ),
                              GestureDetector(
                                  onTap: () {
                                    FBUserSessionService().deleteSession(_list[index]);
                                  },
                                  child: Icon(LineIcons.trash)),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }

          return Center(child: CircularProgressIndicator());
        });
  }
}
