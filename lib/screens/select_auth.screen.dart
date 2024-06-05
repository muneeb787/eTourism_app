
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'authentication.screen.dart';

class SelectAuthentication extends StatelessWidget {
  const SelectAuthentication({Key? key}) : super(key: key);
  static const pageName = '/selectauth';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.1),
                  Theme.of(context).primaryColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.center,
                stops: const [0.0, 0.9],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage('assets/images/logotext.png'),
                    width: MediaQuery.of(context).size.width * 0.6,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text('Certification App, Help to Create Certificates!!!',
                      style: Theme.of(context).textTheme.displaySmall),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.2,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AuthenticationScreen.pageName , arguments: 1);
                        },
                        child: Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              'Create Account',
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, AuthenticationScreen.pageName , arguments: 0);
                          Navigator.pushNamed(context, AuthenticationScreen.pageName , arguments: 0);
                        },
                        child: Container(
                          height: 55,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                            // color: Theme.of(context).colorScheme.secondary,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(width: 1, color: Colors.white)
                          ),
                          child: Center(
                            child: Text(
                              'Login',
                              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 60.h,)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}