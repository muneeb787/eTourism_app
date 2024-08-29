import 'package:etourism_app/Screens/splash.screen.dart';
import 'package:etourism_app/provider/auth.provider.dart';
import 'package:etourism_app/provider/booking.provider.dart';
import 'package:etourism_app/provider/customBottomNavBar.provider.dart';
import 'package:etourism_app/provider/hotels.provider.dart';
import 'package:etourism_app/provider/places.provider.dart';
import 'package:etourism_app/provider/welcome.provider.dart';
import 'package:etourism_app/screens/home_page.screen.dart';
import 'package:etourism_app/screens/login.screen.dart';
import 'package:etourism_app/screens/main_activity.screen.dart';
import 'package:etourism_app/screens/signup.screen.dart';
import 'package:etourism_app/screens/welcome.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ETourismApp());
}

class ETourismApp extends StatelessWidget {
  const ETourismApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => WelcomeProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavBarProvider()),
        ChangeNotifierProvider(create: (context) => PlacesProvider()),
        ChangeNotifierProvider(create: (context) => HotelProvider()),
        ChangeNotifierProvider(create: (context) => BookingProvider()),
      ],
      child: ScreenUtilInit(
        child: GlobalLoaderOverlay(
          child: MaterialApp(
            title: 'E-Tourism',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: const Color.fromRGBO(247, 93, 55, 1.0),
              colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
                  .copyWith(secondary: const Color.fromRGBO(253, 253, 253, 1.0)),
              textTheme: const TextTheme(
                bodySmall: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
                bodyMedium: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
                bodyLarge: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 32,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                displaySmall: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 8,
                  color: Colors.black,
                ),
                displayMedium: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: Colors.black,
                ),
                displayLarge: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            // home: const SplashScreen(),
            initialRoute: '/',
            routes: {
              // When navigating to the "/" route, build the FirstScreen widget.
              '/': (context) => const SplashScreen(),
              WelcomeScreen.pageName: (context) => const WelcomeScreen(),
              LoginScreen.pageName: (context) => LoginScreen(),
              SignupScreen.pageName: (context) => SignupScreen(),
              HomePage.pageName: (context) => HomePage(),
              MainActivity.pageName: (context) => MainActivity(),
            },
          ),
        ),
      ),
    );
  }
}
