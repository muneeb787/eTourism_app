
import 'package:etourism_app/screens/select_auth.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider/welcome.provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  static const pageName = '/welcomeScreen';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WelcomeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Image.asset("assets/images/Travel Logo.png"),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3.h,
            child: PageView.builder(
              itemCount: 2,
              onPageChanged: (value) {
                provider.changeCurrentIndex(value);
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image(
                        image: AssetImage(provider.introData[index].imageUrl),
                        width: MediaQuery.of(context).size.width * 0.50.w,
                      ),
                      Text(
                        provider.introData[index].title,
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        provider.introData[index].subtitle,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          DotBuilder(provider.currentIndex),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(
                  context, SelectAuthentication.pageName);
            },

            child: Padding(
              padding: EdgeInsets.all(15.h),
              child: const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class DotBuilder extends StatelessWidget {
  int currentIndex;
  DotBuilder(
      this.currentIndex, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        2,
            (index) => Container(
          margin: const EdgeInsets.all(5),
          height: 10,
          width: currentIndex == index ? 30 : 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}