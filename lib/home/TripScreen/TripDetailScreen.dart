import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sri_traveler/home/TripScreen/BookingConfirmationScreen.dart';
import 'package:sri_traveler/home/TripScreen/trip.dart';
import 'package:sri_traveler/models/booking_modal.dart';
import 'package:sri_traveler/models/guider_modal.dart';

class TripDetailScreen extends StatefulWidget {
  final Trip trip;

  const TripDetailScreen({super.key, required this.trip});

  @override
  _TripDetailScreenState createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  late GuideModel guideDetails;
  double rating = 4.5;
  // final TextEditingController _commentController = TextEditingController();
  List<String> comments = [];
  String guideImagePath =
      'https://t3.ftcdn.net/jpg/05/17/79/88/360_F_517798849_WuXhHTpg2djTbfNf0FQAjzFEoluHpnct.jpg';

  @override
  void initState() {
    super.initState();
    fetchGuideImage(widget.trip.guideId);
    fetchGuideDetails(widget.trip.guideId);
  }

  //find the using guideId to find firebase guides doc the guider image path
  Future<void> fetchGuideImage(String guideId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('guides')
          .doc(guideId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        setState(() {
          guideImagePath = data['profileImageUrl'] ??
              'https://t3.ftcdn.net/jpg/05/17/79/88/360_F_517798849_WuXhHTpg2djTbfNf0FQAjzFEoluHpnct.jpg';
        });
      }
    } catch (e) {
      print("Error fetching guide image: $e");
    }
  }

  // Function to fetch guide details using guideId
  Future<void> fetchGuideDetails(String guideId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('guides')
          .doc(guideId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        setState(() {
          guideDetails = GuideModel.fromFirestore(data);
        });
      }
    } catch (e) {
      print("Error fetching guide details: $e");
    }
  }

  // Function to handle booking logic
  Future<void> bookingTrip(String guideId) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trip.tripName),
        backgroundColor: const Color.fromARGB(129, 180, 230, 255),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(12.0)),
                  child: Image.network(widget.trip.tripImagePath,
                      width: double.infinity, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(guideImagePath),
                          ),
                          SizedBox(width: 8),
                          Text(
                            widget.trip.tripName,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.trip.tripPlace,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.trip.tripDescription,
                        style: TextStyle(fontSize: 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(205, 5, 0, 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(176, 194, 246, 200),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${widget.trip.tripPrice}LKR',
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 24),
                          SizedBox(width: 5),
                          Text(
                            '$rating / 5',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Divider(),
                      const SizedBox(height: 15),
                      //
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              // Extract necessary data for the booking
                              String tripName = widget.trip.tripName;
                              String guideName = guideDetails.fullName;
                              double price =
                                  double.parse(widget.trip.tripPrice);
                              DateTime startDate = DateTime.now();
                              // Create the BookingModal and pass it to the BookingConfirmationScreen
                              BookingModal booking = BookingModal(
                                tripName: tripName,
                                guideName: guideName,
                                guideImagePath: guideImagePath,
                                price: price,
                                startDate: startDate,
                              );

                              // Navigate to the BookingConfirmationScreen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BookingConfirmationScreen(
                                    booking: booking,
                                  ),
                                ),
                              );

                              // try {
                              //   // Extract necessary data for the booking
                              //   String guideId = widget.trip.guideId;
                              //   String guideName = widget.guideDetails.fullName;
                              //   String tripName = widget.trip.tripName;
                              //   String tripDuration = widget.trip.tripDuration;
                              //   String price = widget.trip.tripPrice;

                              //   // Navigate to the booking confirmation screen
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => bookingConfirmation(
                              //         tripName: tripName,
                              //         guideName: guideName,
                              //         guideImagePath: guideImagePath,
                              //         price: price,
                              //       ),
                              //     ),
                              //   );
                              // } catch (e) {
                              //   // Show an error message if something goes wrong
                              //   ScaffoldMessenger.of(context).showSnackBar(
                              //     SnackBar(
                              //       content: Text(
                              //         'Failed to navigate for booking. Please try again.',
                              //       ),
                              //     ),
                              //   );
                              //   print('Error during navigation: $e');
                              // }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Book Now',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),
                      // Text('Add a comment:', style: TextStyle(fontSize: 16)),
                      // TextField(
                      //   controller: _commentController,
                      //   decoration: InputDecoration(
                      //     hintText: 'Write your thoughts...',
                      //     border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(10)),
                      //     suffixIcon: IconButton(
                      //       icon: Icon(Icons.send),
                      //       onPressed: () {
                      //         setState(() {
                      //           comments.add(_commentController.text);
                      //           _commentController.clear();
                      //         });
                      //       },
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 10),
                      // if (comments.isNotEmpty)
                      //   Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: comments
                      //         .map((comment) => Padding(
                      //               padding:
                      //                   const EdgeInsets.symmetric(vertical: 5),
                      //               child: Text(
                      //                 '- $comment',
                      //                 style: TextStyle(fontSize: 14),
                      //               ),
                      //             ))
                      //         .toList(),
                      //   ),
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
