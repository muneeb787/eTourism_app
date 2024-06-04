import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer(
    //     // const Duration(seconds: 4),
    //     //     () => Navigator.pushReplacementNamed(
    //     //     context, WelcomeScreen.pageName)
    // );
  }

  Widget build(BuildContext context) {
    // final provider = Provider.of<SplashProvider>(context);
    // provider.checkLogin(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6.w,
          // height: 210.h,
          decoration: BoxDecoration(
              color: const Color.fromRGBO(41, 51, 62, 0.6),
              borderRadius: BorderRadius.circular(72)),
          child: Padding(
            padding: EdgeInsets.all(40.0.w),
            child: const Image(
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}