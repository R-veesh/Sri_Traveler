import 'package:flutter/material.dart';
import 'package:sri_traveler/home/TripScreen/trip.dart';

class TripDetailScreen extends StatefulWidget {
  final Trip trip;

  const TripDetailScreen({super.key, required this.trip});

  @override
  _TripDetailScreenState createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  double rating = 4.5;
  final TextEditingController _commentController = TextEditingController();
  List<String> comments = [];

  @override
  Widget build(
    BuildContext context,
  ) {
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
                            backgroundImage: AssetImage(
                                'assets/profile_placeholder.png'), // Replace with actual user image
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
                              // TODO: Implement booking logic here
                              //
                              //
                              //
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Booking for ${widget.trip.tripName} confirmed!'),
                                ),
                              );
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
