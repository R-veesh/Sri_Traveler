import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sri_traveler/home/profile/user.dart'; // Update with your actual path

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  // Collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // Create user data
  Future<void> createUserData({
    required String uid,
    required User user,
  }) async {
    Map<String, dynamic> userData = user.toFirestore();
    // Add timestamps
    userData['createdAt'] = FieldValue.serverTimestamp();
    userData['lastLogin'] = FieldValue.serverTimestamp();

    return await userCollection.doc(uid).set(userData);
  }

  // Update user login timestamp
  Future<void> updateUserLogin(String uid) async {
    return await userCollection.doc(uid).update({
      'lastLogin': FieldValue.serverTimestamp(),
    });
  }

  // Get user data

  Future<User?> getUserData(String email) async {
    try {
      final snapshot =
          await _db.collection('users').where('email', isEqualTo: email).get();
      return snapshot.docs.isNotEmpty
          ? User.fromSnapshot(snapshot.docs.first)
          : null;
    } catch (e) {
      print('Error fetching user data from Firestore: $e');
      return null;
    }
  }

  // Check if user exists
  Future<bool> userExists(String uid) async {
    DocumentSnapshot doc = await userCollection.doc(uid).get();
    return doc.exists;
  }

  // Update user profile
  Future<void> updateUserProfile({
    required String uid,
    required User user,
  }) async {
    return await userCollection.doc(uid).update(user.toFirestore());
  }
}
