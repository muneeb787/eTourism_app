import 'package:etourism_app/Components/custom_ElevatedButton.dart';
import 'package:etourism_app/Utils/customColors.dart';
import 'package:etourism_app/provider/auth.provider.dart';
import 'package:etourism_app/screens/home_page.screen.dart';
import 'package:etourism_app/screens/login.screen.dart';
import 'package:etourism_app/screens/main_activity.screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:etourism_app/components/custom_appbar.dart';
import 'package:etourism_app/components/custom_text_field.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  static const String pageName = '/signup';

  final _userNameController = TextEditingController();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Signup',
        showBackButton: false,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 25.h),
                    child: const Image(
                      image: AssetImage('assets/images/orange-logo.png'),
                    ),
                  ),
                ),
                CustomTextField(
                  controller: _userNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                  label: 'Username',
                  hintText: 'Enter your username',
                ),
                CustomTextField(
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  label: 'Name',
                  hintText: 'Enter your name',
                ),
                CustomTextField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Enter your email',
                ),
                CustomTextField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  label: 'Password',
                  obscureText: true,
                  hintText: 'Enter your password',
                ),
                SizedBox(height: 20.h),
                Consumer<AuthProvider>(
                  builder: (context, authProvider, child) {
                    return authProvider.isButtonLoading
                        ? Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    )
                        : CustomElevatedButton(
                      onPressed: () => _handleSignup(context),
                      text: 'Signup',
                      backgroundColor: CustomColors.primaryColor,
                      textColor: Colors.white,
                    );
                  },
                ),
                SizedBox(height: 20.h),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Login',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacementNamed(context, MainActivity.pageName);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSignup(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthProvider>().registerUser(
        username: _userNameController.text,
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        context: context,
      );
    }
  }
}