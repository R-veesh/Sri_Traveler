import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sri_traveler/auth/cloudinary_service.dart';

class UserService {
//   final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
//   final DatabaseService _databaseService = DatabaseService();
  final CloudinaryService _cloudinaryService;
  User? user = FirebaseAuth.instance.currentUser;

  // Get current user ID
  String? get currentUserId => user?.uid;

  UserService({
    required String cloudinaryName,
    required String cloudinaryUploadPreset,
  }) : _cloudinaryService = CloudinaryService(
          cloudName: cloudinaryName,
          uploadPreset: cloudinaryUploadPreset,
        );

//   // Get current user ID
//   String? get currentUserId => _auth.currentUser?.uid;

//   // Check if user is logged in
//   bool get isLoggedIn => _auth.currentUser != null;

//   // Create new user
//   Future<void> createUser({
//     required String firstName,
//     required String lastName,
//     required String email,
//     required DateTime dateOfBirth,
//   }) async {
//     if (currentUserId == null) throw Exception('User not authenticated');

//     final age = DateTime.now().year - dateOfBirth.year;

//     final user = User(
//       firstName: firstName,
//       lastName: lastName,
//       email: email,
//       dateOfBirth: dateOfBirth,
//       age: age,
//     );

//     await _databaseService.createUserData(
//       uid: currentUserId!,
//       user: user,
//     );

//     // Update local reference
//     UserReferences.currentUser = user;
//   }

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

  // Upload profile image
  //  Future<void> uploadProfileImage(File imageFile) async {
  //    if (currentUserId == null) throw Exception('User not authenticated');

  //    // Upload to Cloudinary
  //    final imageUrl = await _cloudinaryService.uploadImage(imageFile);

  // Get current user data
//     User currentUser = await UserReferences.fetchCurrentUser();

//     // Update with new image URL
//     User updatedUser = currentUser.copyWith(
//       imagePath: imageUrl,
//     );

//     // Save to Firebase and local state
//     await UserReferences.updateUser(updatedUser);
//   }

//   // Get current user data
//   Future<User> getCurrentUser() async {
//     return await UserReferences.fetchCurrentUser();
//   }

  // Update user profile
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
