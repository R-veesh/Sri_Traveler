import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sri_traveler/home/profile/profile_widget.dart';
import 'package:sri_traveler/home/profile/user_references.dart';
import 'package:sri_traveler/home/profile/user.dart';
import 'package:sri_traveler/services/user_service.dart'; // Import the new UserService

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController bioController;
  late User user;
  bool isLoading = false;

  // Create UserService
  final userService = UserService(
    cloudinaryName: 'dtgie8eha',
    // dotenv.env['dtgie8eha'] ?? '',
    cloudinaryUploadPreset: 'traveler_app_preset',
    // dotenv.env['traveler_app_preset'] ?? '',
  );

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      isLoading = true;
    });

    try {
      user = await UserReferences.fetchCurrentUser();

      // Initialize controllers with user data
      firstNameController = TextEditingController(text: user.firstName);
      lastNameController = TextEditingController(text: user.lastName);
      emailController = TextEditingController(text: user.email);
      bioController = TextEditingController(text: user.bio);
    } catch (e) {
      print('Error loading user data: $e');
      // Use default user if there's an error
      user = UserReferences.defaultUser;

      firstNameController = TextEditingController(text: user.firstName);
      lastNameController = TextEditingController(text: user.lastName);
      emailController = TextEditingController(text: user.email);
      bioController = TextEditingController(text: user.bio);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Failed to load profile data. Using default values.')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile != null) {
      setState(() {
        isLoading = true;
      });

      try {
        // Create a File object from the picked file path
        final file = File(pickedFile.path);

        // Upload to Cloudinary using our service
        await userService.uploadProfileImage(file);

        // Refresh user data
        user = await UserReferences.fetchCurrentUser();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Profile image uploaded successfully')),
        );
      } catch (e) {
        print('Error uploading image: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image. Please try again.')),
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> _saveProfile() async {
    final newFirstName = firstNameController.text.trim();
    final newLastName = lastNameController.text.trim();
    final newEmail = emailController.text.trim();
    final newBio = bioController.text.trim();

    if (newFirstName.isEmpty || newLastName.isEmpty || newEmail.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('First name, last name, and email cannot be empty')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Use the UserService to update the profile
      await userService.updateUserProfile(
        firstName: newFirstName,
        lastName: newLastName,
        bio: newBio,
      );

      // Update email separately if it changed
      if (newEmail != user.email) {
        // This would typically be handled by your auth service
        // For now, we'll just show a message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Email updates require re-authentication and are not implemented in this demo')),
        );
      }

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
                    label: 'First Name',
                    controller: firstNameController,
                    icon: Icons.person,
                  ),
                  SizedBox(height: 16),
                  buildTextField(
                    label: 'Last Name',
                    controller: lastNameController,
                    icon: Icons.person_outline,
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
