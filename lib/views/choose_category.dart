import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color/app_color.dart';
import '../custom_widgets/text_styles.dart';
import '../model/category_name_data.dart';

class ChooseCategory extends StatelessWidget {
  final ChooseCategoryData categoryData;
  final int index;
  final int currentIndex;
  const ChooseCategory({
    super.key,
    required this.categoryData,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8).r,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              shape: BoxShape.circle,
              border: currentIndex == index
                  ? Border.all(color: AppColor.green)
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(categoryData.image,
                  fit: BoxFit.fill, height: 35.h, width: 35.w),
            ),
          ),
          9.verticalSpace,
          Text(
            categoryData.name,
            style: sfNormal().copyWith(
                fontSize: 12.sp,
                color: currentIndex == index ? AppColor.green : AppColor.black),
          ),
        ],
      ),
    );
  }
}
