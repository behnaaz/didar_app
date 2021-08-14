import 'package:didar_app/Constants/them_conf.dart';
import 'package:didar_app/screen/_calendar_screen.dart';
import 'package:didar_app/screen/profile_screen.dart';
import 'package:didar_app/services/auth/authenticatService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationWrapper extends StatefulWidget {
  const BottomNavigationWrapper({Key? key}) : super(key: key);

  @override
  State<BottomNavigationWrapper> createState() =>
      _BottomNavigationWrapperState();
}

class _BottomNavigationWrapperState extends State<BottomNavigationWrapper> {
  int _selectedIndex = 0;

  // ANCHOR : Bottom navigation item widgetOptions
  static List<Widget> _widgetOptions = <Widget>[
    ProfileScreen(),
    Center(
      child: Text(
        'home screen',
      ),
    ),
    CalendarScreen(),
    Center(
      child: Text(
        'settings',
      ),
    )
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
          kImageLogo,
          height: 45,
        ),
        centerTitle: true,
        leading: Icon(Icons.email),
        actions: [
          IconButton(
              onPressed: () async {
                await authService.signOut();
              },
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.grey[900],
        selectedItemColor: kBlue,
        unselectedItemColor: Colors.grey[200],
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
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
