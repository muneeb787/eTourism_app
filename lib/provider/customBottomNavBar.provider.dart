import 'package:etourism_app/screens/home_page.screen.dart';
import 'package:flutter/material.dart';


  class BottomNavBarProvider with ChangeNotifier {
    int _currentIndex = 0;

    int get currentIndex => _currentIndex;
    // FirebaseAuth auth = FirebaseAuth.instance;
    // void checkLogin(BuildContext context) {
    //   final user = auth.currentUser;
    //   if (user == null) {
    //     Future.delayed(const Duration(seconds: 3), () {
    //       Navigator.of(context).pushReplacement(
    //         MaterialPageRoute(
    //           builder: (context) => const SelectAuthentication(),
    //         ),
    //       );
    //     });
    //   }
    // }

    List<Widget> pages = [
      HomePage(),
      HomePage(),
      HomePage(),
      HomePage(),
    ];

    void changeCurrentIndex(newIndex) {
      _currentIndex = newIndex;
      notifyListeners();
    }
  }
