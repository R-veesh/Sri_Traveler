import 'package:cloud_firestore/cloud_firestore.dart';

class Trip {
  final String guideId;
  final String tripImagePath;
  final String tripName;
  final String tripCode;
  final String tripPlace;
  final String tripPrice;
  final String tripDuration;
  final String tripDescription;

  Trip({
    required this.guideId,
    required this.tripImagePath,
    required this.tripName,
    required this.tripCode,
    required this.tripPrice,
    required this.tripPlace,
    required this.tripDuration,
    required this.tripDescription,
  });

  // Factory method to create a Trip from Firestore data
  factory Trip.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Trip(
      guideId: data['guideId'] ?? '',
      tripImagePath: data['tripImagePath'] ?? '',
      tripName: data['tripName'] ?? '',
      tripCode: data['tripCode'] ?? '',
      tripPrice: data['tripPrice'] ?? '',
      tripPlace: data['tripPlace'] ?? '',
      tripDuration: data['tripDuration'] ?? '',
      tripDescription: data['tripDescription'] ?? '',
    );
  }
}
