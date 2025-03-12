import 'package:flutter/material.dart';
import 'package:sri_traveler/home/TripScreen/trip_references.dart';
import 'package:sri_traveler/home/profile/user_references.dart';
import 'package:sri_traveler/home/TripScreen/trip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final int currentHour = DateTime.now().hour;
    final user = UserReferences.myUser;

    String greetingMessage;
    if (currentHour < 12) {
      greetingMessage = "Good Morning!";
    } else if (currentHour < 17) {
      greetingMessage = "Good Afternoon!";
    } else {
      greetingMessage = "Good Evening!";
    }
    return Scaffold(
      extendBody: true,
      body: Container(
        color: const Color.fromARGB(137, 253, 253, 163),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, ${user.name}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            greetingMessage,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(user.imagePath),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  _specialTitle(),
                  const SizedBox(height: 10),
                  _specialIcons(),
                  const SizedBox(height: 15),
                  _buildTripSelection(),
                  _buildTrip(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTripSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Select Your Next Trip",
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Arial",
          ),
        ),
      ),
    );
  }

  Widget _buildTrip() {
    final trips = TripReferences.myTrips;
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: Color.fromARGB(255, 89, 21, 21),
            indicatorColor: Color.fromARGB(255, 0, 0, 0),
            tabs: [
              Tab(text: 'Popular'),
              Tab(text: 'Recommended'),
              Tab(text: 'History'),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 300,
            child: TabBarView(
              children: [
                _tripListView(trips),
                _tripListView(trips),
                _tripListView(trips),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _tripListView(List<Trip> trips) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: trips.length,
        itemBuilder: (context, index) {
          return PlaceCard(
            name: trips[index].tripName,
            location: trips[index].tripPlace,
            image: trips[index].tripImagePath,
          );
        },
      ),
    );
  }

  Widget _specialTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Discover",
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Arial",
          ),
        ),
      ),
    );
  }

  Widget _specialIcons() {
    final List<Map<String, dynamic>> iconData = [
      {'icon': Icons.select_all, 'label': 'Select'},
      {'icon': Icons.book, 'label': 'Booking'},
      {'icon': Icons.save, 'label': 'Save'},
      {'icon': Icons.home, 'label': 'Rent Place'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: iconData.map((item) {
        return Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.white,
                shadowColor: Colors.grey.withOpacity(0.5),
                elevation: 5,
              ),
              child: Icon(item['icon'], size: 30, color: Colors.black),
            ),
            const SizedBox(height: 5),
            Text(
              item['label'],
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        );
      }).toList(),
    );
  }
}

class PlaceCard extends StatelessWidget {
  final String name;
  final String location;
  final String image;

  const PlaceCard({
    super.key,
    required this.name,
    required this.location,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.6), Colors.transparent],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.location_on_sharp,
                size: 20, color: Colors.white60),
            Text(name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            Text(location,
                style: const TextStyle(color: Colors.white70, fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
