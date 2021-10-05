// step 1 register
// Hive.box('status').put('accountState', 'profile');
// Hive.box('status').put('accountState', 'CalendarHint');
// Hive.box('status').put('accountState', 'Calendar');
// Hive.box('status').put('accountState', 'session');
// Hive.box('status').put('accountState', 'calendarSessionHint');
// Hive.box('status').put('accountState', 'Passed');

import 'package:didar_app/controller/MainStore.dart';
import 'package:didar_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

//  --------------------------------------------
Box _box = Hive.box('status');
final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;
final RegisterController _controller = Get.put(RegisterController());
//  --------------------------------------------
void routeController(String state) {
  if (_firebaseAuth.currentUser != null) {
    String status = _firebaseAuth.currentUser!.uid;
    if (state == 'Profile') {
      Hive.box('status').put(status, state);
      print(_box.get(status));
      _controller.bottomNavigateTrigger(0);
      print('bottom nav index: ${_controller.pageIndex}');
      Get.snackbar(
        "خوش آمدید",
        "ثبت نام موفقیت آمیز بود!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue[200],
        borderRadius: 10,
      );
      Get.offAllNamed(RoutesName.homeNavigationWrapper);
    } else if (state == 'CalendarHint') {
    } else if (state == 'Calendar') {
    } else if (state == 'session') {
    } else if (state == 'calendarSessionHint') {
    } else if (state == 'Passed') {
    } else {
      print('Unnamed state');
    }
  }
}
