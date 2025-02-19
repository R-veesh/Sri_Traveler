import 'package:flutter/material.dart';
import 'package:sri_traveler/home/profile/appBar_widget.dart';
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
          )
        ],
      ),
    );
  }
}
