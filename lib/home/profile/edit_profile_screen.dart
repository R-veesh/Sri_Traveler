import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  @override
  void initState() {
    super.initState();
    user = UserReferences.myUser;
    nameController = TextEditingController(text: user.name);
    emailController = TextEditingController(text: user.email);
    bioController = TextEditingController(text: user.bio);
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        user = user.copyWith(imagePath: pickedFile.path);
      });
    }
  }

  void _saveProfile() {
    setState(() {
      user = user.copyWith(
        name: nameController.text,
        email: emailController.text,
        bio: bioController.text,
      );
      UserReferences.updateUser(user);
    });
    Navigator.pop(context); // Go back to Profile Screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProfileWidget(
              imagePath: user.imagePath,
              onClicked_1: _pickImage,
            ),
            SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: bioController,
              decoration: InputDecoration(labelText: 'Bio'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveProfile,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
