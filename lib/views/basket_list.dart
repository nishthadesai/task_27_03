import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/custom_widgets/text_styles.dart';

import '../color/app_color.dart';
import '../model/basket_data.dart';
import '../router/my_router.dart';

class BasketList extends StatelessWidget {
  final BasketData data;
  const BasketList({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, MyRouter.storeDetailsPage,
              arguments: data);
        },
        child: Card(
          elevation: 1,
          shadowColor: AppColor.white,
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.asset(
                        data.image,
                        height: 75.h,
                        width: 75.w,
                      ),
                      Positioned(
                        bottom: -2,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColor.green,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: AppColor.white,
                                  size: 10.r,
                                ),
                                2.horizontalSpace,
                                Text(
                                  "4.5",
                                  style: sfMedium().copyWith(
                                    color: AppColor.white,
                                    fontSize: 12.spMin,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  15.horizontalSpace,
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 0.30.sw,
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                data.title,
                                style: sfBold().copyWith(fontSize: 17.sp),
                              ),
                            ),
                            Text(
                              overflow: TextOverflow.ellipsis,
                              data.away,
                              style: sfNormal().copyWith(
                                  color: AppColor.black, fontSize: 14.sp),
                            ),
                          ],
                        ),
                        10.verticalSpace,
                        Text(
                          data.subTitle,
                          style: sfNormal()
                              .copyWith(color: AppColor.black, fontSize: 12.sp),
                        ),
                        5.verticalSpace,
                        Text(
                          data.address,
                          style: sfNormal()
                              .copyWith(color: AppColor.black, fontSize: 12.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
