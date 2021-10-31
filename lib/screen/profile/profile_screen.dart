import 'package:didar_app/constants/them_conf.dart';
import 'package:didar_app/controller/bottom_navigation_controller.dart';
import 'package:didar_app/model/user_profile_model.dart';
import 'package:didar_app/screen/profile/b_sheet_new_social_link.dart';
import 'package:didar_app/services/auth/authenticatService.dart';
import 'package:didar_app/services/database/fb_all_session_service.dart';
import 'package:didar_app/services/database/firestore_service.dart';
import 'package:didar_app/services/proxy/proxy_service.dart';
import 'package:didar_app/widgets/multiSelect.dart';
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

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();

  final TextEditingController eduDegreeController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  late ProxyService _proxyService;
  late AuthenticationService _authService;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void save(BuildContext context) async {
    try {
      await Provider.of<FirestoreServiceDB>(context, listen: false)
          .updateUserData(
        UserProfile(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          phoneNumber: phoneNumController.text,
          bio: bioController.text,
          eduDegree: eduDegreeController.text,
          sessionTopics: [],
          socialLinks: _socialLinks,
        ).toMap(),
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

  @override
  Widget build(BuildContext context) {
    logger.d("Building profile");
    _authService = Provider.of<AuthenticationService>(context, listen: false);
    _proxyService = Provider.of<ProxyService>(context, listen: false);
    return Scaffold(
      floatingActionButton: _controller.hint.value
          ? null
          : FloatingActionButton(
              onPressed: () => save(context),
              child: Text("save"), //TODO: Why is this in English?
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
              constraints:
                  BoxConstraints(maxWidth: 800), //TODO: Don't use magic numbers
              child: StreamBuilder(
                  stream: fetchUserProfile(context).asStream(), //TODO change
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      logger.d(snapshot.error);
                      return Center(
                        child: Icon(Icons.error_outline),
                      );
                    }
                    logger.d("connection is {0}", snapshot.connectionState);
                    if (snapshot.connectionState != ConnectionState.active) {
                      return Center(child: CircularProgressIndicator());
                    }
                    UserProfile userProfileDocument =
                        UserProfile.fromJson(snapshot.data!);
                    displayProfile(userProfileDocument);
                    _socialLinks = userProfileDocument.socialLinks;

                    return Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: ColorPallet.grayBg)),
                            child: ListView(
                              children: [
                                Center(
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.white,
                                        child: Image.asset(
                                            AssetImages.userEmptyAvatar),
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
                                _SessionSubject(
                                  sessionsTopicSelected:
                                      userProfileDocument.sessionTopics,
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
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ...List.generate(
                                          userProfileDocument
                                              .socialLinks.length,
                                          (index) => Material(
                                                color: Colors.transparent,
                                                child: Container(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    child: Row(
                                                      children: _socialListChild(
                                                          userProfileDocument
                                                                  .socialLinks[
                                                              index]),
                                                    ),
                                                  ),
                                                ),
                                              )),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(50),
                                            color: ColorPallet.blue),
                                        child: IconButton(
                                          color: Colors.white,
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            Get.bottomSheet(
                                              AddNewSocialLinksBottomSheet(
                                                  socialList: _socialLinks),
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
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
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
                  }),
            ),
          ),
        ],
      ),
    );
  }

  void displayProfile(UserProfile userProfileDocument) {
    firstNameController.text = userProfileDocument.firstName;
    lastNameController.text = userProfileDocument.lastName;

    emailController.text = userProfileDocument.email;
    phoneNumController.text = userProfileDocument.phoneNumber;

    bioController.text = userProfileDocument.bio;
    eduDegreeController.text = userProfileDocument.eduDegree;
  }

  Future<UserProfile> fetchUserProfile(BuildContext context) {
    logger.d("Falling back to proxy? {0}", _authService.isFallback);
    if (_authService.isFallback) {
      return _proxyService.userProfile(_authService.currentUser!.email!);
    }
    return Provider.of<FirestoreServiceDB>(context).userProfile;
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
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                  color: Colors.yellow, style: BorderStyle.solid, width: 2)),
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

  final BottomNavigationController _controller =
      Get.put(BottomNavigationController());
  void nextStep() {
    if (_formKey.currentState!.validate()) {
      save(context);
      _controller.CheckHintStage(HintStages.CalHintHowAddAvailability);
    }
  }
}

// =============================================================================
// Session Type Future from DB --::--::--::--::--::--::--::--::--::--::--::--::-
// =============================================================================
class _SessionSubject extends StatelessWidget {
  final List<String> _options = [];
  final List sessionsTopicSelected;

  _SessionSubject({Key? key, required this.sessionsTopicSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FBAllSessionTypeService().allSessionsType,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return Text("Sessions not Available");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            List<dynamic> _o = data['type'];
            _o.forEach((e) {
              _options.add(e.toString());
            });

            return _DropDownSession(_options, sessionsTopicSelected);
          }
          // this is empty Dropdown before data fetch from Firestore
          return Stack(
            children: [
              DropDownMultiSelect(
                onChanged: (List<String> list) {},
                options: _options,
                selectedValues: [],
                whenEmpty: 'موضوع جلسات',
              ),
              Positioned(
                  top: 38,
                  right: 110,
                  child: Container(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      )))
            ],
          );
        });
  }
}

// =============================================================================
// Session DropDown    --::--::--::--::--::--::--::--::--::--::--::--::--::--::-
// =============================================================================
class _DropDownSession extends StatefulWidget {
  final List<String> options;
  final List<dynamic> selected;
  _DropDownSession(this.options, this.selected);

  @override
  _DropDownSessionState createState() =>
      _DropDownSessionState(this.options, this.selected);
}

class _DropDownSessionState extends State<_DropDownSession> {
  final List<String> _options;
  final List<dynamic> selected;
  List<String> selectedString = [];
  _DropDownSessionState(this._options, this.selected);
  List<String> listToString() {
    List<String> stringList = [];
    selected.forEach((element) {
      stringList.add(element.toString());
    });

    return stringList;
  }

  @override
  void initState() {
    print(selected);
    selectedString = listToString();
    print(selectedString);
    super.initState();
  }

  late FirestoreServiceDB _firestoreService;
  @override
  Widget build(BuildContext context) {
    _firestoreService = Provider.of<FirestoreServiceDB>(context);
    return DropDownMultiSelect(
      onChanged: (List<String> list) {
        setState(() {
          selectedString = list;
          _firestoreService.updateSessionTopic(list);
        });
      },
      options: _options,
      selectedValues: selectedString,
      whenEmpty: 'موضوع جلسات',
    );
  }
}
