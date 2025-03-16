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
    final imageWidget = imagePath.startsWith('assets')
        ? Image.asset(imagePath, fit: BoxFit.cover, width: 128, height: 128)
        : Image.file(File(imagePath),
            fit: BoxFit.cover, width: 128, height: 128);

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

// import 'dart:io';
// import 'package:flutter/material.dart';

// class ProfileWidget extends StatelessWidget {
//   final String imagePath;
//   final VoidCallback onClicked;

//   const ProfileWidget({
//     super.key,
//     required this.imagePath,
//     required this.onClicked,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final image = imagePath.startsWith('assets')
//         ? AssetImage(imagePath) as ImageProvider
//         : FileImage(File(imagePath));

//     return Center(
//       child: Stack(
//         children: [
//           ClipOval(
//             child: Material(
//               color: Colors.transparent,
//               child: Ink.image(
//                 image: image,
//                 fit: BoxFit.cover,
//                 width: 128,
//                 height: 128,
//                 child: InkWell(onTap: onClicked),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             right: 4,
//             child: buildEditIcon(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildEditIcon() => CircleAvatar(
//         radius: 16,
//         backgroundColor: Colors.blue,
//         child: Icon(Icons.edit, size: 18, color: Colors.white),
//       );

// }

//

//21V

// import 'package:flutter/material.dart';

// class ProfileWidget extends StatelessWidget {
//   final String imagePath;
//   final VoidCallback onClicked;
//   final double imageSize;
//   final double editIconSize;

//   const ProfileWidget({
//     super.key,
//     required this.imagePath,
//     required this.onClicked,
//     this.imageSize = 128,
//     this.editIconSize = 24,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Stack(
//         children: [
//           buildImage(),
//           Positioned(
//             bottom: 0,
//             right: 4,
//             child: buildEditIcon(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildImage() {
//     final isNetworkImage = imagePath.startsWith('http');
//     final image = isNetworkImage
//         ? NetworkImage(imagePath)
//         : AssetImage(imagePath) as ImageProvider;

//     return ClipOval(
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onClicked,
//           child: Ink.image(
//             image: image,
//             fit: BoxFit.cover,
//             width: imageSize,
//             height: imageSize,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildEditIcon() => buildCircle(
//         color: Colors.white,
//         all: 3,
//         child: buildCircle(
//           color: Colors.blue, // You can change the color
//           all: 8,
//           child: Icon(
//             Icons.edit,
//             size: editIconSize,
//             color: Colors.white,
//           ),
//         ),
//       );

//   Widget buildCircle({
//     required Widget child,
//     required double all,
//     required Color color,
//   }) =>
//       Container(
//         padding: EdgeInsets.all(all),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: color,
//         ),
//         child: child,
//       );
// }
//
//V20
//
// import 'package:flutter/material.dart';

// class ProfileWidget extends StatelessWidget {
//   final String imagePath;
//   final VoidCallback onClicked;

//   const ProfileWidget({
//     super.key,
//     required this.imagePath,
//     required this.onClicked,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final color = Colors.blue; // Set a default color
//     return Center(
//       child: Stack(
//         children: [
//           buildImage(),
//           Positioned(
//             bottom: 0,
//             right: 4,
//             child: buildEditIcon(color),
//           )
//         ],
//       ),
//     );
//   }

//   Widget buildImage() {
//     final image = AssetImage(imagePath);
//     return ClipOval(
//       child: Material(
//         color: Colors.transparent,
//         child: Ink.image(
//           image: image,
//           fit: BoxFit.cover,
//           width: 128,
//           height: 128,
//           child: InkWell(
//             onTap: onClicked,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildEditIcon(Color color) => buildCircle(
//         color: Colors.white,
//         all: 3,
//         child: buildCircle(
//           color: color,
//           all: 8,
//           child: Icon(
//             Icons.edit,
//             size: 20,
//             color: Colors.white,
//           ),
//         ),
//       );

//   Widget buildCircle({
//     required Widget child,
//     required double all,
//     required Color color,
//   }) =>
//       Container(
//         padding: EdgeInsets.all(all),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: color,
//         ),
//         child: child,
//       );
// }
