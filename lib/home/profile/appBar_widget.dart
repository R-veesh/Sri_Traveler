import 'package:flutter/material.dart';
import 'package:sri_traveler/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

AppBar buildAppBar(BuildContext context) {
  //final icon = ico.edit;
  return AppBar(
    backgroundColor: const Color.fromARGB(255, 230, 227, 68),
    elevation: 0,
    leading: BackButton(),
    actions: [
      IconButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushNamed(context, "/login");
        },
        icon: Icon(Icons.dark_mode_rounded),
      ),
    ],
  );
}
