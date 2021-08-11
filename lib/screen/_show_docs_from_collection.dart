
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ShowDataFromFireStore extends StatelessWidget {
  final CollectionReference profiles =
      FirebaseFirestore.instance.collection('user_profile');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('user_profile').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return ListView(
                  children: snapshot.data != null
                      ? snapshot.data!.docs.map((e) {
                          return Center(
                              child: ListTile(
                            title: Text(e['email']),
                            onLongPress: () {
                              e.reference.delete();
                            },
                          ));
                        }).toList()
                      : [],
                );
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
