import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '/src/screens/auth/login_screen.dart';
import '/src/screens/profile/edit_profile_screen.dart';

class ProfileMenu extends StatefulWidget {
  final String? username; // Made nullable to handle dynamic cases
  final String profileLabel;

  const ProfileMenu({
    Key? key,
    this.username = 'Guest', // Default value for username
    this.profileLabel = 'View Profile',
  }) : super(key: key);

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchProfilePicture(); // Fetch the profile picture on initialization
  }

  Future<void> _fetchProfilePicture() async {
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id;

      if (userId != null) {
        // Fetch profile data
        final response = await Supabase.instance.client
            .from('profiles')
            .select('profile_image_url')
            .eq('id', userId)
            .maybeSingle();

        if (response != null) {
          setState(() {
            _profileImageUrl = response['profile_image_url'];
          });
        }
      }
    } catch (e) {
      // Handle errors
      print('Error fetching profile picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          _buildMenuItem(Icons.location_on, 'LOCATION', onTap: () {
            Navigator.of(context).pop();
            // Add navigation or functionality here
          }),
          _buildMenuItem(Icons.edit, 'EDIT PROFILE', onTap: () {
            Navigator.of(context).pop(); // Close the menu
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditProfileScreen(username: widget.username ?? 'Guest'),
              ),
            );
          }),
          _buildMenuItem(Icons.history, 'HISTORY', onTap: () {
            Navigator.of(context).pop();
            // Add navigation or functionality here
          }),
          _buildMenuItem(Icons.settings, 'SETTINGS', onTap: () {
            Navigator.of(context).pop();
            // Add navigation or functionality here
          }),
          _buildMenuItem(Icons.info_outline, 'ABOUT US', onTap: () {
            Navigator.of(context).pop();
            // Add navigation or functionality here
          }),
          _buildMenuItem(
            Icons.description_outlined,
            'TERMS AND CONDITIONS',
            onTap: () {
              Navigator.of(context).pop();
              // Add navigation or functionality here
            },
          ),
          const Divider(height: 1),
          _buildMenuItem(
            Icons.logout,
            'LOG OUT',
            onTap: () => _logout(context),
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.lightGreen.shade50,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage:
            _profileImageUrl != null ? NetworkImage(_profileImageUrl!) : null,
            backgroundColor: Colors.lightGreen.shade200,
            child: _profileImageUrl == null
                ? Icon(
              Icons.person,
              size: 35,
              color: Colors.lightGreen.shade700,
            )
                : null,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.username ?? 'Guest', // Fallback for null username
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                widget.profileLabel,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      IconData icon,
      String title, {
        required VoidCallback onTap,
        bool isDestructive = false,
      }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: isDestructive ? Colors.red : Colors.grey[700],
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: isDestructive ? Colors.red : Colors.grey[800],
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Logout Functionality
  Future<void> _logout(BuildContext context) async {
    try {
      await Supabase.instance.client.auth.signOut();
      Navigator.of(context).pop(); // Close the ProfileMenu
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()), // Redirect to LoginScreen
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: $e')),
      );
    }
  }
}
