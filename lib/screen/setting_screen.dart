import 'package:didar_app/services/database/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

var logger = Logger();

class SettingScreen extends StatelessWidget {
  final FirestoreServiceDB db = FirestoreServiceDB();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        print('ok');
        db.updateUserData(
            fullName: 'hasan',
            email: 'hasan@gamli.com',
            phoneNumber: '093923',
            age: 12);
      }),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Center(
            child: StreamBuilder(
          stream: db.mockUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              logger.d(snapshot.data);
               var userDocument = snapshot.data;
        // dynamic a = userDocument["email"];
               
              return ListView(children: [],);
            } else {
              return ListView(
                children: [
                  Container(
                    child: Text(db.userID()),
                  ),
                ],
              );
            }
          },
        )),
      ),
    );
  }
}
