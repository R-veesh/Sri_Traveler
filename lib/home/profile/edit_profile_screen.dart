import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:sri_traveler/home/profile/profile_widget.dart';
import 'package:sri_traveler/home/profile/user_references.dart';
import 'package:sri_traveler/home/profile/user.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController bioController;
  late User user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    user = UserReferences.myUser;
    nameController = TextEditingController(text: user.name);
    emailController = TextEditingController(text: user.email);
    bioController = TextEditingController(text: user.bio);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        isLoading = true;
      });

      try {
        // Upload image to Firebase Storage
        final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          final storageRef = FirebaseStorage.instance
              .ref()
              .child('profile_images')
              .child('${currentUser.uid}.jpg');

          await storageRef.putFile(File(pickedFile.path));
          final downloadUrl = await storageRef.getDownloadURL();

          setState(() {
            user = user.copyWith(imagePath: downloadUrl);
            isLoading = false;
          });
        } else {
          // Just use local path if not logged in
          setState(() {
            user = user.copyWith(imagePath: pickedFile.path);
            isLoading = false;
          });
        }
      } catch (e) {
        print('Error uploading image: $e');
        setState(() {
          user = user.copyWith(imagePath: pickedFile.path);
          isLoading = false;
        });
      }
    }
  }

  Future<void> _saveProfile() async {
    final newName = nameController.text.trim();
    final newEmail = emailController.text.trim();
    final newBio = bioController.text.trim();

    if (newName.isEmpty || newEmail.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Name and email cannot be empty')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Update user object
      user = user.copyWith(
        name: newName,
        email: newEmail,
        bio: newBio,
      );

      // Save to Firebase
      await UserReferences.updateUser(user);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully')),
      );

      Navigator.pop(context); // Go back to Profile Screen
    } catch (e) {
      print('Error saving profile: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: ${e.toString()}')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: const Color.fromARGB(255, 230, 227, 68),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ProfileWidget(
                    imagePath: user.imagePath,
                    onClicked_1: _pickImage,
                  ),
                  SizedBox(height: 24),
                  buildTextField(
                    label: 'Full Name',
                    controller: nameController,
                    icon: Icons.person,
                  ),
                  SizedBox(height: 16),
                  buildTextField(
                    label: 'Email',
                    controller: emailController,
                    icon: Icons.email,
                  ),
                  SizedBox(height: 16),
                  buildTextField(
                    label: 'About',
                    controller: bioController,
                    icon: Icons.info,
                    maxLines: 5,
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 230, 227, 68),
                      foregroundColor: Colors.black,
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 230, 227, 68),
            width: 2,
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:sri_traveler/home/profile/profile_widget.dart';
// import 'package:sri_traveler/home/profile/user_references.dart';
// import 'package:sri_traveler/home/profile/user.dart';

// class EditProfileScreen extends StatefulWidget {
//   @override
//   _EditProfileScreenState createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   late TextEditingController nameController;
//   late TextEditingController emailController;
//   late TextEditingController bioController;
//   late User user;

//   @override
//   void initState() {
//     super.initState();
//     user = UserReferences.myUser;
//     nameController = TextEditingController(text: user.name);
//     emailController = TextEditingController(text: user.email);
//     bioController = TextEditingController(text: user.bio);
//   }

//   Future<void> _pickImage() async {
//     final pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickedFile != null) {
//       setState(() {
//         user = user.copyWith(imagePath: pickedFile.path);
//       });
//     }
//   }

//   void _saveProfile() {
//     setState(() {
//       user = user.copyWith(
//         name: nameController.text,
//         email: emailController.text,
//         bio: bioController.text,
//       );
//       UserReferences.updateUser(user);
//     });
//     Navigator.pop(context); // Go back to Profile Screen
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Edit Profile')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ProfileWidget(
//               imagePath: user.imagePath,
//               onClicked_1: _pickImage,
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: nameController,
//               decoration: InputDecoration(labelText: 'Name'),
//             ),
//             TextField(
//               controller: emailController,
//               decoration: InputDecoration(labelText: 'Email'),
//             ),
//             TextField(
//               controller: bioController,
//               decoration: InputDecoration(labelText: 'Bio'),
//               maxLines: 3,
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _saveProfile,
//               child: Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
