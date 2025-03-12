import 'package:flutter/material.dart';
import 'package:sri_traveler/home/TripScreen/trip_references.dart';
import 'package:sri_traveler/home/TripScreen/TripDetailScreen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trips = TripReferences.myTrips;

    return Scaffold();
  }
}
