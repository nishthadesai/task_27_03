import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../router/my_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String keyLogin = "login";

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 1),
      () async {
        var sharedPref = await SharedPreferences.getInstance();
        var isLoggedIn = sharedPref.getBool(keyLogin) ?? false;
        if (isLoggedIn) {
          Navigator.pushReplacementNamed(context, MyRouter.bottomNavigation);
        } else {
          Navigator.pushReplacementNamed(context, MyRouter.walkThrough);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              "assets/images/loading.gif",
              height: 50.h,
              width: 50.w,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  void whereToGo() async {}
}
