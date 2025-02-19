import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {
  //final icon = ico.edit;
  return AppBar(
    backgroundColor: Colors.transparent,
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
