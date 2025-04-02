import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DbService {
  User? user = FirebaseAuth.instance.currentUser;
  //late final CloudinaryService _cloudinaryService;

  // Initialize Cloudinary service
  // DbService({
  //   required String cloudinaryName,
  //   required String cloudinaryUploadPreset,
  // }) : _cloudinaryService = CloudinaryService(
  //         cloudName: cloudinaryName,
  //         uploadPreset: cloudinaryUploadPreset,
  //       );

  // Create user data
  Future saveUserData({required String name, required String email}) async {
    try {
      Map<String, dynamic> data = {
        'name': name,
        'email': email,
      };
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .set(data);
    } catch (e) {
      print("Error while saving user data : $e");
    }
  }

  Future updateUserData({required Map<String, dynamic> extraData}) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .update(extraData);
  }

  Stream<DocumentSnapshot> readUserData() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .snapshots();
  }

  // Get user data
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      print("Error while fetching user data : $e");
      return null;
    }
  }

  // // Update user profile
  // Future<void> uploadProfileImage(File imageFile) async {
  //   // Initialize Cloudinary service
  //   final imageUrl = await _cloudinaryService.uploadImage(imageFile);

  //   // Update with new image URL
  //   // Update user profile image URL in Firestore
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(user!.uid)
  //       .update({'imagePath': imageUrl});
  // }

  // Future<void> updateUserProfile({
  //   required String firstName,
  //   required String lastName,
  //   required String bio,
  // }) async {
  //   if (user == null) {
  //     throw Exception('User is not authenticated');
  //   }

  //   // Create a map with the updated user data
  //   Map<String, dynamic> updatedData = {
  //     'firstName': firstName,
  //     'lastName': lastName,
  //     'bio': bio,
  //   };

  //   try {
  //     // Update Firestore user profile
  //     await FirebaseFirestore.instance.collection('users').doc(user!.uid).update(updatedData);
  //   } catch (e) {
  //     print('Error updating user profile: $e');
  //     throw Exception('Failed to update profile');
  //   }
  // }
}
