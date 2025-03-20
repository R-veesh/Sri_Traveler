import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  // Create user data
  Future<void> createUserData({
    required String uid,
    required String firstName,
    required String lastName,
    required String email,
    required DateTime dateOfBirth,
    required int age,
  }) async {
    return await userCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'fullName': '$firstName $lastName',
      'email': email,
      'dateOfBirth': dateOfBirth,
      'age': age,
      'createdAt': FieldValue.serverTimestamp(),
      'lastLogin': FieldValue.serverTimestamp(),
      'profileImageUrl': '',
      'bio': '',
      'isDarkMode': false,
    });
  }

  // Update user login timestamp
  Future<void> updateUserLogin(String uid) async {
    return await userCollection.doc(uid).update({
      'lastLogin': FieldValue.serverTimestamp(),
    });
  }

  // Get user data
  Future<DocumentSnapshot> getUserData(String uid) async {
    return await userCollection.doc(uid).get();
  }

  // Check if user exists
  Future<bool> userExists(String uid) async {
    DocumentSnapshot doc = await userCollection.doc(uid).get();
    return doc.exists;
  }

  // Update user profile
  Future<void> updateUserProfile({
    required String uid,
    String? firstName,
    String? lastName,
    String? profileImageUrl,
    String? bio,
    bool? isDarkMode,
  }) async {
    Map<String, dynamic> data = {};

    if (firstName != null) data['firstName'] = firstName;
    if (lastName != null) data['lastName'] = lastName;
    if (firstName != null || lastName != null) {
      data['fullName'] = '${firstName ?? ''} ${lastName ?? ''}'.trim();
    }
    if (profileImageUrl != null) data['profileImageUrl'] = profileImageUrl;
    if (bio != null) data['bio'] = bio;
    if (isDarkMode != null) data['isDarkMode'] = isDarkMode;

    if (data.isNotEmpty) {
      return await userCollection.doc(uid).update(data);
    }
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class DbService {
//   User? user = FirebaseAuth.instance.currentUser;

//   // USER DATA
//   Future saveUserData({required String name, required String email}) async {
//     try {
//       Map<String, dynamic> data = {
//         "name": name,
//         "email": email,
//       };
//       await FirebaseFirestore.instance
//           .collection("users")
//           .doc(user!.uid)
//           .set(data);
//     } catch (e) {}
//   }
// }
