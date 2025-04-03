import 'package:firebase_auth/firebase_auth.dart';
import 'package:sri_traveler/services/db_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DbService _dbService = DbService();

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
