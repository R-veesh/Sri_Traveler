import 'package:flutter/material.dart';
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
          ProfileWidget(
            imagePath: User.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(User),
          const SizedBox(height: 24),
          Center(
            child: buildUpgradeButton(),
          ),
          const SizedBox(height: 24),
          buildBioUser(User),
        ],
      ),
    );
  }

  buildName(User user) => Column(
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

  buildUpgradeButton() => ButtonWidget(
        text: 'Edit the profile',
        onClicked: () {},
      );
  buildBioUser(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
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
      );
}
