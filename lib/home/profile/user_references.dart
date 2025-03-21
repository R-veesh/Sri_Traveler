import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sri_traveler/home/profile/user.dart';

class UserReferences {
  static User myUser = User(
    imagePath: 'assets/default_profile.png',
    name: 'Default User',
    email: 'user@example.com',
    bio: 'Bio goes here',
    isDarkMode: false,
  );

  static Future<void> updateUser(User user) async {
    // Update local reference
    myUser = user;

    // Update in Firestore
    final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .update({
          'imagePath': user.imagePath,
          'name': user.name,
          'email': user.email,
          'bio': user.bio,
          'isDarkMode': user.isDarkMode,
        });

        // Update Firebase Auth display name if changed
        if (currentUser.displayName != user.name) {
          await currentUser.updateDisplayName(user.name);
        }

        // Update Firebase Auth email if changed
        if (currentUser.email != user.email) {
          await currentUser.updateEmail(user.email);
        }
      } catch (e) {
        print('Error updating user: $e');
      }
    }
  }

  static Future<User> fetchCurrentUser() async {
    final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        if (doc.exists && doc.data() != null) {
          final data = doc.data()!;
          return User(
            imagePath: data['imagePath'] ?? '', //test
            name: data['name'] ?? currentUser.displayName ?? 'Traveler',
            email: data['email'] ?? currentUser.email ?? '',
            bio: data['bio'] ?? 'Hello! I love traveling.',
            isDarkMode: data['isDarkMode'] ?? false,
          );
        }
      } catch (e) {
        print('Error fetching user: $e');
      }
    }

    return myUser;
  }
}
