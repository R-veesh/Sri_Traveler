import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sri_traveler/home/HomeScreen/PlaceCard.dart';
import 'package:sri_traveler/home/TripScreen/trip.dart';
import 'package:sri_traveler/models/user_model.dart';
import 'package:sri_traveler/services/db_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Trip> trips = [];
  bool isLoading = true;
  late UserModel user;
  String errorMessage = '';
  final DbService _dbService = DbService();

  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await _loadUserData();
    await fetchTrips();
  }

  Future<void> _loadUserData() async {
    setState(() {
      isLoading = true;
    });

    try {
      var userDoc = await _dbService.readUserData().first;
      user = UserModel.fromJson(userDoc.data() as Map<String, dynamic>);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Error fetching user data: $e";
      });
    }
  }

  Future<void> fetchTrips() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('trips').get();

      if (!mounted) return;

      setState(() {
        trips = snapshot.docs.map((doc) => Trip.fromFirestore(doc)).toList();
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching trips: $e");

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final int currentHour = DateTime.now().hour;
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight - 40 - 150 - 170;

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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, color: Colors.red, size: 48),
                      SizedBox(height: 16),
                      Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            isLoading = true;
                            errorMessage = '';
                          });
                          fetchTrips();
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Container(
                  color: const Color.fromARGB(129, 180, 230, 255),
                  child: ListView(
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hi, ${user.firstName}',
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
                              backgroundImage: _getProfileImage(user.imagePath),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        width: double.infinity,
                        constraints: BoxConstraints(
                          minHeight: containerHeight,
                        ),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
                          child: Column(
                            children: [
                              SizedBox(height: 15),
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
                      )
                    ],
                  ),
                ),
    );
  }

  ImageProvider _getProfileImage(String? imagePath) {
    if (imagePath != null && imagePath.isNotEmpty) {
      if (imagePath.startsWith('http')) {
        return NetworkImage(imagePath);
      } else if (imagePath.startsWith('assets')) {
        return AssetImage(imagePath);
      }
    }
    return NetworkImage(
        'https://t3.ftcdn.net/jpg/05/17/79/88/360_F_517798849_WuXhHTpg2djTbfNf0FQAjzFEoluHpnct.jpg');
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
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          const TabBar(
            labelColor: Color.fromARGB(255, 18, 57, 83),
            indicatorColor: Color.fromARGB(206, 0, 0, 0),
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
            trip: trips[index],
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

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:sri_traveler/home/HomeScreen/PlaceCard.dart';
// import 'package:sri_traveler/home/profile/user.dart';
// import 'package:sri_traveler/home/profile/user_references.dart';
// import 'package:sri_traveler/home/TripScreen/trip.dart';
// import 'package:sri_traveler/models/user_model.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<Trip> trips = [];
//   bool isLoading = true;
// <UserModel> user;
//   String errorMessage = '';

//   void initState() {
//     super.initState();
//     _loadData();
//   }

//   Future<void> _loadData() async {
//     await _loadUserData();
//     await fetchTrips();
//   }

//   Future<void> _loadUserData() async {
//     setState(() {
//       isLoading = true;
//     });

//   }

//   Future<void> fetchTrips() async {
//     try {
//       QuerySnapshot snapshot =
//           await FirebaseFirestore.instance.collection('trips').get();

//       if (!mounted) return;

//       setState(() {
//         trips = snapshot.docs.map((doc) => Trip.fromFirestore(doc)).toList();
//         isLoading = false;
//       });
//     } catch (e) {
//       print("Error fetching trips: $e");

//       if (!mounted) return;

//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final int currentHour = DateTime.now().hour;
//     //screen size
//     double screenHeight = MediaQuery.of(context).size.height;
//     double containerHeight = screenHeight - 40 - 150 - 170;
//     String greetingMessage;
//     if (currentHour < 12) {
//       greetingMessage = "Good Morning!";
//     } else if (currentHour < 17) {
//       greetingMessage = "Good Afternoon!";
//     } else {
//       greetingMessage = "Good Evening!";
//     }
//     return Scaffold(
//       extendBody: true,
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : errorMessage.isNotEmpty
//               ? Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(Icons.error_outline, color: Colors.red, size: 48),
//                       SizedBox(height: 16),
//                       Text(
//                         errorMessage,
//                         style: TextStyle(color: Colors.red),
//                         textAlign: TextAlign.center,
//                       ),
//                       SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             isLoading = true;
//                             errorMessage = '';
//                           });
//                           fetchTrips();
//                         },
//                         child: Text('Retry'),
//                       ),
//                     ],
//                   ),
//                 )
//               : Container(
//                   color: const Color.fromARGB(129, 180, 230, 255),
//                   child: ListView(
//                     shrinkWrap: true,
//                     physics: AlwaysScrollableScrollPhysics(),
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Hi, ${}',
//                                   style: const TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   greetingMessage,
//                                   style: const TextStyle(
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w300,
//                                   ),
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                               ],
//                             ),
//                             CircleAvatar(
//                               radius: 25,
//                               backgroundImage: _getProfileImage(),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                         width: double.infinity,
//                         constraints: BoxConstraints(
//                           minHeight: containerHeight,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Color.fromRGBO(255, 255, 255, 1),
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(20),
//                             topRight: Radius.circular(20),
//                           ),
//                         ),
//                         child: Padding(
//                           padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
//                           child: Column(
//                             children: [
//                               SizedBox(height: 15),
//                               _specialTitle(),
//                               const SizedBox(height: 10),
//                               _specialIcons(),
//                               const SizedBox(height: 15),
//                               _buildTripSelection(),
//                               _buildTrip(),
//                               const SizedBox(height: 30),
//                             ],
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//     );
//   }

//   ImageProvider _getProfileImage(String imagePath) {
//     if (imagePath.startsWith('http')) {
//       return NetworkImage(imagePath);
//     } else if (imagePath.startsWith('assets')) {
//       return AssetImage(imagePath);
//     } else {
//       return AssetImage('');
//     }
//   }

//   Widget _buildTripSelection() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 6.0),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Text(
//           "Select Your Next Trip",
//           textAlign: TextAlign.left,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             fontFamily: "Arial",
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTrip() {
//     return DefaultTabController(
//       length: 3,
//       child: Column(
//         children: [
//           const TabBar(
//             labelColor: Color.fromARGB(255, 18, 57, 83),
//             indicatorColor: Color.fromARGB(206, 0, 0, 0),
//             tabs: [
//               Tab(text: 'Popular'),
//               Tab(text: 'Recommended'),
//               Tab(text: 'History'),
//             ],
//           ),
//           const SizedBox(height: 20),
//           SizedBox(
//             height: 300,
//             child: TabBarView(
//               children: [
//                 _tripListView(trips),
//                 _tripListView(trips),
//                 _tripListView(trips),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _tripListView(List<Trip> trips) {
//     return SizedBox(
//       height: 200,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: trips.length,
//         itemBuilder: (context, index) {
//           return PlaceCard(
//             trip: trips[index],
//           );
//         },
//       ),
//     );
//   }

//   Widget _specialTitle() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: Align(
//         alignment: Alignment.centerLeft,
//         child: Text(
//           "Discover",
//           textAlign: TextAlign.left,
//           style: const TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             fontFamily: "Arial",
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _specialIcons() {
//     final List<Map<String, dynamic>> iconData = [
//       {'icon': Icons.select_all, 'label': 'Select'},
//       {'icon': Icons.book, 'label': 'Booking'},
//       {'icon': Icons.save, 'label': 'Save'},
//       {'icon': Icons.home, 'label': 'Rent Place'},
//     ];

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: iconData.map((item) {
//         return Column(
//           children: [
//             ElevatedButton(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16),
//                 ),
//                 padding: const EdgeInsets.all(16),
//                 backgroundColor: Colors.white,
//                 shadowColor: Colors.grey.withOpacity(0.5),
//                 elevation: 5,
//               ),
//               child: Icon(item['icon'], size: 30, color: Colors.black),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               item['label'],
//               style: const TextStyle(fontSize: 14, color: Colors.black),
//             ),
//           ],
//         );
//       }).toList(),
//     );
//   }
// }
