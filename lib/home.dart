import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sri_traveler/home/HomeScreen.dart';
import 'package:sri_traveler/home/Profile.dart';
import 'package:sri_traveler/home/dashbord.dart';
import 'package:sri_traveler/home/search.dart';
import 'package:sri_traveler/home/TripScreen.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  // const homePage({super.key});

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _isSelectedIndex = 2;

  final List<Widget> widgetOptions = const [
    TripScreen(),
    SearchScreen(),
    HomeScreen(),
    ProfileScreen(),
    DashboardScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _isSelectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions[_isSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        unselectedItemColor: Colors.blueGrey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(LineIcons.tripadvisor),
            label: 'Trip',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.user),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
        currentIndex: _isSelectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
