import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:sri_traveler/auth/db_Service.dart';

class User {
  String? uid;
  String firstName;
  String lastName;
  String email;
  String imagePath;
  String bio;
  bool isDarkMode;
  DateTime? dateOfBirth;
  int? age;
  DateTime? createdAt;
  DateTime? lastLogin;

  // Computed property for full name
  String get fullName => '$firstName $lastName';

  User({
    this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.imagePath = '',
    this.bio = '',
    this.isDarkMode = false,
    this.dateOfBirth,
    this.age,
    this.createdAt,
    this.lastLogin,
  });
  // Create from Firestore document
  factory User.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return User(
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      email: data['email'] ?? '',
      imagePath: data['imagePath'] ?? '',
      bio: data['bio'] ?? '',
      isDarkMode: data['isDarkMode'] ?? false,
      dateOfBirth: data['dateOfBirth'] != null
          ? (data['dateOfBirth'] as Timestamp).toDate()
          : null,
      age: data['age'],
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      lastLogin: data['lastLogin'] != null
          ? (data['lastLogin'] as Timestamp).toDate()
          : null,
    );
  }

  // Convert to Firestore data
  Map<String, dynamic> toFirestore() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'email': email,
      'imagePath': imagePath,
      'bio': bio,
      'isDarkMode': isDarkMode,
      if (dateOfBirth != null) 'dateOfBirth': dateOfBirth,
      if (age != null) 'age': age,
      // Don't include createdAt and lastLogin here as they're managed separately
    };
  }

  User copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? imagePath,
    String? bio,
    bool? isDarkMode,
    DateTime? dateOfBirth,
    int? age,
  }) {
    return User(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      imagePath: imagePath ?? this.imagePath,
      bio: bio ?? this.bio,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      age: age ?? this.age,
      createdAt: this.createdAt,
      lastLogin: this.lastLogin,
    );
  }
}
