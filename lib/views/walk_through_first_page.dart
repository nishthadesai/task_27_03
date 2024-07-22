import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/color/app_color.dart';

import '../generated/l10n.dart';

class WalkThroughFirstPage extends StatefulWidget {
  const WalkThroughFirstPage({super.key});

  @override
  State<WalkThroughFirstPage> createState() => _WalkThroughFirstPageState();
}

class _WalkThroughFirstPageState extends State<WalkThroughFirstPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          height: 350.h,
          "assets/images/branding_img1.png",
          width: double.infinity,
          fit: BoxFit.fill,
        ),
        10.verticalSpace,
        Text(
          S.of(context).firstWalkTitle,
          style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.black),
        ),
        33.verticalSpace,
        Text(
          S.of(context).firstWalkSubTitle,
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
