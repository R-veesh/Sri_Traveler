import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        alignment: Alignment.bottomCenter,
        child: GNav(
          // navigation bar color
          rippleColor: Colors.grey, // tab button ripple color when pressed
          hoverColor: Colors.grey, // tab button hover color
          haptic: true, // haptic feedback
          tabBorderRadius: 18,
          tabActiveBorder:
              Border.all(color: Colors.black, width: 1), // tab button border
          tabBorder:
              Border.all(color: Colors.grey, width: 1), // tab button border
          tabShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)
          ], // tab button shadow
          curve: Curves.easeOutExpo, // tab animation curves
          duration: Duration(milliseconds: 9), // tab animation duration
          gap: 8, // the tab button gap between icon and text
          color: Colors.grey[800], // unselected icon color
          activeColor: Colors.purple, // selected icon and text color
          iconSize: 24, // tab button icon size
          tabBackgroundColor:
              Colors.purple.withOpacity(0.1), // selected tab background color
          padding: EdgeInsets.symmetric(
              horizontal: 20, vertical: 5), // navigation bar padding
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
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                  //

                  ),
            ],
          ),
        ],
      ),
    );
  }
}
