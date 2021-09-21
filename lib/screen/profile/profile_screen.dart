import 'package:didar_app/Constants/them_conf.dart';
import 'package:didar_app/model/user_profile_model.dart';
import 'package:didar_app/screen/profile/b_sheet_new_social_link.dart';
import 'package:didar_app/services/database/firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _dropDownChooseSession ;

  /// This function is for saving the User profile info
  /// it will save the info on firestore
  void save() async {
    try {
      await FirestoreServiceDB().updateUserData(
        UserProfile(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          phoneNumber: phoneNumController.text,
          bio: bioController.text,
          eduDegree: eduDegreeController.text,
          sessionTopics: [],
          socialLinks: [],
        ).toJson(),
      );
    } catch (e) {
      print('authenticateService : I the credential in null, userInstance has been not created');
    }
    // this will pop the keyboard onPress
    try {
      FocusScope.of(context).requestFocus(FocusNode());
    } catch (e) {
      print('there is no context, [keyboard] is already closed');
    }
  }

// _____________________________________________________________________________
//         >> Get the stream response and return UserProfile_model<<
//                          ---------
  UserProfile parseProfileInfo(Object responseBody) {
    return UserProfile.fromJson(responseBody);
  }

// _____________________________________________________________________________
//               >> Profile TextField Controllers <<
//                          ---------

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();

  final TextEditingController eduDegreeController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

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
          StreamBuilder(
              stream: FirestoreServiceDB().userProfile,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  // ___________________________________________________________
                  //     >> Set the profile value on controllers <<
                  //                 ---------
                  UserProfile userProfileDocument = parseProfileInfo(snapshot.data!);
                  firstNameController.text = userProfileDocument.firstName;
                  lastNameController.text = userProfileDocument.lastName;

                  emailController.text = userProfileDocument.email;
                  phoneNumController.text = userProfileDocument.phoneNumber;

                  bioController.text = userProfileDocument.bio;
                  eduDegreeController.text = userProfileDocument.eduDegree;
                  // ___________________________________________________________

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: ColorPallet.grayBg)),
                    child: Center(
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
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                                        child: Image.asset(
                                          AssetImages.editIcon,
                                          width: 18,
                                        )))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          _profileTextField(
                            controller: firstNameController,
                            label: "نام",
                          ),
                          _profileTextField(
                            controller: lastNameController,
                            label: "نام خانوادگی",
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey) ,borderRadius: BorderRadius.circular(8)),
                            child: DropdownButton<String>(
                              
                              borderRadius: BorderRadius.circular(10),
                              value: _dropDownChooseSession,
                              hint: Text('موضوع جلسات'),
                              icon: Icon(LineIcons.angleDown),
                              iconSize: 24,
                              alignment: AlignmentDirectional.center,
                              isExpanded: true,
                              elevation: 16,
                              style: const TextStyle(color: ColorPallet.textColor, fontWeight: FontWeight.bold),
                              underline: Container(
                                height: 0,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _dropDownChooseSession = newValue!;
                                });
                              },
                              items: <String>['طراحی', 'آواز', 'پیانو'].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  onTap: () {
                                    setState(() {
                                      _dropDownChooseSession = value;
                                    });
                                  },
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          _profileTextField(controller: emailController, label: "ایمیل", keyboardType: TextInputType.emailAddress),
                          _profileTextField(controller: phoneNumController, label: "شماره موبایل", keyboardType: TextInputType.phone),
                          _profileTextField(controller: eduDegreeController, label: "سابقه تحصیلی"),
                          _profileTextField(
                            label: 'درباره من',
                            controller: bioController,
                            minLines: 3,
                            maxLines: 5,
                            maxLength: 500,
                            keyboardType: TextInputType.multiline,
                          ),
                          Text('راه های ارتباطی من'),
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            ...List.generate(
                                userProfileDocument.socialLinks.length,
                                (index) => Row(
                                      children: [Text(userProfileDocument.socialLinks[index].toString())],
                                    )),
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(50), color: ColorPallet.blue),
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  Get.bottomSheet(
                                    AddNewSocialLinksBottomSheet(socialList: userProfileDocument.socialLinks),
                                    isDismissible: true,
                                  );
                                  // _socialList.add(value);
                                },
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  );
                }
                // if the snapshot.status was != active
                // this will be render on screen
                return Center(child: CircularProgressIndicator());
              }),
        ],
      ),
    );
  }

  Padding _profileTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    int? minLines,
    int? maxLines,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        minLines: minLines,
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)), borderSide: BorderSide(color: Colors.yellow, style: BorderStyle.solid, width: 2)),
        ),
      ),
    );
  }

//NOTE | save the info before User Dispose the !Screen
  @override
  void dispose() {
    // save();  //FIXME - If you like to save after dispose //
    super.dispose();
  }
}
