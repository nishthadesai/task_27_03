import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task_27_03/color/app_color.dart';
import 'package:task_27_03/pages/login_page.dart';

import '../router/my_router.dart';
import '../views/walk_through_first_page.dart';
import '../views/walk_through_second_page.dart';
import '../views/walk_through_third_page.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({super.key});

  @override
  State<WalkThroughScreen> createState() => WalkThroughScreenState();
}

class WalkThroughScreenState extends State<WalkThroughScreen> {
  PageController pageController = PageController();
  bool lastPage = false;
  int count = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.white,
        actions: [
          lastPage
              ? Text("")
              : Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.black,
                          fontSize: 14.sp),
                    ),
                  ),
                ),
        ],
      ),
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              setState(() {
                lastPage = (index == count - 1);
              });
            },
            children: const [
              WalkThroughFirstPage(),
              WalkThroughSecondPage(),
              WalkThroughThirdPage(),
            ],
          ),
          Positioned(
            bottom: 55,
            left: 24,
            child: SmoothPageIndicator(
              controller: pageController,
              count: count,
              axisDirection: Axis.horizontal,
              effect: ExpandingDotsEffect(
                dotWidth: 10.0,
                dotHeight: 10.0,
                expansionFactor: 4,
                dotColor: AppColor.grey,
                activeDotColor: AppColor.green,
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: 24,
            child: lastPage
                ? TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        AppColor.green,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, MyRouter.loginPage);
                    },
                    child: Text(
                      "Go",
                      style: TextStyle(color: AppColor.white, fontSize: 12.sp),
                    ),
                  )
                : TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        AppColor.green,
                      ),
                    ),
                    onPressed: () {
                      pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.linear);
                    },
                    child: Text(
                      "Next",
                      style: TextStyle(color: AppColor.white, fontSize: 12.sp),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
