import 'package:cloud_firestore/cloud_firestore.dart';

class GuideModel {
  final String bio;
  final String email;
  final String fullName;
  final String languages;
  final String location;
  final String phone;
  final String profileImageUrl;
  final String role;
  final String specialties;
  final Timestamp createdAt;
  final Timestamp updatedAt;

  GuideModel({
    required this.bio,
    required this.email,
    required this.fullName,
    required this.languages,
    required this.location,
    required this.phone,
    required this.profileImageUrl,
    required this.role,
    required this.specialties,
    required this.createdAt,
    required this.updatedAt,
  });

  // Method to create a Guide object from Firestore data
  factory GuideModel.fromFirestore(Map<String, dynamic> data) {
    return GuideModel(
      bio: data['bio'] ?? '',
      email: data['email'] ?? '',
      fullName: data['fullName'] ?? '',
      languages: data['languages'] ?? '',
      location: data['location'] ?? '',
      phone: data['phone'] ?? '',
      profileImageUrl: data['profileImageUrl'] ?? '',
      role: data['role'] ?? '',
      specialties: data['specialties'] ?? '',
      createdAt: data['createdAt'] as Timestamp,
      updatedAt: data['updatedAt'] as Timestamp,
    );
  }
}
