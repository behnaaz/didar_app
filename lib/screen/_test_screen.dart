import 'package:didar_app/screen/_bottom_nav_wrapper.dart';
import 'package:didar_app/screen/calendar_screen.dart';
import 'package:didar_app/screen/_getx_store_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Get.to(() => CalendarScreen());
            },
            child: Text("Calendar"),
          ),
          ElevatedButton(
              onPressed: () {
                Get.to(() => BottomNavigationWrapper());
              },
              child: Text("bottom navigator",
                  style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
              )),
          ElevatedButton(
            onPressed: () {
              Get.to(() => GetxStoreTestScreen());
            },
            child: Text("Getx State manager"),
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
        ],
      ),
    );
  }
}
