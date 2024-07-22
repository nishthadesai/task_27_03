import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color/app_color.dart';

TextStyle sfNormal() {
  return TextStyle(
    fontSize: 16.spMin,
    fontWeight: FontWeight.w400,
    color: AppColor.black,
  );
}

TextStyle sfMedium() {
  return TextStyle(
    fontSize: 18.spMin,
    fontWeight: FontWeight.w500,
    color: AppColor.black,
  );
}

TextStyle sfBold() {
  return TextStyle(
    fontSize: 18.spMin,
    color: AppColor.black,
    fontWeight: FontWeight.w700,
  );
}
