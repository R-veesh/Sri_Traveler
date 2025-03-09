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
                          //greetingMessage,
                          Text(
                            'Hi,' + user.name,
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
                          //user
                        ],
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(user.imagePath),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  __SpecialTitial(),
                  const SizedBox(height: 10),
                  _SpecialIcone(),
                  const SizedBox(height: 15),
                  _buildTripSelection(),
                  const SizedBox(height: 0),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Select Your Next Trip",
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
    final List<Map<String, String>> places = const [
      {
        'name': 'Cascade',
        'location': 'Canada, Banff',
        'image': 'assets/HD-wallpaper-sigiriya-sri-lanka-sri-lanka.jpg'
      },
      {
        'name': 'Yosemite',
        'location': 'USA, California',
        'image': 'assets/HD-wallpaper-sigiriya-sri-lanka-sri-lanka.jpg'
      },
      {
        'name': 'Yosemite',
        'location': 'USA, California',
        'image': 'assets/HD-wallpaper-sigiriya-sri-lanka-sri-lanka.jpg'
      },
      {
        'name': 'Yosemite',
        'location': 'USA, California',
        'image': 'assets/HD-wallpaper-sigiriya-sri-lanka-sri-lanka.jpg'
      },
      {
        'name': 'Yosemite',
        'location': 'USA, California',
        'image': 'assets/HD-wallpaper-sigiriya-sri-lanka-sri-lanka.jpg'
      },
    ];
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
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      return PlaceCard(
                        name: places[index]['name']!,
                        location: places[index]['location']!,
                        image: places[index]['image']!,
                      );
                    },
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
      {
        'icon': Icons.select_all,
        'label': 'Select',
        'onTap': () => print('Select tapped')
      },
      {
        'icon': Icons.book,
        'label': 'Booking',
        'onTap': () => print('Booking tapped')
      },
      {
        'icon': Icons.save,
        'label': 'Save',
        'onTap': () => print('Save tapped')
      },
      {
        'icon': Icons.home,
        'label': 'Rent Place',
        'onTap': () => print('Rent Place tapped'),
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: iconData.map((item) {
        return Column(
          children: [
            ElevatedButton(
              onPressed: () => item['onTap'](),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16), // Rounded corners
                ),
                padding: const EdgeInsets.all(16),
                backgroundColor: Colors.white,
                shadowColor: Colors.grey.withOpacity(0.5),
                elevation: 5,
              ),
              child: Icon(
                item['icon'],
                size: 30,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              item['label'],
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color.fromARGB(255, 0, 0, 0)),
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

  const PlaceCard(
      {super.key,
      required this.name,
      required this.location,
      required this.image});

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
            Icon(
              Icons.location_on_sharp,
              size: 20,
              color: Colors.white60,
            ),
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
