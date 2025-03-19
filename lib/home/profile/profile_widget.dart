import 'dart:io';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked_1;

  const ProfileWidget({
    super.key,
    required this.imagePath,
    required this.onClicked_1,
  });

  @override
  Widget build(BuildContext context) {
    final color = Colors.blue;
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onClicked_1,
          child: Ink.image(
            image: imagePath.startsWith('assets')
                ? AssetImage(imagePath)
                : FileImage(File(imagePath)) as ImageProvider,
            fit: BoxFit.cover,
            width: 128,
            height: 128,
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => GestureDetector(
        onTap: onClicked_1, // Make edit button work
        child: buildCircle(
          color: Colors.white,
          all: 3,
          child: buildCircle(
            color: color,
            all: 8,
            child: Icon(
              Icons.edit,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      Container(
        padding: EdgeInsets.all(all),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: child,
      );
}
