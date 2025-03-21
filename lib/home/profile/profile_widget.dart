import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
          child: _buildImageWidget(),
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    final double size = 128;
    // Check if the image is a network URL (Cloudinary)
    if (imagePath.startsWith('http')) {
      print('Loading network image: $imagePath');
      return CachedNetworkImage(
        imageUrl: imagePath,
        width: size,
        height: size,
        fit: BoxFit.cover,
        placeholder: (context, url) => Container(
          width: size,
          height: size,
          color: Colors.grey.shade200,
          child: Icon(
            Icons.person,
            size: 64,
            color: Colors.grey.shade400,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: size,
          height: size,
          color: Colors.grey.shade200,
          child: Icon(
            Icons.error,
            size: 64,
            color: Colors.grey.shade400,
          ),
        ),
      );
    }
    // Check if it's an asset image
    else if (imagePath.startsWith('assets')) {
      return Image.asset(
        imagePath,
        width: size,
        height: size,
        fit: BoxFit.cover,
      );
    }
    // Otherwise, it's a local file
    else {
      return Image.file(
        File(imagePath),
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: size,
            height: size,
            color: Colors.grey.shade200,
            child: Icon(
              Icons.broken_image,
              size: 64,
              color: Colors.grey.shade400,
            ),
          );
        },
      );
    }
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
//   final VoidCallback onClicked_1;

//   const ProfileWidget({
//     super.key,
//     required this.imagePath,
//     required this.onClicked_1,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final color = Colors.blue;
//     return Center(
//       child: Stack(
//         children: [
//           buildImage(),
//           Positioned(
//             bottom: 0,
//             right: 4,
//             child: buildEditIcon(color),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildImage() {
//     return ClipOval(
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: onClicked_1,
//           child: Ink.image(
//             image: imagePath.startsWith('assets')
//                 ? AssetImage(imagePath)
//                 : FileImage(File(imagePath)) as ImageProvider,
//             fit: BoxFit.cover,
//             width: 128,
//             height: 128,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildEditIcon(Color color) => GestureDetector(
//         onTap: onClicked_1, // Make edit button work
//         child: buildCircle(
//           color: Colors.white,
//           all: 3,
//           child: buildCircle(
//             color: color,
//             all: 8,
//             child: Icon(
//               Icons.edit,
//               size: 20,
//               color: Colors.white,
//             ),
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
