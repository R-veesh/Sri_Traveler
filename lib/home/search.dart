import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sri_traveler/home/TripScreen/TripDetailScreen.dart';
import 'package:sri_traveler/home/TripScreen/trip.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Trip> filteredTrips = [];
  List<Trip> allTrips = [];
  TextEditingController searchController = TextEditingController();
  double? selectedMaxPrice;
  int? selectedMinDuration;

  @override
  void initState() {
    super.initState();
    fetchTrips();
  }

  // Fetch trips from Firestore
  Future<void> fetchTrips() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('trips').get();

      setState(() {
        allTrips = snapshot.docs.map((doc) => Trip.fromFirestore(doc)).toList();
        filteredTrips = List.from(allTrips);
      });
    } catch (e) {
      print("Error fetching trips: $e");
    }
  }

  // Filter search results
  void filterSearchResults(String query) {
    setState(() {
      List<Trip> tempTrips = allTrips.where((trip) {
        final nameMatch =
            trip.tripName.toLowerCase().contains(query.toLowerCase());
        final placeMatch =
            trip.tripPlace.toLowerCase().contains(query.toLowerCase());
        final durationValue = int.tryParse(trip.tripDuration) ?? 0;
        final priceValue = double.tryParse(trip.tripPrice) ?? 0.0;

        final durationMatch = selectedMinDuration == null ||
            durationValue >= selectedMinDuration!;
        final priceMatch =
            selectedMaxPrice == null || priceValue <= selectedMaxPrice!;

        return (nameMatch || placeMatch) && durationMatch && priceMatch;
      }).toList();

      filteredTrips = tempTrips;
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
            icon: Icon(Icons.filter_list),
            onPressed: showFilterDialog,
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              searchController.clear();
              setState(() {
                selectedMinDuration = null;
                selectedMaxPrice = null;
                filteredTrips = List.from(allTrips);
              });
            },
          ),
        ],
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
                  borderSide: BorderSide(color: Colors.grey),
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
                          leading: Image.network(
                            trip.tripImagePath,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(trip.tripName),
                          subtitle: Text(trip.tripPlace),
                          trailing: Text('LKR ${trip.tripPrice}'),
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
                  : Center(
                      child: Text(
                        'No trips available',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void showFilterDialog() {
    TextEditingController durationController = TextEditingController();
    TextEditingController priceController = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setModalState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Filter Trips",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

                // Trip Duration Input
                TextField(
                  controller: durationController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Minimum Duration (Days)",
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 10),

                // Trip Price Input
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Maximum Price (LKR)",
                    border: OutlineInputBorder(),
                  ),
                ),

                SizedBox(height: 20),

                // Apply Filter Button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedMinDuration =
                          int.tryParse(durationController.text);
                      selectedMaxPrice = double.tryParse(priceController.text);
                    });

                    Navigator.pop(context);
                    filterSearchResults(searchController.text);
                  },
                  child: Text("Apply Filters"),
                ),
              ],
            ),
          );
        });
      },
    );
  }
}
