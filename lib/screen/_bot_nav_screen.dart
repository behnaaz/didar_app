import 'package:didar_app/Constants/them_conf.dart';
import 'package:flutter/material.dart';

class BottomNavScreenTest extends StatefulWidget {
  const BottomNavScreenTest({Key? key}) : super(key: key);

  @override
  State<BottomNavScreenTest> createState() => _BottomNavScreenTestState();
}

class _BottomNavScreenTestState extends State<BottomNavScreenTest> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    Center(
      child: Text(
        'Index 0: Home',
      ),
    ),
    Center(
      child: Text(
        'Index 1: Business',
      ),
    ),
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
    return Scaffold(
      body: _widgetOptions[_selectedIndex] ,
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
