// class Trip {
//   final String tripImagePath;
//   final String tripName;
//   final String tripCode;
//   final String tripPlace;
//   final String tripPrice;
//   final String tripDescription;

//   const Trip({
//     required this.tripImagePath,
//     required this.tripName,
//     required this.tripCode,
//     required this.tripPlace,
//     required this.tripPrice,
//     required this.tripDescription,
//   });

//   // Factory method to create a Trip object from a Firestore document
//   factory Trip.fromMap(Map<String, dynamic> map) {
//     return Trip(
//       tripImagePath: map['tripImagePath'] ?? '',
//       tripName: map['tripName'] ?? '',
//       tripCode: map['tripCode'] ?? '',
//       tripPlace: map['tripPlace'] ?? '',
//       tripPrice: map['tripPrice'] ?? '',
//       tripDescription: map['tripDescription'] ?? '',
//     );
//   }

//   // Method to convert Trip object into a Map for Firestore
//   Map<String, dynamic> toMap() {
//     return {
//       'tripImagePath': tripImagePath,
//       'tripName': tripName,
//       'tripCode': tripCode,
//       'tripPlace': tripPlace,
//       'tripPrice': tripPrice,
//       'tripDescription': tripDescription,
//     };
//   }
// }

class Trip {
  final String tripImagePath;
  final String tripName;
  final String tripCode;
  final String tripPlace;
  final String tripPrice;
  final String tripDescription;

  const Trip({
    required this.tripImagePath,
    required this.tripName,
    required this.tripCode,
    required this.tripPrice,
    required this.tripPlace,
    required this.tripDescription,
  });
}
