 import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healthforecast/Core/Utils/App%20Colors.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../Core/Utils/Shared Methods.dart';
import '../../../../Core/Utils/Shared_preferences.dart';
import '../../data/models/onBoarding_Model.dart';
import '../manger/auth_controller.dart';
import '../widgets/onboarding_widget.dart';
import 'Login_Screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isShow2 = false;
  double rate = 0.25;
  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQueryWidth = MediaQuery.of(context).size.width;
    final mediaQueryTop = MediaQuery.of(context).padding.top;
    AppBar appBar = AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
    );
    final mediaQuery =
        (mediaQueryHeight - appBar.preferredSize.height - mediaQueryTop);
    var pageController = PageController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: mediaQuery*0.75,
              child: PageView.builder(
                controller: pageController,
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  setState(() {
                    if (boarding[index].isShow == false) {
                      isShow2 = false;
                      if (kDebugMode) {
                        print(isShow2);
                      }
                    } else if (boarding[index].isShow == true) {
                      isShow2 = true;
                      if (kDebugMode) {
                        print(isShow2);
                      }
                    }
                    if (index == 0 || index == 1 || index == 2) {
                      rate = boarding[index].rate;
                      print(rate.toString());
                    }
                  });
                },
                itemBuilder: (context, index) {
                  return OnBoardingWidget(
                      boarding[index], MediaQuery.of(context).size.width);
                },
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: boarding.length,
              effect: ExpandingDotsEffect(
                  spacing: 8.0,
                  radius: 12.0,
                  dotWidth: mediaQueryWidth * 0.039,
                  dotHeight: mediaQuery * 0.012,
                  dotColor: Colors.grey[300]!,
                  paintStyle: PaintingStyle.fill,
                  strokeWidth: 8,
                  activeDotColor: AppColors.primaryColor),
            ),
            const SizedBox(height: 20.0,),
            InkWell(
              onTap: () {
                if (isShow2 == false) {
                  pageController.nextPage(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.linearToEaseOut);
                } else {
                  CacheHelper.saveData("isBoarding", true)?.then((value) {
                    if (kDebugMode) {
                      print(value.toString());
                    }
                    Get.put(AuthController());
                    navigateAndFinished(context,LoginScreen());
        
                  }).catchError((error) {
                    if (kDebugMode) {
                      print("This is an error $error");
                    }
                  });
                }
              },
              child: const CircleAvatar(
                radius: 30,
                backgroundColor:AppColors.primaryColor,
                child: Icon(
                  Icons.arrow_forward_sharp,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery * 0.09,
            )
          ],
        ),
      ),
    );
  }
}
