import 'package:etourism_app/Components/custom_ElevatedButton.dart';
import 'package:etourism_app/Utils/customColors.dart';
import 'package:etourism_app/components/custom_Appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_text_field.dart';
import '../provider/auth.provider.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  _UpdatePasswordScreenState createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  late TextEditingController currentPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: CustomAppBar(
        title: "Update Password",
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
              CustomTextField(
                label: 'Current Password',
                controller: currentPasswordController,
                hintText: 'Enter your current password',
                borderColor: CustomColors.darkGray,
                obscureText: true,
              ),
              SizedBox(height: 10.0),
              CustomTextField(
                label: 'New Password',
                controller: newPasswordController,
                hintText: 'Enter your new password',
                borderColor: CustomColors.darkGray,
                obscureText: true,
              ),
              SizedBox(height: 10.0),
              CustomTextField(
                label: 'Confirm New Password',
                controller: confirmPasswordController,
                hintText: 'Confirm your new password',
                borderColor: CustomColors.darkGray,
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              CustomElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (newPasswordController.text ==
                        confirmPasswordController.text) {
                      // Call update password function from AuthProvider
                      await authProvider.updatePassword(
                        currentPassword: currentPasswordController.text,
                        newPassword: newPasswordController.text,
                        context: context,
                      );
                      // Add a success message or navigate back
                    } else {
                      // Show error message if passwords don't match
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Passwords do not match!'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                width: MediaQuery.of(context).size.width,
                text: "Update Password",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
