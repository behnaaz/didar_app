// =============================================================================
//              -- firebase Stream List of sessions  --
// =============================================================================
import 'package:didar_app/constants/them_conf.dart';
import 'package:didar_app/controller/sessions_screen_controller.dart';
import 'package:didar_app/model/session_model.dart';
import 'package:didar_app/services/database/fb_user_session_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class MySessionList extends StatelessWidget {
  MySessionList({
    Key? key,
  }) : super(key: key);
  final SessionsController _getController = Get.put(SessionsController());
  @override
  Widget build(BuildContext context) {
    FBUserSessionService _dbService = Provider.of<FBUserSessionService>(context, listen: false);
    return StreamBuilder<List<SessionModel>>(
        stream: _dbService.sessionList,
        builder: (context, AsyncSnapshot<List<SessionModel>> snapshot) {
          if (snapshot.hasError || (snapshot.connectionState == ConnectionState.active && snapshot.data?.length == 0)) {
            print('Error : ${snapshot.error}');
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("هیچ جلسه ای ثبت نشده",
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ));
          }
          if (snapshot.connectionState == ConnectionState.active && snapshot.data!.length != 0) {
            var _data = snapshot.data!;

            return Column(
              children: List.generate(
               _data.length ,
                (index) => GestureDetector(
                  onTap: () {
                    // Get.bottomSheet(SessionEditBS(), isDismissible: true, isScrollControlled: true, useRootNavigator: true, backgroundColor: Colors.white, ignoreSafeArea: false);
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    decoration: BoxDecoration(color: sessionsColorList[int.parse(_data[index].color)], borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(_data[index].type,
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
                                  _getController.activeIndexToModify(index + 1, _data[index]);
                                },
                                child: Icon(LineIcons.edit)),
                            SizedBox(
                              width: 60,
                            ),
                            GestureDetector(
                                onTap: () {
                                  _dbService.deleteSession(_data[index]);
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

          return Center(child: CircularProgressIndicator());
        });
  }
}
