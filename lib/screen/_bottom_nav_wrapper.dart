import 'package:didar_app/constants/them_conf.dart';
import 'package:didar_app/controller/bottom_navigation_controller.dart';
import 'package:didar_app/routes/routes.dart';
import 'package:didar_app/screen/profile/profile_screen.dart';
import 'package:didar_app/screen/session/sessions_screen.dart';
import 'package:didar_app/screen/setting_screen.dart';
import 'package:didar_app/services/auth/authenticatService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:didar_app/screen/calendar_weekly_screen.dart';
import 'package:didar_app/screen/home_screen.dart';

class BottomNavigationWrapper extends StatefulWidget {
  const BottomNavigationWrapper({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigationWrapper> createState() =>
      _BottomNavigationWrapperState();
}

class _BottomNavigationWrapperState extends State<BottomNavigationWrapper> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // NOTE : Bottom navigation item widgetOptions
  final List<Widget> _widgetOptions = <Widget>[
    ProfileScreen(),
    SessionsScreen(),
    HomeScreen(),
    CalendarWeeklyScreen(),
    SettingScreen(),
  ];
  final BottomNavigationController _controller = Get.put(BottomNavigationController());

  void _onItemTapped(int index) {
    setState(() {
      _controller.bottomNavigateTrigger(index);
    });
  }

  @override
  void initState() {
    if (Get.arguments == 'HintActive') {
      _controller.bottomNavigateTrigger(0);
      _controller.toggleHint();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                height: 160,
                color: Colors.white,
                child: Center(
                  child: Image.asset(
                    AssetImages.logo,
                    height: 60,
                  ),
                ),
              ),
            ),
            Expanded(
                child: Container(
              color: ColorPallet.blue,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      'درباره ما',
                      style: MyTextStyle.large.copyWith(color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                      'تماس با ما',
                      style: MyTextStyle.large.copyWith(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      await authService.signOut();
                      Get.offAllNamed(LOGIN_ROUTE);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.exit_to_app,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'خروج',
                            style:
                                MyTextStyle.large.copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
      appBar: AppBar(
        title: Image.asset(
          AssetImages.logo,
          height: 40,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(Icons.more_vert)),
        actions: [
          GestureDetector(
            onTap: () {
              // this is Simpler way , I Use GETx package for navigate and stateManaging
              // Checkout https://pub.dev/packages/get for more Information.
              Get.toNamed(MESSAGE_ROUTE);
              // Navigator.pushNamed(context, routeMessages);
              print('message button clicked');
            },
            child: Container(
                width: 65,
                child: Stack(children: [
                  Center(
                      child: Image.asset(
                    AssetImages.emailIcon,
                    height: 25,
                  )),
                  Positioned(
                    bottom: 9,
                    right: 8,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                          color: ColorPallet.red,
                          borderRadius: BorderRadiusDirectional.circular(50)),
                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ])),
          )
        ],
      ),
      body: Stack(
        children: [
          Center(
              child: Image.asset(
            AssetImages.patternAuthBg,
            fit: BoxFit.cover,
          )),
          // NOTE : this is a body Injection screen Widget

          GetBuilder<BottomNavigationController>(
            init: BottomNavigationController(),
            initState: (_) {},
            builder: (controller) {
              return _widgetOptions[controller.pageIndex.toInt()];
            },
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<BottomNavigationController>(
        init: BottomNavigationController(),
        initState: (_) {},
        builder: (_) {
          return SnakeNavigationBar.color(
            snakeShape: SnakeShape.rectangle,
            currentIndex: _.pageIndex.toInt(),
            onTap: _onItemTapped,
            backgroundColor: Colors.grey[200],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey[900],
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                label: "Profile",
                icon: Icon(Icons.person),
              ),
              BottomNavigationBarItem(
                label: "sessions",
                icon: Icon(Icons.chair_rounded),
              ),
              BottomNavigationBarItem(
                label: "Home",
                icon: Icon(Icons.home),
              ),
              BottomNavigationBarItem(
                label: "calendar",
                icon: Icon(Icons.calendar_today),
              ),
              BottomNavigationBarItem(
                label: "Setting",
                icon: Icon(
                  Icons.settings,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
