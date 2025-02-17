import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sri_traveler/home/Profile.dart';
import 'package:sri_traveler/home/dashbord.dart';
import 'package:sri_traveler/home/search.dart';
import 'package:sri_traveler/home/trip.dart';

class homePage extends StatefulWidget {
  // const homePage({super.key});

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _isSelectedIndex = 0;

  final List<Widget> widgetOptions = [
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
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: GNav(
          rippleColor: Colors.grey,
          hoverColor: Colors.grey,
          haptic: true,
          tabBorderRadius: 18,
          tabActiveBorder: Border.all(color: Colors.black, width: 1),
          tabBorder: Border.all(color: Colors.grey, width: 1),
          tabShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
          ],
          curve: Curves.easeOutExpo,
          duration: Duration(milliseconds: 300),
          gap: 8,
          color: Colors.grey[800],
          activeColor: Colors.purple,
          iconSize: 24,
          tabBackgroundColor: Colors.purple.withOpacity(0.1),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          tabs: [
            GButton(
              icon: LineIcons.home,
              text: 'Home',
            ),
            GButton(
              icon: LineIcons.star,
              text: 'Likes',
            ),
            GButton(
              icon: LineIcons.search,
              text: 'Search',
            ),
            GButton(
              icon: LineIcons.user,
              text: 'Profile',
            )
          ],
          selectedIndex: _isSelectedIndex,
          onTabChange: _onItemTapped,
        ),
      ),
      body: widgetOptions[_isSelectedIndex],
    );
  }
}
