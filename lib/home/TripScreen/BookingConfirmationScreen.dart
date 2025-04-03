import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sri_traveler/models/booking_modal.dart';
import 'package:sri_traveler/services/db_service.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final BookingModal booking; // Booking details passed from the previous screen

  const BookingConfirmationScreen({Key? key, required this.booking})
      : super(key: key);

  // Format the start and end date for display
  String formatDate(DateTime date) {
    return DateFormat('MMMM dd, yyyy').format(date);
  }

  Future<void> confirmBooking(BuildContext context) async {
    try {
      // Call your DbService to handle booking logic
      await DbService().bookingTrip(
        booking.guideName,
        booking.startDate,
        booking.duration,
      );

      // Display a confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking Confirmed!')),
      );

      // Navigate back or to another screen
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Trip Name
              Text(
                booking.tripName,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Guide Name and Image
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(booking.guideImagePath),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    booking.guideName,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Trip Dates (Start and End Date)
              Text(
                'Start Date: ${formatDate(booking.startDate)}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              // Assuming a fixed duration or dynamic calculation
              Text(
                'End Date: ${formatDate(booking.startDate.add(Duration(days: booking.duration)))}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),

              // Price
              Text(
                'Price: ${booking.price.toStringAsFixed(2)} LKR',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),

              // Booking Summary
              Text(
                'Booking Summary:',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'You have booked the trip "${booking.tripName}" with guide "${booking.guideName}".',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Confirm and Cancel Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Cancel Button
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to the previous screen
                    },
                    child: const Text('Cancel'),
                  ),
                  // Confirm Button
                  ElevatedButton(
                    onPressed: () => confirmBooking(context),
                    child: const Text('Confirm Booking'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class bookingConfirmation extends StatefulWidget {
//   @override
//   State<bookingConfirmation> createState() => _bookingConfirmation();
// }

// class _bookingConfirmation extends State<bookingConfirmation> {
//   DateTime selectedDate = DateTime.now(); 

//   // Function to handle the booking request
//   Future<void> sendBookingRequest() async {
//     try {

//       print('Booking Request Sent');
//       print('Guide: ${widget.guideName}');
//       print('Trip: ${widget.tripName}');
//       print('Selected Date: $selectedDate');
//       print('Price: ${widget.price} LKR');

//       // After sending the request, show a confirmation message
//       Navigator.pop(context); // Close the modal
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Booking request for ${widget.tripName} sent!'),
//         ),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to send booking request. Please try again.'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Guide image and name
//             Row(
//               children: [
//                 CircleAvatar(
//                   backgroundImage: NetworkImage(widget.guideImagePath),
//                   radius: 30,
//                 ),
//                 SizedBox(width: 10),
//                 Text(
//                   widget.guideName,
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//               ],
//             ),
//             SizedBox(height: 20),
//             Text(
//               widget.tripName,
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Price: ${widget.tripPrice} LKR',
//               style: TextStyle(fontSize: 18, color: Colors.green),
//             ),
//             SizedBox(height: 20),

//             // Date Picker to select a start date
//             Text('Select Start Date:', style: TextStyle(fontSize: 18)),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () async {
//                 final DateTime? picked = await showDatePicker(
//                   context: context,
//                   initialDate: selectedDate,
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime(2101),
//                 );

//                 if (picked != null && picked != selectedDate) {
//                   setState(() {
//                     selectedDate = picked;
//                   });
//                 }
//               },
//               child: Text('Pick a Date'),
//             ),
//             SizedBox(height: 20),

//             // Display the selected date
//             Text(
//               'Selected Date: ${selectedDate.toLocal()}'.split(' ')[0],
//               style: TextStyle(fontSize: 18),
//             ),
//             SizedBox(height: 20),

//             // Book now button
//             Center(
//               child: ElevatedButton(
//                 onPressed: sendBookingRequest,
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.blueAccent,
//                   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//                 child: const Text(
//                   'Confirm Booking',
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }