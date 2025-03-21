// lib/services/user_service.dart
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:sri_traveler/home/profile/user.dart'; // Update with your actual path
import 'package:sri_traveler/auth/db_Service.dart'; // Update with your actual path
import 'package:sri_traveler/auth/cloudinary_service.dart';
import 'package:sri_traveler/home/profile/user_references.dart'; // Update with your actual path

class UserService {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final DatabaseService _databaseService = DatabaseService();
  final CloudinaryService _cloudinaryService;

  UserService({
    required String cloudinaryName,
    required String cloudinaryUploadPreset,
  }) : _cloudinaryService = CloudinaryService(
          cloudName: cloudinaryName,
          uploadPreset: cloudinaryUploadPreset,
        );

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  // Check if user is logged in
  bool get isLoggedIn => _auth.currentUser != null;

  // Create new user
  Future<void> createUser({
    required String firstName,
    required String lastName,
    required String email,
    required DateTime dateOfBirth,
  }) async {
    if (currentUserId == null) throw Exception('User not authenticated');

    final age = DateTime.now().year - dateOfBirth.year;

    final user = User(
      firstName: firstName,
      lastName: lastName,
      email: email,
      dateOfBirth: dateOfBirth,
      age: age,
    );

    await _databaseService.createUserData(
      uid: currentUserId!,
      user: user,
    );

    // Update local reference
    UserReferences.currentUser = user;
  }

  // Update user profile
  Future<void> updateUserProfile({
    String? firstName,
    String? lastName,
    String? bio,
    bool? isDarkMode,
  }) async {
    if (currentUserId == null) throw Exception('User not authenticated');

    // Get current user data
    User currentUser = await UserReferences.fetchCurrentUser();

    // Update with new values
    User updatedUser = currentUser.copyWith(
      firstName: firstName,
      lastName: lastName,
      bio: bio,
      isDarkMode: isDarkMode,
    );

    // Save to Firebase and local state
    await UserReferences.updateUser(updatedUser);
  }

  // Upload profile image
  Future<void> uploadProfileImage(File imageFile) async {
    if (currentUserId == null) throw Exception('User not authenticated');

    // Upload to Cloudinary
    final imageUrl = await _cloudinaryService.uploadImage(imageFile);

    // Get current user data
    User currentUser = await UserReferences.fetchCurrentUser();

    // Update with new image URL
    User updatedUser = currentUser.copyWith(
      imagePath: imageUrl,
    );

    // Save to Firebase and local state
    await UserReferences.updateUser(updatedUser);
  }

  // Get current user data
  Future<User> getCurrentUser() async {
    return await UserReferences.fetchCurrentUser();
  }
}
