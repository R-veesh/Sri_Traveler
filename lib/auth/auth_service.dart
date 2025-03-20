import 'package:firebase_auth/firebase_auth.dart';
import 'db_Service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _dbService = DatabaseService();

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Auth change user stream
  Stream<User?> get user => _auth.authStateChanges();

  // Sign in with email & password
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Update last login timestamp in database
      if (result.user != null) {
        await _dbService.updateUserLogin(result.user!.uid);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  // Register with email & password
  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  // Password reset
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  // Check if user exists in database
  Future<bool> userExistsInDatabase() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        return await _dbService.userExists(user.uid);
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Update user profile
  Future<void> updateUserProfile({
    String? displayName,
    String? photoURL,
  }) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(displayName);
        await user.updatePhotoURL(photoURL);
      }
    } catch (e) {
      rethrow;
    }
  }
}

// import 'dart:developer';
// import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:sri_traveler/auth/db_Service.dart';

// class AuthService {
//   final _auth = FirebaseAuth.instance;

//   Future<User?> createUserWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       // await DbService().saveUserData(email: email);
//       UserCredential credential = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       return credential.user;
//       //return "Account Created";
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'email-already-in-use') {
//         log('email-already-in-use');
//       } else {
//         log(e.toString());
//       }
//       return null;
//     }
//   }

//   Future<String> loginUserWithEmailAndPassword(
//       String email, String password) async {
//     try {
//       await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       return "Login Successful";
//     } on FirebaseAuthException catch (e) {
//       return e.message.toString();
//     }
//   }

//   Future<void> signOut() async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       log("Error signing out: $e");
//     }
//   }
// }
