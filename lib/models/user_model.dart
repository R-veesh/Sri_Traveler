import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String firstName;
  String lastName;
  String email;
  String? imagePath;
  String? bio;
  bool? isDarkMode;
  DateTime dateOfBirth;
  int age;
  DateTime createdAt;
  DateTime lastLogin;

  String get fullName => '$firstName $lastName';

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.imagePath,
    this.bio,
    this.isDarkMode,
    required this.dateOfBirth,
    required this.age,
    required this.createdAt,
    required this.lastLogin,
  });

  // Modify the fromJson constructor to handle Timestamp
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      imagePath: json['imagePath'],
      bio: json['bio'],
      isDarkMode: _parseBool(json['isDarkMode']),
      dateOfBirth: (json['dateOfBirth'] is Timestamp)
          ? (json['dateOfBirth'] as Timestamp).toDate()
          : DateTime.parse(json['dateOfBirth']),
      age: json['age'] ?? 0,
      createdAt: (json['createdAt'] is Timestamp)
          ? (json['createdAt'] as Timestamp).toDate()
          : DateTime.parse(json['createdAt']),
      lastLogin: (json['lastLogin'] is Timestamp)
          ? (json['lastLogin'] as Timestamp).toDate()
          : DateTime.parse(json['lastLogin']),
    );
  }
  // Helper method to parse boolean values from Firestore
  static bool? _parseBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value; // Return directly if it's already a bool
    if (value is String) {
      return value.toLowerCase() ==
          'true'; // Parse if it's a string ('true' or 'false')
    }
    return null; // Default return value for unhandled types
  }
}
