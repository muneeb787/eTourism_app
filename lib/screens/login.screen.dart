import 'package:etourism_app/Components/custom_ElevatedButton.dart';
import 'package:etourism_app/Utils/customColors.dart';
import 'package:etourism_app/provider/auth.provider.dart';
import 'package:etourism_app/screens/signup.screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:etourism_app/components/custom_appbar.dart';
import 'package:etourism_app/components/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  static const String pageName = '/login';

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        title: 'Login',
        showBackButton: false,
      ),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.w, vertical: 25.h),
                  child: const Image(
                    image: AssetImage('assets/images/orange-logo.png'),
                  ),
                ),
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
                          onPressed: () => _handleLogin(context),
                          text: 'Login',
                          backgroundColor: CustomColors.primaryColor,
                          textColor: Colors.white,
                        );
                },
              ),
              SizedBox(height: 20.h),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: TextStyle(color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sign Up',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushReplacementNamed(
                                context, SignupScreen.pageName);
                          },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              const Divider(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AuthProvider>().loginUser(
            email: _emailController.text,
            password: _passwordController.text,
            context: context,
          );
    }
  }
}
