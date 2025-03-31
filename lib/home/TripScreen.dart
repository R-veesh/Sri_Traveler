import 'package:flutter/material.dart';
import 'package:sri_traveler/home/TripScreen/trip.dart';
import 'package:sri_traveler/home/TripScreen/TripDetailScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final trips = TripReferences.myTrips;

    return Scaffold(
      appBar: AppBar(
        title:
            Text('Trip', style: TextStyle(color: Colors.black, fontSize: 20)),
        backgroundColor: const Color.fromARGB(129, 180, 230, 255),
      ),
      //database get
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('trips').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No trips available'));
          }

          List<Trip> trips = snapshot.data!.docs
              .map((doc) => Trip.fromFirestore(doc))
              .toList();

          return ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, index) {
              return getItem(context, index, trips[index]);
            },
          );
        },
      ),
    );
  }

  Widget getItem(BuildContext context, int index, Trip trip) {
    print("index: $index");
    return Center(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TripDetailScreen(trip: trip),
            ),
          );
        },
        child: Card(
          shadowColor: Colors.black,
          color: const Color.fromARGB(255, 248, 250, 252),
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
                      child: Image.network(
                        trip.tripImagePath,
                        fit: BoxFit.cover,
                        width: 130,
                        height: 130,
                        errorBuilder: (context, error, stackTrace) {
                          print("Image Load Error: $error");
                          return Icon(Icons.broken_image,
                              size: 100, color: Colors.red);
                        },
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
                        trip.tripName.trim(),
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        trip.tripPlace,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const Spacer(),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(0, 0, 9, 10),
                      //   child: Align(
                      //     alignment: Alignment.bottomRight,
                      //     child: Container(
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 12, vertical: 6),
                      //       decoration: BoxDecoration(
                      //         color: Color.fromARGB(177, 255, 255, 255),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //       child: Text(
                      //         '\$${trip.tripPrice}',
                      //         style: const TextStyle(
                      //           color: Color.fromARGB(255, 0, 0, 0),
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 16,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5, 0, 9, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Trip Duration (Left Side)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(193, 229, 237, 245),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${trip.tripDuration} Days',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            // Trip Price (Right Side)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(200, 175, 241, 155),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                '${trip.tripPrice}LKR',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
