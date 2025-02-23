import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sri_traveler/home/profile/appBar_widget.dart';
import 'package:sri_traveler/home/profile/button_widget.dart';
import 'package:sri_traveler/home/profile/profile_widget.dart';
import 'package:sri_traveler/home/profile/user.dart';
import 'package:sri_traveler/home/profile/user_references.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final User = UserReferences.myUser;

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: User.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(User),
          const SizedBox(height: 24),
          buildSocialMediaLinks(),
          const SizedBox(height: 24),
          buildBioUser(User),
          const SizedBox(height: 24),
          // Center(
          //   child: buildUpgradeButton(),
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

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Edit the profile',
        onClicked: () {},
      );
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
