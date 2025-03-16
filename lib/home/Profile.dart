import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sri_traveler/home/profile/appBar_widget.dart';
import 'package:sri_traveler/home/profile/profile_widget.dart';
import 'package:sri_traveler/home/profile/user.dart';
import 'package:sri_traveler/home/profile/user_references.dart';
import 'package:sri_traveler/home/profile/edit_profile_screen.dart'; // Import EditProfileScreen

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = UserReferences.myUser; // Fixed variable name

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked_1: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()),
              );
              setState(() {});
            },
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          buildSocialMediaLinks(),
          const SizedBox(height: 24),
          buildBioUser(user),
          const SizedBox(height: 24),
          // Center(
          //   child: buildEditProfileButton(),
          // ),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      );

  // Widget buildEditProfileButton() => ButtonWidget(
  //       text: 'Edit Profile',
  //       onClicked: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => EditProfileScreen()),
  //         ).then((_) {
  //           // Refresh after returning from edit screen
  //           setState(() {});
  //         });
  //       },
  //     );

  Widget buildSocialMediaLinks() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(LineIcons.facebook),
            color: Colors.blue,
            iconSize: 40,
            onPressed: () {
              // Add your Facebook link here
            },
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: Icon(LineIcons.twitter),
            color: Colors.lightBlue,
            iconSize: 40,
            onPressed: () {
              // Add your Twitter link here
            },
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: Icon(LineIcons.instagram),
            color: Colors.purple,
            iconSize: 40,
            onPressed: () {
              // Add your Instagram link here
            },
          ),
        ],
      );

  Widget buildBioUser(User user) => Card(
        margin: EdgeInsets.symmetric(horizontal: 48),
        shadowColor: Colors.black,
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Text(
                user.bio,
                style: TextStyle(fontSize: 16, height: 1.4),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
}
