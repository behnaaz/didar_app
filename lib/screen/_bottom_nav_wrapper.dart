import 'package:didar_app/Constants/them_conf.dart';
import 'package:didar_app/screen/calendar_weekly_screen.dart';
import 'package:didar_app/screen/home_screen.dart';
import 'package:didar_app/screen/profile_screen.dart';
import 'package:didar_app/screen/setting_screen.dart';
import 'package:didar_app/services/auth/authenticatService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:provider/provider.dart';



class BottomNavigationWrapper extends StatefulWidget {
  const BottomNavigationWrapper({Key? key}) : super(key: key);

  @override
  State<BottomNavigationWrapper> createState() =>
      _BottomNavigationWrapperState();
}

class _BottomNavigationWrapperState extends State<BottomNavigationWrapper> {
  int _selectedIndex = 2;

  // NOTE : Bottom navigation item widgetOptions
  final List<Widget> _widgetOptions = <Widget>[
    ProfileScreen(),
    HomeScreen(),
    // CalendarScreen(),
    CalendarWeeklyScreen(),
    SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthenticationService>(context);
    return Scaffold(
      appBar: AppBar(
        // title: Text("DIDAR"),
        title: Image.asset(
          AssetImages.logo,
          height: 45,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () async {
              await authService.signOut();
            },
            icon: Icon(Icons.exit_to_app)),
        actions: [
          GestureDetector(
            child: Container(
                width: 100,
                child: Stack(children: [
                  Center(
                      child: Image.asset(
                    AssetImages.emailIcon,
                    height: 30,
                  )),
                  Positioned(
                    bottom: 5,
                    right: 20,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: ColorPallet.red,
                          borderRadius: BorderRadiusDirectional.circular(50)),
                      child: Center(
                        child: Text(
                          '2',
                          style: TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
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
          _widgetOptions[_selectedIndex],
        ],
      ),
      bottomNavigationBar: SnakeNavigationBar.color(
        snakeShape: SnakeShape.rectangle,
        currentIndex: _selectedIndex,
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
      ),
    );
  }
}
