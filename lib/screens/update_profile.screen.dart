import 'package:cached_network_image/cached_network_image.dart';
import 'package:etourism_app/Components/custom_ElevatedButton.dart';
import 'package:etourism_app/Utils/customColors.dart';
import 'package:etourism_app/components/custom_Appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_text_field.dart';
import '../provider/auth.provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.userData;

    // Initialize the controllers and set their initial values
    nameController = TextEditingController(text: user.name ?? "");
    usernameController = TextEditingController(text: user.username ?? "");
    emailController = TextEditingController(text: user.email ?? "");
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is removed
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Update Your Data",
        showBackButton: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 30),
              CircleAvatar(
                radius: 70,
                child: authProvider.isLoading
                    ? CircularProgressIndicator()
                    : Stack(
                  children: [
                    ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: authProvider.userData.imageUrl?.isNotEmpty == true
                            ? authProvider.userData.imageUrl!
                            : 'https://avatar.iran.liara.run/public',
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.person),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              CustomTextField(
                label: 'Name',
                controller: nameController,
                hintText: 'Enter your name',
                borderColor: CustomColors.darkGray,
              ),
              SizedBox(height: 10.0),
              CustomTextField(
                label: 'Username',
                controller: usernameController,
                hintText: 'Enter your username',
                borderColor: CustomColors.darkGray,
              ),
              SizedBox(height: 10.0),
              CustomTextField(
                label: 'Email',
                controller: emailController,
                hintText: 'Email',
                borderColor: CustomColors.darkGray,
                readOnly: true, // Disable editing
              ),
              SizedBox(height: 20.0),
              CustomElevatedButton(
                onPressed: () async {
                  // Call update function from AuthProvider
                  await authProvider.updateProfileData(
                    name: nameController.text,
                    username: usernameController.text,
                    context: context,
                  );
                  // You can add a success message or navigate back
                },
                width: MediaQuery.of(context).size.width,
                text: "Update",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
