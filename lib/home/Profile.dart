import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'profile/profile_widget.dart';
import 'profile/button_widget.dart';
import 'profile/edit_profile_screen.dart';
import 'profile/user.dart';
import 'profile/user_references.dart';
import 'profile/appBar_widget.dart';
// Import the new UserService

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User user;
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      // Use the UserService to get the current user
      user = await UserReferences.fetchCurrentUser();
    } catch (e) {
      print('Error loading user data: $e');
      setState(() {
        errorMessage = 'Failed to load profile. Please try again.';
      });
      // Fallback to default user if error
      user = UserReferences.defaultUser;
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
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
                        onPressed: loadUserData,
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: loadUserData,
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      const SizedBox(height: 24),
                      ProfileWidget(
                        imagePath: user.imagePath,
                        onClicked_1: () {
                          Navigator.of(context)
                              .push(
                            MaterialPageRoute(
                              builder: (context) => EditProfileScreen(),
                            ),
                          )
                              .then((_) {
                            // Refresh profile when returning from edit screen
                            loadUserData();
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      buildName(user),
                      const SizedBox(height: 24),
                      buildAbout(user),
                      const SizedBox(height: 24),
                      buildTravelStats(),
                      const SizedBox(height: 48),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildLogoutButton(),
                            const SizedBox(width: 16),
                            buildEditProfileButton(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.fullName, // Use the computed fullName property
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.bio,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );

  Widget buildTravelStats() => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Travel Stats',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('Places Visited', '12'),
                _buildStatItem('Reviews', '24'),
                _buildStatItem('Photos', '48'),
              ],
            ),
          ],
        ),
      );

  Widget _buildStatItem(String label, String value) => Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 62, 115, 141),
            ),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      );

  Widget buildLogoutButton() => Center(
        child: ElevatedButton.icon(
          onPressed: () async {
            try {
              await firebase_auth.FirebaseAuth.instance.signOut();
              Navigator.pushReplacementNamed(context, '/login');
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error signing out: $e'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          icon: Icon(Icons.logout),
          label: Text('Logout'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      );

  Widget buildEditProfileButton() => Center(
        child: ButtonWidget(
          text: 'Edit Profile',
          onClicked: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => EditProfileScreen(),
              ),
            )
                .then((_) {
              // Refresh profile when returning from edit screen
              loadUserData();
            });
          },
        ),
      );
}

//v21.0.0

// import 'package:flutter/material.dart';
// import 'package:line_icons/line_icons.dart';
// import 'package:sri_traveler/home/profile/appBar_widget.dart';
// import 'package:sri_traveler/home/profile/profile_widget.dart';
// import 'package:sri_traveler/home/profile/user.dart';
// import 'package:sri_traveler/home/profile/user_references.dart';
// import 'package:sri_traveler/home/profile/edit_profile_screen.dart'; // Import EditProfileScreen

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final user = UserReferences.myUser; // Fixed variable name

//     return Scaffold(
//       appBar: buildAppBar(context),
//       body: ListView(
//         physics: BouncingScrollPhysics(),
//         children: [
//           const SizedBox(height: 24),
//           ProfileWidget(
//             imagePath: user.imagePath,
//             onClicked_1: () async {
//               await Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => EditProfileScreen()),
//               );
//               setState(() {});
//             },
//           ),
//           const SizedBox(height: 24),
//           buildName(user),
//           const SizedBox(height: 24),
//           buildSocialMediaLinks(),
//           const SizedBox(height: 24),
//           buildBioUser(user),
//           const SizedBox(height: 24),
//           // Center(
//           //   child: buildEditProfileButton(),
//           // ),
//         ],
//       ),
//     );
//   }

//   Widget buildName(User user) => Column(
//         children: [
//           Text(
//             user.name,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             user.email,
//             style: TextStyle(color: Colors.grey),
//           ),
//         ],
//       );

//   // Widget buildEditProfileButton() => ButtonWidget(
//   //       text: 'Edit Profile',
//   //       onClicked: () {
//   //         Navigator.push(
//   //           context,
//   //           MaterialPageRoute(builder: (context) => EditProfileScreen()),
//   //         ).then((_) {
//   //           // Refresh after returning from edit screen
//   //           setState(() {});
//   //         });
//   //       },
//   //     );

//   Widget buildSocialMediaLinks() => Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconButton(
//             icon: Icon(LineIcons.facebook),
//             color: Colors.blue,
//             iconSize: 40,
//             onPressed: () {
//               // Add your Facebook link here
//             },
//           ),
//           const SizedBox(width: 20),
//           IconButton(
//             icon: Icon(LineIcons.twitter),
//             color: Colors.lightBlue,
//             iconSize: 40,
//             onPressed: () {
//               // Add your Twitter link here
//             },
//           ),
//           const SizedBox(width: 20),
//           IconButton(
//             icon: Icon(LineIcons.instagram),
//             color: Colors.purple,
//             iconSize: 40,
//             onPressed: () {
//               // Add your Instagram link here
//             },
//           ),
//         ],
//       );

//   Widget buildBioUser(User user) => Card(
//         margin: EdgeInsets.symmetric(horizontal: 48),
//         shadowColor: Colors.black,
//         elevation: 3,
//         child: Padding(
//           padding: EdgeInsets.all(16),
//           child: Column(
//             children: [
//               const SizedBox(height: 12),
//               Text(
//                 user.bio,
//                 style: TextStyle(fontSize: 16, height: 1.4),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       );
// }
