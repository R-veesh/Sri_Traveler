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
  List<Trip> filteredTrips = TripReferences.myTrips;
  TextEditingController searchController = TextEditingController();

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
        backgroundColor: Color.fromARGB(255, 254, 240, 159),
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
                          leading: Image.asset(trip.tripImagePath,
                              width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(trip.tripName),
                          subtitle: Text(trip.tripPlace),
                          trailing: Text(trip.tripPrice),
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
