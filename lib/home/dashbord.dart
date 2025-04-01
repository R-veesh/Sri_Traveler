import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:sri_traveler/home/profile/user.dart';
import 'package:sri_traveler/home/profile/user_references.dart';
import 'package:sri_traveler/services/user_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  late User user;
  bool isLoading = true;
  String appVersion = '';
  bool notificationsEnabled = true;
  bool locationEnabled = true;

  // Create UserService
  final userService = UserService(
    cloudinaryName: 'dtgie8eha',
    cloudinaryUploadPreset: 'traveler_app_preset',
  );

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Load user data
      user = await UserReferences.fetchCurrentUser();

      // Get app version
      final packageInfo = await PackageInfo.fromPlatform();
      appVersion = '${packageInfo.version} (${packageInfo.buildNumber})';
    } catch (e) {
      print('Error loading settings data: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _toggleDarkMode(bool value) async {
    setState(() {
      isLoading = true;
    });

    try {
      await userService.updateUserProfile(
        isDarkMode: value,
      );

      // Refresh user data
      user = await UserReferences.fetchCurrentUser();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Theme preference updated')),
      );
    } catch (e) {
      print('Error updating theme preference: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update theme preference')),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _deleteAccount() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account'),
        content: Text(
          'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      setState(() {
        isLoading = true;
      });

      try {
        // Delete user account logic would go here
        // This is a placeholder for actual implementation
        await Future.delayed(Duration(seconds: 1));

        // Sign out
        await firebase_auth.FirebaseAuth.instance.signOut();

        // Navigate to login screen
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (route) => false);
      } catch (e) {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting account: $e')),
        );
      }
    }
  }

  void _shareApp() {
    Share.share(
      'Check out this amazing travel app! Download it now: https://yourtravelapp.com',
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: const Color.fromARGB(129, 180, 230, 255),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                _buildUserHeader(),
                Divider(),
                _buildAccountSettings(),
                Divider(),
                _buildAppearanceSettings(),
                Divider(),
                _buildNotificationSettings(),
                Divider(),
                _buildPrivacySettings(),
                Divider(),
                _buildSupportSection(),
                Divider(),
                _buildAboutSection(),
                SizedBox(height: 24),
                _buildLogoutButton(),
                SizedBox(height: 24),
                _buildDeleteAccountButton(),
                SizedBox(height: 40),
              ],
            ),
    );
  }

  Widget _buildUserHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: _getProfileImage(user.imagePath),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.email,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.pushNamed(context, '/edit-profile').then((_) {
                _loadData(); // Refresh data when returning from edit screen
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSettings() {
    return _buildSettingsSection(
      title: 'Account',
      children: [
        ListTile(
          leading: Icon(Icons.person),
          title: Text('Profile Information'),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            Navigator.pushNamed(context, '/edit-profile');
          },
        ),
        ListTile(
          leading: Icon(Icons.password),
          title: Text('Change Password'),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            // Navigate to change password screen
          },
        ),
        ListTile(
          leading: Icon(Icons.language),
          title: Text('Language'),
          trailing: Text('English'),
          onTap: () {
            // Show language selection dialog
          },
        ),
      ],
    );
  }

  Widget _buildAppearanceSettings() {
    return _buildSettingsSection(
      title: 'Appearance',
      children: [
        SwitchListTile(
          secondary: Icon(user.isDarkMode ? Icons.dark_mode : Icons.light_mode),
          title: Text('Dark Mode'),
          value: user.isDarkMode,
          onChanged: _toggleDarkMode,
        ),
        ListTile(
          leading: Icon(Icons.text_fields),
          title: Text('Text Size'),
          trailing: Text('Medium'),
          onTap: () {
            // Show text size selection dialog
          },
        ),
      ],
    );
  }

  Widget _buildNotificationSettings() {
    return _buildSettingsSection(
      title: 'Notifications',
      children: [
        SwitchListTile(
          secondary: Icon(Icons.notifications),
          title: Text('Push Notifications'),
          subtitle: Text('Receive alerts about new trips and offers'),
          value: notificationsEnabled,
          onChanged: (value) {
            setState(() {
              notificationsEnabled = value;
            });
          },
        ),
        SwitchListTile(
          secondary: Icon(Icons.email),
          title: Text('Email Notifications'),
          subtitle: Text('Receive trip updates via email'),
          value: notificationsEnabled,
          onChanged: (value) {
            setState(() {
              notificationsEnabled = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildPrivacySettings() {
    return _buildSettingsSection(
      title: 'Privacy',
      children: [
        SwitchListTile(
          secondary: Icon(Icons.location_on),
          title: Text('Location Services'),
          subtitle: Text('Allow app to access your location'),
          value: locationEnabled,
          onChanged: (value) {
            setState(() {
              locationEnabled = value;
            });
          },
        ),
        ListTile(
          leading: Icon(Icons.visibility),
          title: Text('Profile Visibility'),
          trailing: Text('Friends'),
          onTap: () {
            // Show profile visibility options
          },
        ),
        ListTile(
          leading: Icon(Icons.security),
          title: Text('Privacy Policy'),
          trailing: Icon(Icons.open_in_new),
          onTap: () {
            _launchURL('https://yourtravelapp.com/privacy');
          },
        ),
      ],
    );
  }

  Widget _buildSupportSection() {
    return _buildSettingsSection(
      title: 'Support',
      children: [
        ListTile(
          leading: Icon(Icons.help_outline),
          title: Text('Help Center'),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            _launchURL('https://yourtravelapp.com/help');
          },
        ),
        ListTile(
          leading: Icon(Icons.feedback),
          title: Text('Send Feedback'),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            // Show feedback form
          },
        ),
        ListTile(
          leading: Icon(Icons.report_problem),
          title: Text('Report a Problem'),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            // Show problem report form
          },
        ),
      ],
    );
  }

  Widget _buildAboutSection() {
    return _buildSettingsSection(
      title: 'About',
      children: [
        ListTile(
          leading: Icon(Icons.info_outline),
          title: Text('About Sri Traveler'),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            // Show about app dialog
          },
        ),
        ListTile(
          leading: Icon(Icons.share),
          title: Text('Share App'),
          trailing: Icon(Icons.chevron_right),
          onTap: _shareApp,
        ),
        ListTile(
          leading: Icon(Icons.star_outline),
          title: Text('Rate App'),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            _launchURL(
                'https://play.google.com/store/apps/details?id=com.yourtravelapp');
          },
        ),
        ListTile(
          leading: Icon(Icons.system_update),
          title: Text('Version'),
          trailing: Text(appVersion),
          onTap: null,
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildDeleteAccountButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextButton(
        onPressed: _deleteAccount,
        child: Text(
          'Delete Account',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  // Helper method to handle profile image loading
  ImageProvider _getProfileImage(String imagePath) {
    if (imagePath.startsWith('http')) {
      return NetworkImage(imagePath);
    } else if (imagePath.startsWith('assets')) {
      return AssetImage(imagePath);
    } else {
      // Default image if path is invalid
      return AssetImage('assets/default_profile.jpg');
    }
  }
}
