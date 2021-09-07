import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';


class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                // FirestoreServiceDB().mockUserData();
              },
              child: Icon(LineIcons.commentSlash)),
          Text('setting'),
        ],
      )),
    );
  }
}
