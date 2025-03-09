import 'package:flutter/material.dart';
import 'package:sri_traveler/home/TripScreen/trip.dart';
import 'package:sri_traveler/home/TripScreen/trip_references.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final trips = TripReferences.myTrips;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Trip', style: TextStyle(color: Colors.black, fontSize: 20)),
        backgroundColor: const Color.fromARGB(255, 216, 238, 89),
      ),
      body: trips.isNotEmpty
          ? ListView.builder(
              itemCount: trips.length,
              itemBuilder: (BuildContext context, int index) {
                return getItem(index, trips[index]);
              },
            )
          : Center(
              child: Text('No trips available'),
            ),
    );
  }

  Widget getItem(int index, Trip trip) {
    print("index: $index");
    return Center(
      child: Card(
        shadowColor: Colors.black,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: SizedBox(
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 9, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      trip.tripImagePath,
                      fit: BoxFit.fill,
                      width: 130,
                      height: 130,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      trip.tripName,
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'arial',
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      trip.tripPlace,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
