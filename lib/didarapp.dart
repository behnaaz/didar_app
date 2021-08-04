import 'package:didar_app/screen/HomeScreen.dart';
import 'package:flutter/material.dart';

// TODO Delete if not in use anymore
import 'package:get/get.dart';

class DidarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(color: Colors.blue[900]),
          primaryColor: Colors.blue[900]),
      home: HomeScreen(),
    );
  }
}
