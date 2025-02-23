import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  //final icon = ico.edit;
  return AppBar(
    backgroundColor: const Color.fromARGB(255, 230, 227, 68),
    elevation: 0,
    leading: BackButton(),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.dark_mode_rounded),
      ),
    ],
  );
}
