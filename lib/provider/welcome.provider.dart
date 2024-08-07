import 'package:flutter/material.dart';

import '../models/welcome.model.dart';

class WelcomeProvider with ChangeNotifier {
  final List<WelcomeScreenData> _introData = [
    WelcomeScreenData(
        imageUrl: 'assets/images/welcome-1.png',
        title: 'Explore the world with Wanderlust Adventures!',
        subtitle:
            'Discover stunning destinations, immerse yourself in diverse cultures, and uncover hidden gems. Let us turn your travel dreams into reality, creating unforgettable memories every step of the way.'),
    WelcomeScreenData(
        imageUrl: 'assets/images/welcome-2.png',
        title: 'Make Memories That Last a Lifetime',
        subtitle:
            'Whether youre exploring exotic locales or relaxing in serene getaways, our expertly crafted experiences ensure each moment is unforgettable. Discover the world and cherish the journey forever'),
    WelcomeScreenData(
        imageUrl: 'assets/images/welcome-3.png',
        title: 'Plan Your Dream Trip With Travel Mate ',
        subtitle:
            'Plan your dream trip with Travel Mate! Whether its a serene beach getaway or an adventurous mountain trek, we tailor each journey to your desires.'),
  ];

  List get introData => _introData;

  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeCurrentIndex(newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
