import 'package:cached_network_image/cached_network_image.dart';
import 'package:etourism_app/components/custom_listtile.dart';
import 'package:etourism_app/provider/auth.provider.dart';
import 'package:etourism_app/screens/privacyPolicy.screen.dart';
import 'package:etourism_app/screens/termsAndCondition.screen.dart';
import 'package:etourism_app/screens/updatePassword.screen.dart';
import 'package:etourism_app/screens/update_profile.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/customNavigator.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _showImageOptions(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              children: [
                CustomListTile(
                  icon: Icons.photo_library,
                  title: "Update Profile Picture",
                  elevation: 0,
                  onTap: () async {
                    Navigator.of(context).pop();
                    Provider.of<AuthProvider>(context, listen: false)
                        .updateUserImage(false);
                  },
                ),
                CustomListTile(
                  icon: Icons.delete,
                  title: 'Remove Profile Picture',
                  onTap: () {
                    Navigator.of(context).pop();
                    Provider.of<AuthProvider>(context, listen: false)
                        .updateUserImage(true);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final User = Provider.of<AuthProvider>(context, listen: false).userData;

    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 70,
              child: Provider.of<AuthProvider>(context).isLoading ? CircularProgressIndicator() : Stack(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: (User.imageUrl!.isNotEmpty
                          ? User.imageUrl
                          : 'https://avatar.iran.liara.run/public') ??
                          "https://avatar.iran.liara.run/public",
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.person),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: () => _showImageOptions(context),
                      child: Container(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 50 * 0.36,
                          child: Icon(Icons.edit,
                              color: Colors.red, size: 50 * 0.4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              User.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Text(
              "@${User.username}",
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(width: 8),
            SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  CustomListTile(
                    icon: Icons.edit,
                    title: 'Edit profile',
                    onTap: () {
                      NavigateWithSlideAnimation(context, UpdateProfileScreen());
                    },
                  ),
                  CustomListTile(
                    icon: Icons.password_sharp,
                    title: 'Update Password',
                    onTap: () {
                      NavigateWithSlideAnimation(context, UpdatePasswordScreen());
                    },
                  ),
                  CustomListTile(
                    icon: Icons.security,
                    title: 'Privacy Policy',
                    onTap: () {
                      NavigateWithSlideAnimation(context, PrivacyPolicy());
                    },
                  ),
                  CustomListTile(
                    icon: Icons.file_present,
                    title: 'Terms And Conditions',
                    onTap: () {
                      NavigateWithSlideAnimation(context, TermsAndCondition());
                    },
                  ),
                  CustomListTile(
                    icon: Icons.logout,
                    title: 'Logout',
                    onTap: () {
                      Provider.of<AuthProvider>(context, listen: false)
                          .logoutUser(context: context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
