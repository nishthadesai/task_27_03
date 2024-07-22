import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalkThroughSecondPage extends StatefulWidget {
  const WalkThroughSecondPage({super.key});

  @override
  State<WalkThroughSecondPage> createState() => _WalkThroughSecondPageState();
}

class _WalkThroughSecondPageState extends State<WalkThroughSecondPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          height: 350.h,
          "assets/images/branding_img2.png",
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        10.verticalSpace,
        Text(
          "Secure Payment Method",
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        33.verticalSpace,
        Text(
          "Lorem Ipsum is simply dummy text of the",
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color.fromRGBO(0, 0, 0, 0.5),
          ),
        ),
        Text(
          "printing and typesetting industry.",
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color.fromRGBO(0, 0, 0, 0.5),
          ),
        ),
      ],
    );
  }
}
