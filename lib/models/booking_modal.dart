import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingModal {
  final String tripName;
  final String guideName;
  final String guideImagePath;
  final int duration;
  final double price;
  final DateTime startDate;

  const BookingModal({
    Key? key,
    required this.tripName,
    required this.guideName,
    required this.guideImagePath,
    required this.duration,
    required this.price,
    required this.startDate,
  });

  // Modify the fromJson constructor to handle Timestamp
  factory BookingModal.fromJson(Map<String, dynamic> json) {
    return BookingModal(
      tripName: json['tripName'] ?? '',
      guideName: json['guideName'] ?? '',
      guideImagePath: json['guideImagePath'] ?? '',
      duration: json['duration'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      startDate: (json['startDate'] is Timestamp)
          ? (json['startDate'] as Timestamp).toDate()
          : DateTime.parse(json['startDate']),
    );
  }
}
