import 'package:didar_app/Constants/them_conf.dart';
import 'package:didar_app/auth/authenticatService.dart';
import 'package:didar_app/screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationWrapper extends StatefulWidget {
  const BottomNavigationWrapper({Key? key}) : super(key: key);

  @override
  State<BottomNavigationWrapper> createState() => _BottomNavigationWrapperState();
}

class _BottomNavigationWrapperState extends State<BottomNavigationWrapper> {
  int _selectedIndex = 1;
  static List<Widget> _widgetOptions = <Widget>[
    ProfileScreen(),
    HomeInputsTest(),
    Center(
      child: Text(
        'Index 2: School',
      ),
    ),
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
