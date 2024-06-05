import 'package:flutter/material.dart';

import '../models/welcome.model.dart';

class WelcomeProvider with ChangeNotifier {
  final List<WelcomeScreenData> _introData = [
    WelcomeScreenData(
        imageUrl: '(assets/images/about1.png)',
        title: 'ETourism',
        subtitle:
        'Welcome to eTourism, the revolutionary app transforming the way you plan and experience travel. eTourism makes exploring new destinations easier, more personalized, and more affordable, with just a few taps'),
    WelcomeScreenData(
        imageUrl: '(../../assets/images/about2.png)',
        title: 'ETourism',
        subtitle:
        'Welcome to eTourism, the revolutionary app transforming the way you plan and experience travel. eTourism makes exploring new destinations easier, more personalized, and more affordable, with just a few taps'),
  ];

  List get introData => _introData;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeCurrentIndex(newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}