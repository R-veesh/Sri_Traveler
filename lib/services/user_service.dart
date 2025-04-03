import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sri_traveler/auth/cloudinary_service.dart';

class UserService {
  final CloudinaryService _cloudinaryService;
  User? user = FirebaseAuth.instance.currentUser;

  // Get current user ID
  String? get currentUserId => user?.uid;

  //get cloudinary instance
  UserService({
    required String cloudinaryName,
    required String cloudinaryUploadPreset,
  }) : _cloudinaryService = CloudinaryService(
          cloudName: cloudinaryName,
          uploadPreset: cloudinaryUploadPreset,
        );

  // Update user profile
  Future<void> updateUserProfile({
    required String firstName,
    required String lastName,
    required String bio,
    required String isDarkMode,
  }) async {
    if (user == null) {
      throw Exception('User is not authenticated');
    }

    // Create a map with the updated user data
    Map<String, dynamic> updatedData = {
      'firstName': firstName,
      'lastName': lastName,
      'fullName': '$firstName $lastName',
      'bio': bio,
      'isDarkMode': isDarkMode,
    };

    try {
      // Update Firestore user profile
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update(updatedData);
    } catch (e) {
      print('Error updating user profile: $e');
      throw Exception('Failed to update profile');
    }
  }

  // Update user profile image
  Future<void> uploadProfileImage(File imageFile) async {
    // Initialize Cloudinary service
    final imageUrl = await _cloudinaryService.uploadImage(imageFile);

    // Update with new image URL
    // Update user profile image URL in Firestore
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update({'imagePath': imageUrl});
  }
}
