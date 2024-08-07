import 'dart:async';
import 'package:etourism_app/provider/auth.provider.dart';
import 'package:etourism_app/screens/welcome.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () => Provider.of<AuthProvider>(context, listen: false)
          .checkLoginStatus(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(40.0.w),
          child: const Image(
            image: AssetImage('assets/images/white-logo.png'),
          ),
        ),
      ),
    );
  }
}
