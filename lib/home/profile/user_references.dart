// import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
// import 'package:sri_traveler/home/profile/user.dart';
// import 'package:sri_traveler/auth/db_Service.dart';

// class UserReferences {
//   static User defaultUser = User(
//     firstName: 'Default',
//     lastName: 'User',
//     email: 'user@example.com',
//     imagePath: '',
//     bio: 'Bio goes here',
//     isDarkMode: false,
//   );

//   static User currentUser = defaultUser;
//   static final DatabaseService _databaseService = DatabaseService();

//   // Update user in both local state and Firestore
//   static Future<void> updateUser(User user) async {
//     // Update local reference
//     currentUser = user;

//     // Update in Firestore
//     final currentAuthUser = firebase_auth.FirebaseAuth.instance.currentUser;
//     if (currentAuthUser != null) {
//       try {
//         await _databaseService.updateUserProfile(
//           uid: currentAuthUser.uid,
//           user: user,
//         );

//         // Update Firebase Auth display name if changed
//         if (currentAuthUser.displayName != user.fullName) {
//           await currentAuthUser.updateDisplayName(user.fullName);
//         }

//         // Update Firebase Auth email if changed
//         if (currentAuthUser.email != user.email) {
//           await currentAuthUser.verifyBeforeUpdateEmail(user.email);
//         }
//       } catch (e) {
//         print('Error updating user: $e');
//         throw e;
//       }
//     } else {
//       print("No authenticated user found while updating.");
//     }
//   }

//   static Future<User> fetchCurrentUser() async {
//     final currentAuthUser = firebase_auth.FirebaseAuth.instance.currentUser;

//     if (currentAuthUser != null) {
//       try {
//         final user = await _databaseService.getUserData(currentAuthUser.uid);
//         if (user != null) {
//           currentUser = user;
//           return user;
//         }
//       } catch (e) {
//         print('Error fetching user: $e');
//       }
//     }

//     return currentUser;
//   }
// }
