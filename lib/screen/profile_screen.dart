import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:didar_app/Constants/them_conf.dart';
import 'package:didar_app/services/database/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

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
    try {
      FocusScope.of(context).requestFocus(FocusNode());
    } catch (e) {
      print('there is no context, [keyboard] is already closed');
    }
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
      body: Stack(
        children: [
          Center(
              child: Image.asset(
            AssetImages.patternAuthBg,
            fit: BoxFit.cover,
          )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 20 ,horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: ColorPallet.grayBg)),
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
                      child: ListView(
                        children: [
                          Center(
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.white,
                                  child: Image.asset(AssetImages.userEmptyAvatar),
                                ),
                                Positioned(
                                    bottom: -6,
                                    right: -2,
                                    child: Container(
                                        padding: EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Image.asset(
                                          AssetImages.editIcon,
                                          width: 18,
                                        )))
                              ],
                            ),
                          ),SizedBox(height: 30,),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                  controller: fullNameController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(4),
                                    labelText: "نام کامل",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                            color: Colors.yellow,
                                            style: BorderStyle.solid,
                                            width: 2)),
                                  ))),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(4),
                                    labelText: "Email",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                            color: Colors.yellow,
                                            style: BorderStyle.solid,
                                            width: 2)),
                                  ))),
                          Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: ageController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(4),
                                    labelText: "Age",
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8)),
                                        borderSide: BorderSide(
                                            color: Colors.yellow,
                                            style: BorderStyle.solid,
                                            width: 2)),
                                  ))),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              keyboardType: TextInputType.phone,
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(4),
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
                          Center(
                            child: OutlinedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0))),
                                  side: MaterialStateBorderSide.resolveWith(
                                      (states) => BorderSide(
                                          width: 2,
                                          style: BorderStyle.solid,
                                          color: Colors.cyan[400]!))),
                              child: Text('+ Available time'),
                              onPressed: () {
                                Get.bottomSheet(
                                  Container(
                                      height: 150,
                                      color: Colors.white,
                                      child: Column(
                                        children: [],
                                      )),
                                  isDismissible: true,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return CircularProgressIndicator();
                }),
          ),
        ],
      ),
    );
  }

//NOTE- save the info before User Dispose the !Screen
  @override
  void dispose() {
    // save();  //FIXME - If you like to save after dispose //
    super.dispose();
  }
}
