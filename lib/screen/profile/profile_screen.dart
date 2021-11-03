import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:didar_app/constants/them_conf.dart';
import 'package:didar_app/controller/bottom_navigation_controller.dart';
import 'package:didar_app/model/user_profile_model.dart';
import 'package:didar_app/screen/profile/b_sheet_new_social_link.dart';
import 'package:didar_app/screen/profile/dropdown_session.dart';
import 'package:didar_app/services/auth/authenticatService.dart';
import 'package:didar_app/services/database/firestore_service.dart';
import 'package:didar_app/services/proxy/proxy_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

Logger logger = Logger();

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<dynamic> _socialLinks = [];
  List<dynamic> _sessionTopics = [];

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();

  final TextEditingController eduDegreeController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  late ProxyService _proxyService;
  late AuthenticationService _authService;
  late FirestoreServiceDB _dbService;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void save(BuildContext context) async {
    try {
      await Provider.of<FirestoreServiceDB>(context, listen: false).updateUserData(
        UserProfile(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          phoneNumber: phoneNumController.text,
          bio: bioController.text,
          eduDegree: eduDegreeController.text,
          sessionTopics: _sessionTopics,
          socialLinks: _socialLinks,
        ).toMap(),
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

  @override
  Widget build(BuildContext context) {
    logger.d("Building profile");
    _authService = Provider.of<AuthenticationService>(context, listen: false);
    _proxyService = Provider.of<ProxyService>(context, listen: false);
    _dbService = Provider.of<FirestoreServiceDB>(context, listen: false);
    return Scaffold(
      floatingActionButton: _controller.hint.value
          ? null
          : FloatingActionButton(
              onPressed: () => save(context),
              child: Text("ذخیره"),
            ),
      body: Stack(
        children: [
          Center(
              child: Image.asset(
            AssetImages.patternAuthBg,
            fit: BoxFit.cover,
          )),
          Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: appMaxWithSize), 
              child: StreamBuilder<Object>(
                  stream: _dbService.userProfileStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      logger.d(snapshot.error);
                      return Center(
                        child: Icon(Icons.error_outline),
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.active) {
                      logger.d("user profile " + snapshot.data!.toString());
                      UserProfile userProfileDocument = UserProfile.fromJson(snapshot.data!);
                      logger.d("user profile fetched " + userProfileDocument.toString());

                      firstNameController.text = userProfileDocument.firstName;
                      lastNameController.text = userProfileDocument.lastName;

                      emailController.text = userProfileDocument.email;
                      phoneNumController.text = userProfileDocument.phoneNumber;

                      bioController.text = userProfileDocument.bio;
                      eduDegreeController.text = userProfileDocument.eduDegree;
                      _socialLinks = userProfileDocument.socialLinks;
                      _sessionTopics = userProfileDocument.sessionTopics;
                      return Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: ColorPallet.grayBg)),
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
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        _profileTextField(
                                            controller: firstNameController,
                                            label: "نام *",
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return "لطفا نام  خود را وارد کنید";
                                              }
                                            }),
                                        _profileTextField(
                                            controller: lastNameController,
                                            label: "نام خانوادگی *",
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return "لطفا نام خانوادگی خود را وارد کنید";
                                              }
                                            }),
                                      ],
                                    ),
                                  ),
                                  SessionSubject(
                                    sessionsTopicSelected: userProfileDocument.sessionTopics,
                                  ),
                                  _profileTextField(
                                    controller: emailController,
                                    label: "ایمیل",
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  _profileTextField(
                                    controller: phoneNumController,
                                    label: "شماره موبایل",
                                    keyboardType: TextInputType.phone,
                                  ),
                                  _profileTextField(
                                    controller: eduDegreeController,
                                    label: "سابقه تحصیلی",
                                  ),
                                  _profileTextField(
                                    label: 'درباره من',
                                    controller: bioController,
                                    minLines: 3,
                                    maxLines: 5,
                                    maxLength: 500,
                                    keyboardType: TextInputType.multiline,
                                  ),
                                  Text('راه های ارتباطی من'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                    ...List.generate(
                                        userProfileDocument.socialLinks.length,
                                        (index) => Material(
                                              color: Colors.transparent,
                                              child: Container(
                                                child: Container(
                                                  padding: EdgeInsets.symmetric(vertical: 5),
                                                  child: Row(
                                                    children: _socialListChild(userProfileDocument.socialLinks[index]),
                                                  ),
                                                ),
                                              ),
                                            )),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.circular(50), color: ColorPallet.blue),
                                      child: IconButton(
                                        color: Colors.white,
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          Get.bottomSheet(
                                            AddNewSocialLinksBottomSheet(socialList: _socialLinks),
                                            isDismissible: true,
                                          );
                                        },
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                          ),
                          _controller.hint.value
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Material(
                                        color: ColorPallet.blue,
                                        child: InkWell(
                                          splashColor: Colors.lightBlue[400],
                                          onTap: () {
                                            nextStep();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 15),
                                            child: Text(
                                              'مرحله بعدی',
                                              style: MyTextStyle.large.copyWith(
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              : SizedBox(),
                        ],
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Stream<DocumentSnapshot> fetchUserProfile(BuildContext context) {
    // TODO use this instead of _dbService.userProfile above
    //TODO return type should be come User
    if (_authService.isFallback) {
      logger.d("Falling back to proxy");
      /*return TODO */ _proxyService.userProfile(_authService.currentUser!.email!);
    }
    return _dbService.userProfileStream;
  }

  Padding _profileTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    int? minLines,
    int? maxLines,
    int? maxLength,
    String? Function(String? value)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        validator: validator,
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

  List<Widget> _socialListChild(Map social) {
    List sKey = social.keys.toList();
    List sValue = social.values.toList();
    return [
      // 'instagram', 'facebook', 'tweeter', 'LinkedIn'
      sKey[0] != 'facebook'
          ? sKey[0] != 'instagram'
              ? sKey[0] != 'tweeter'
                  ? Icon(LineIcons.linkedin)
                  : Icon(LineIcons.twitter)
              : Icon(LineIcons.instagram)
          : Icon(LineIcons.facebook),

      SizedBox(
        width: 10,
      ),
      Text(sValue[0])
    ];
  }

//NOTE | save the info before User Dispose the !Screen
  @override
  void dispose() {
    // save();
    super.dispose();
  }

  final BottomNavigationController _controller = Get.put(BottomNavigationController());
  void nextStep() {
    if (_formKey.currentState!.validate()) {
      save(context);
      _controller.CheckHintStage(HintStages.CalHintHowAddAvailability);
    }
  }
}
