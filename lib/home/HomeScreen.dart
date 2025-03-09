import 'package:flutter/material.dart';
import 'package:sri_traveler/home/profile/user_references.dart';

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
      greetingMessage = "Good Morning";
    } else if (currentHour < 17) {
      greetingMessage = "Good Afternoon";
    } else {
      greetingMessage = "Good Evening";
    }

    return Scaffold(
      extendBody: true,
      body: Container(
        color: const Color.fromARGB(137, 253, 253, 163),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greetingMessage,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w300,
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(user.imagePath),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  __SpecialTitial(),
                  _SpecialIcone(),
                  const SizedBox(height: 10),
                  _buildTripSelection(),
                  const SizedBox(height: 10),
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Select your next trip",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Arial",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrip() {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: Color.fromARGB(255, 89, 21, 21),
            indicatorColor: Color.fromARGB(255, 0, 0, 0),
            tabs: [
              Tab(text: 'History'),
              Tab(text: 'History'),
              Tab(text: 'History'),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 300,
            child: TabBarView(
              children: [
                //tab1
                Container(
                  width: 200,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/HD-wallpaper-sigiriya-sri-lanka-sri-lanka.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                //tab2
                Container(child: Icon(Icons.directions_transit)),
                //tab3
                Container(child: Icon(Icons.directions_bike)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget __SpecialTitial() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Discover",
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "Arial",
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _SpecialIcone() {
    final List<Map<String, dynamic>> iconData = [
      {'icon': Icons.search, 'label': 'Select'},
      {'icon': Icons.book, 'label': 'Booking'},
      {'icon': Icons.favorite, 'label': 'Save'},
      {'icon': Icons.home, 'label': 'Rent Place'},
    ];

    return SizedBox(
      height: 110, // Adjust height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: iconData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(2, 4),
                      ),
                    ],
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(
                        20), // Makes it square with rounded corners
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    iconData[index]['icon'],
                    size: 30,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  iconData[index]['label'],
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
