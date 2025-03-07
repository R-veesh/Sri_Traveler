import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sri_traveler/auth/db_Service.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      // await DbService().saveUserData(email: email);
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
      //return "Account Created";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        log('email-already-in-use');
      } else {
        log(e.toString());
      }
    }
  }

  Future<String> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return "Login Successful";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Error signing out: $e");
    }
  }
}
