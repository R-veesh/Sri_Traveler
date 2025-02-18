import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sri_traveler/home/Profile.dart';
import 'package:sri_traveler/home/dashbord.dart';
import 'package:sri_traveler/home/search.dart';
import 'package:sri_traveler/home/trip.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  // const homePage({super.key});

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _isSelectedIndex = 0;

  final List<Widget> widgetOptions = const [
    ProfileScreen(),
    SearchScreen(),
    Center(child: Text("data", style: TextStyle(fontSize: 24))),
    DashboardScreen(),
    TripScreen(),
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
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.blueGrey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(LineIcons.user),
            label: 'Profile',
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
            icon: Icon(Icons.settings),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.heart),
            label: 'Trip',
          ),
        ],
        currentIndex: _isSelectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
