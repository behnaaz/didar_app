import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// this will show listTail data and also can delete Doc from Collection
class ShowDataFromFireStore extends StatelessWidget {
  final CollectionReference profiles =
      FirebaseFirestore.instance.collection('user_profile');
  @override
  Widget build(BuildContext context) {
    return Center(
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
    );
  }
}

class HomeInputsTest extends StatelessWidget {
  final textController = TextEditingController();
  final CollectionReference profiles =
      FirebaseFirestore.instance.collection('user_profile');
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                labelText: "email",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal)),
              ),
            ),
          ),
          FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                profiles.add({'email': textController.text});
              })
        ],
      ),
    );
  }
}

///Get the Data From FireStore
class ShowUserProfile extends StatelessWidget {
    final CollectionReference profile =
      FirebaseFirestore.instance.collection('user_profile');

      
  @override
  Widget build(BuildContext context) {
    return  Center(
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
    );
    
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowUserProfile();
  }
}
