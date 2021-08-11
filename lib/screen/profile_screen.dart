import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:didar_app/database/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// this will show listTail data and also can delete Doc from Collection
// class ShowDataFromFireStore extends StatelessWidget {
//   final CollectionReference profiles =
//       FirebaseFirestore.instance.collection('user_profile');
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: StreamBuilder(
//           stream:
//               FirebaseFirestore.instance.collection('user_profile').snapshots(),
//           builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//             if (snapshot.connectionState == ConnectionState.active) {
//               return ListView(
//                 children: snapshot.data != null
//                     ? snapshot.data!.docs.map((e) {
//                         return Center(
//                             child: ListTile(
//                           title: Text(e['email']),
//                           onLongPress: () {
//                             e.reference.delete();
//                           },
//                         ));
//                       }).toList()
//                     : [],
//               );
//             }
//             return CircularProgressIndicator();
//           }),
//     );
//   }
// }

class ProfileScreen extends StatelessWidget {
 final CollectionReference profile =
      FirebaseFirestore.instance.collection('user_profile');

  // TextField Controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: FloatingActionButton(onPressed: () async{
 try {
      await FirestoreServiceDB().updateUserData(
          fullName: fullNameController.text,
          email: emailController.text,
          phoneNumber:  int.parse(phoneNumberController.text),
          age:  int.parse(ageController.text),);
    } catch (e) {
      print(
          "authenticateService : I the credential in null, userInstance has been not created");
    }
      
    } ,child: Text("save"),),
      body: Padding( 
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Center(
          child: StreamBuilder(
              stream: FirestoreServiceDB().userProfile,
              builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var userDocument = snapshot.data!;
                  emailController.text = userDocument["email"];
                  fullNameController.text = userDocument["full_name"];
                  ageController.text = userDocument["age"].toString();
                  phoneNumberController.text =
                      userDocument["phone_number"].toString();
                  return Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            controller: fullNameController,
                            decoration: InputDecoration(
                              labelText: "Full name",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                      color: Colors.yellow,
                                      style: BorderStyle.solid,
                                      width: 2)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              labelText: "Email",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                      color: Colors.yellow,
                                      style: BorderStyle.solid,
                                      width: 2)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                                  keyboardType: TextInputType.number,
                            controller: ageController,
                            decoration: InputDecoration(
                              labelText: "Age",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                      color: Colors.yellow,
                                      style: BorderStyle.solid,
                                      width: 2)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                              keyboardType: TextInputType.number,
                            
                            controller: phoneNumberController,
                            decoration: InputDecoration(
                              labelText: "Phone number",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  borderSide: BorderSide(
                                      color: Colors.yellow,
                                      style: BorderStyle.solid,
                                      width: 2)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return CircularProgressIndicator();
              }),
        ),
      ),
    );
  }
}
