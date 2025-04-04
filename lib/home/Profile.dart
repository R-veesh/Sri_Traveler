import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:sri_traveler/models/user_model.dart';
import 'package:sri_traveler/services/db_service.dart';
import 'profile/profile_widget.dart';
import 'profile/button_widget.dart';
import 'profile/edit_profile_screen.dart';
import 'profile/appBar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late UserModel user;
  bool isLoading = true;
  String errorMessage = '';
  final DbService _dbService = DbService();

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
      var userDoc = await _dbService.readUserData().first;
      if (userDoc.exists) {
        user = UserModel.fromJson(userDoc.data() as Map<String, dynamic>);
      } else {
        setState(() {
          errorMessage = 'User profile not found.';
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
      setState(() {
        errorMessage = 'Failed to load profile. Please try again. Error: $e';
      });
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
                        imagePath: user.imagePath ?? '',
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

  Widget buildName(UserModel user) => Column(
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

  Widget buildAbout(UserModel user) => Container(
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
              user.bio ?? 'No bio available',
              //not shuvra
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
