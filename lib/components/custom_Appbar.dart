import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar CustomAppbar() {
  return AppBar(
    // centerTitle: true,
    leading: Container(),
    elevation: 0.0,
    backgroundColor: const Color(0xFF1C2129),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/onlylogo.png',
          height: 50.h,
          fit: BoxFit.fitWidth,
        ),
        Image.asset(
          'assets/images/logotext.png',
          height: 50.h,
          fit: BoxFit.fitWidth,
        )
      ],
    ),
  );
}