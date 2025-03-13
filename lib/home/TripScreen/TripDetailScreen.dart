import 'package:flutter/material.dart';
import 'package:sri_traveler/home/TripScreen/trip.dart';

class TripDetailScreen extends StatefulWidget {
  final Trip trip;

  const TripDetailScreen({super.key, required this.trip});

  @override
  _TripDetailScreenState createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  double rating = 4.5; // Default rating
  final TextEditingController _commentController = TextEditingController();
  List<String> comments = []; // Store user comments

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.trip.tripName),
        backgroundColor: Colors.amber[200],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                  child: Image.asset(widget.trip.tripImagePath,
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
                      SizedBox(height: 10),
                      Text('Add a comment:', style: TextStyle(fontSize: 16)),
                      TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                          hintText: 'Write your thoughts...',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              setState(() {
                                comments.add(_commentController.text);
                                _commentController.clear();
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      if (comments.isNotEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: comments
                              .map((comment) => Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      '- $comment',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ))
                              .toList(),
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
