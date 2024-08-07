import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:etourism_app/Utils/customColors.dart';
import 'package:etourism_app/provider/customBottomNavBar.provider.dart';
import 'package:etourism_app/screens/home_page.screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class MainActivity extends StatefulWidget {
  const MainActivity({Key? key}) : super(key: key);
  static const pageName = '/main-activity';

  @override
  State<MainActivity> createState() => _MainActivityState();
}

class _MainActivityState extends State<MainActivity> {
  bool _isDeviceConnected = false;
  bool _isAlertSet = false;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    // _isDeviceConnected = await InternetConnectionChecker().hasConnection;
    // if (!_isDeviceConnected) {
    //   _showNoInternetDialog();
    // }
    //
    // _connectivitySubscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) async {
    //   _isDeviceConnected = await InternetConnectionChecker().hasConnection;
    //   if (!_isDeviceConnected && !_isAlertSet) {
    //     _showNoInternetDialog();
    //   }
    // });
  }

  void _showNoInternetDialog() {
    setState(() => _isAlertSet = true);
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('No Internet Connection'),
        content: const Text('Please check your internet connectivity'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              setState(() => _isAlertSet = false);
              _isDeviceConnected = await InternetConnectionChecker().hasConnection;
              if (!_isDeviceConnected) {
                _showNoInternetDialog();
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BottomNavBarProvider>(context);

    final List<Widget> pages = [
      HomePage(),
      const Placeholder(), // Replace with actual pages
      const Placeholder(),
      const Placeholder(),
    ];

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: pages[provider.currentIndex],
        bottomNavigationBar: SizedBox(
          height: 60, // Increase the height as needed
          child: BottomNavigationBar(
            currentIndex: provider.currentIndex,
            onTap: provider.changeCurrentIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: CustomColors.primaryColor,
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
