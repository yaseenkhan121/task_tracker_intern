import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryText),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text('Profile', style: AppStyles.heading1),
            centerTitle: true,
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30),
              child: Column(
                children: [
                  // ✅ Profile Photo from Firebase
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primaryPurple,
                      border: Border.all(color: AppColors.primaryLightPurple, width: 4),
                      image: user?.photoURL != null
                          ? DecorationImage(
                        image: NetworkImage(user!.photoURL!),
                        fit: BoxFit.cover,
                      )
                          : const DecorationImage(
                        image: AssetImage('assets/images/profile_avatar.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: user?.photoURL == null
                        ? const Icon(Icons.person, color: AppColors.cardWhite, size: 50)
                        : null,
                  ),
                  const SizedBox(height: 15),

                  // ✅ Name and Email from Firebase
                  Text(
                    user?.displayName ?? 'Guest User',
                    style: AppStyles.heading1.copyWith(fontSize: 22),
                  ),
                  Text(
                    user?.email ?? '',
                    style: AppStyles.secondaryBodyText.copyWith(color: AppColors.secondaryText),
                  ),

                  const SizedBox(height: 40),

                  // ✅ Action Items
                  _buildProfileListItem(context, Icons.person_outline, 'Edit Profile'),
                  _buildProfileListItem(context, Icons.settings_outlined, 'Settings'),
                  _buildProfileListItem(context, Icons.help_outline, 'Help & FAQ'),

                  // ✅ Firebase Logout
                  _buildProfileListItem(context, Icons.logout, 'Logout', isDestructive: true, onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    // TODO: Navigate back to login screen
                    Navigator.of(context).pushReplacementNamed('/login');
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileListItem(
      BuildContext context,
      IconData icon,
      String title, {
        bool isDestructive = false,
        VoidCallback? onTap,
      }) {
    return ListTile(
      leading: Icon(icon, color: isDestructive ? AppColors.redTask : AppColors.primaryPurple),
      title: Text(
        title,
        style: AppStyles.bodyText.copyWith(
          fontWeight: FontWeight.w600,
          color: isDestructive ? AppColors.redTask : AppColors.primaryText,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.secondaryText),
      onTap: onTap,
    );
  }
}
