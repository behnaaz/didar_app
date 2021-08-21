import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:didar_app/services/database/firestore_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  /// This function is for saving the User profile info
  /// it will save the info on firestore
  void save() async {
    try {
      await FirestoreServiceDB().updateUserData(
        fullName: fullNameController.text,
        email: emailController.text,
        phoneNumber: phoneNumberController.text,
        age: int.parse(ageController.text),
      );
    } catch (e) {
      print(
          'authenticateService : I the credential in null, userInstance has been not created');
    }
    // this will pop the keyboard onPress
    FocusScope.of(context).requestFocus(FocusNode());
  }

//save the info before User Dispose the !Screen
//FIXME - --> BUT I comment the save() to not send unnecessary Request for update
  @override
  void dispose() {
    // save();
    super.dispose();
  }

// _____________________________________________________________________________
//               >> Profile TextField Controllers <<
  final TextEditingController emailController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
//______________________________________________________________________________

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => save(),
        child: Text("save"),
      ),
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
                            keyboardType: TextInputType.phone,
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
