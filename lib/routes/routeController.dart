// step 1 register
// Hive.box('status').put('accountState', 'profile');
// Hive.box('status').put('accountState', 'CalendarHint');
// Hive.box('status').put('accountState', 'Calendar');
// Hive.box('status').put('accountState', 'session');
// Hive.box('status').put('accountState', 'calendarSessionHint');
// Hive.box('status').put('accountState', 'Passed');  >> Final step

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
void routeController(String step) {
  if (_firebaseAuth.currentUser != null) {
    String status = _firebaseAuth.currentUser!.uid;
    _box.put(status, step);
    if (step == 'Profile') {
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
      Get.offAllNamed(HOME_ROUTE);
    } else if (step == 'CalendarHint') {
      _controller.bottomNavigateTrigger(3);
    } else if (step == 'Calendar') {
      print(_box.get(status));
    } else if (step == 'session') {
      print('i am here');
      _controller.bottomNavigateTrigger(1);
    } else if (step == 'calendarSessionHint') {
      _controller.bottomNavigateTrigger(3);
    } else if (step == 'Passed') {
      _controller.bottomNavigateTrigger(3);
    } else {
      print('Unnamed state');
    }
  }
}
//TODO This class is terrible!!!!! Delete it and use routes and parameters to pass the numbers
// Do not use numbers (HAving magical numbers is a bad practice), 
// use names you could create an array and names and use the index

