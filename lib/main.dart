
import 'package:etourism_app/Screens/splash.screen.dart';
import 'package:etourism_app/provider/auth.provider.dart';
import 'package:etourism_app/provider/welcome.provider.dart';
import 'package:etourism_app/screens/authentication.screen.dart';
import 'package:etourism_app/screens/select_auth.screen.dart';
import 'package:etourism_app/screens/welcome.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      ],
      child: ScreenUtilInit(
        child: MaterialApp(
          title: 'E-Tourism',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: const Color.fromRGBO(28, 33, 41, 1.0),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
                .copyWith(secondary: const Color.fromRGBO(55, 184, 252, 1.0)),
            textTheme: const TextTheme(
              bodySmall: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w900, color: Colors.white),
              bodyMedium: TextStyle(
                  fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white),
              bodyLarge: TextStyle(
                  fontSize: 32, fontWeight: FontWeight.normal, color: Colors.white),
              displaySmall: TextStyle(fontSize: 8, color: Colors.white),
              displayMedium: TextStyle(fontSize: 14, color: Colors.white),
              displayLarge: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          // home: const SplashScreen(),
          initialRoute: '/',
          routes: {
            // When navigating to the "/" route, build the FirstScreen widget.
            '/': (context) => const SplashScreen(),
            WelcomeScreen.pageName: (context) => const WelcomeScreen(),
            SelectAuthentication.pageName: (context) => const SelectAuthentication(),

            AuthenticationScreen.pageName: (context) => const AuthenticationScreen(),
          },
        ),
      ),
    );
  }
}