import 'package:etourism_app/screens/login.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../provider/welcome.provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static const pageName = '/welcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WelcomeProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: ()=>{
                  Navigator.pushReplacementNamed(
                  context, LoginScreen.pageName)
                  },
                  child: Text(
                  'Skip',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5.h,
              child: PageView.builder(
                controller: _pageController,
                itemCount: 3,
                onPageChanged: (value) {
                  provider.changeCurrentIndex(value);
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.7,
                        child: Image(
                          image: AssetImage(provider.introData[index].imageUrl),
                          height: MediaQuery.of(context).size.width * 0.90,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.w, vertical: 20.h),
                          child: Text(
                            provider.introData[index].title,
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          provider.introData[index].subtitle,
                          textAlign: TextAlign.left,
                          style: Theme.of(context)
                              .textTheme
                              .displayMedium
                              ?.copyWith(
                                fontSize: 15.w,
                                height: 1.5, // Set the line height
                                color:
                                    Colors.grey, // Set the text color to gray
                              ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DotBuilder(provider.currentIndex),
                GestureDetector(
                  onTap: () {
                    if (provider.currentIndex < 2) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.pageName);
                    }
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 75,
                        height: 75,
                        child: CircularProgressIndicator(
                          value: (provider.currentIndex + 1) / 3,
                          strokeWidth: 3,
                          backgroundColor: Colors.grey[300],
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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
        3,
        (index) => Container(
          margin: const EdgeInsets.all(5),
          height: 10,
          width: currentIndex == index ? 30 : 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
