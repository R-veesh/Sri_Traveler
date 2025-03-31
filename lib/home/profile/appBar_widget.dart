import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

AppBar buildAppBar(BuildContext context) {
  //final icon = ico.edit;
  return AppBar(
    backgroundColor: const Color.fromARGB(129, 180, 230, 255),
    elevation: 0,
    leading: BackButton(),
    actions: [
      IconButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Navigator.pushNamed(context, "/login");
        },
        icon: Icon(Icons.logout_outlined),
      ),
    ],
  );
}
