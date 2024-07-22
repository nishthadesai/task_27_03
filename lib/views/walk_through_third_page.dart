import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalkThroughThirdPage extends StatefulWidget {
  const WalkThroughThirdPage({super.key});

  @override
  State<WalkThroughThirdPage> createState() => _WalkThroughThirdPageState();
}

class _WalkThroughThirdPageState extends State<WalkThroughThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          height: 350.h,
          "assets/images/branding_img3.png",
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        10.verticalSpace,
        Text(
          "Chat with Supplier",
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
