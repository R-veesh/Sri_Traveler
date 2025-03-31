import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sri_traveler/home/TripScreen/trip_references.dart';
import 'package:sri_traveler/home/TripScreen/TripDetailScreen.dart';
import 'package:sri_traveler/home/TripScreen/trip.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // List<Trip> filteredTrips = TripReferences.myTrips;
  List<Trip> filteredTrips = [];
  List<Trip> allTrips = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchTrips();
  }

  // Fetch trips from Firestore
  Future<void> fetchTrips() async {
    try {
      // Get all trips from Firestore
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('trips').get();
      // Convert each document to a Trip object
      setState(() {
        allTrips = snapshot.docs.map((doc) {
          return Trip.fromFirestore(doc);
        }).toList();
        filteredTrips = List.from(allTrips);
      });
    } catch (e) {
      print("Error fetching trips: $e");
    }
  }

  void filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredTrips = TripReferences.myTrips;
      } else {
        filteredTrips = TripReferences.myTrips
            .where((trip) =>
                trip.tripName.toLowerCase().contains(query.toLowerCase()) ||
                trip.tripPlace.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Trips'),
        backgroundColor: const Color.fromARGB(129, 180, 230, 255),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              searchController.clear();
              filterSearchResults('');
            },
          ),
        ],
        //  actions: [
        //   IconButton(
        //     icon: Icon(Icons.filter_list),
        //     onPressed: () {
        //       // Add your filter action here
        //     },
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search for a trip...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
              ),
              onChanged: filterSearchResults,
            ),
            SizedBox(height: 20),
            Expanded(
              child: filteredTrips.isNotEmpty
                  ? ListView.builder(
                      itemCount: filteredTrips.length,
                      itemBuilder: (context, index) {
                        final trip = filteredTrips[index];
                        return ListTile(
                          leading: Image.network(trip.tripImagePath,
                              width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(trip.tripName),
                          subtitle: Text(trip.tripPlace),
                          trailing: Text('${trip.tripPrice}LKR'),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TripDetailScreen(trip: trip),
                              ),
                            );
                          },
                        );
                      },
                    )
                  : Center(child: Text('No trips found')),
            ),
          ],
        ),
      ),
    );
  }
}
