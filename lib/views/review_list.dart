import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/model/review_data.dart';

import '../color/app_color.dart';
import '../custom_widgets/text_styles.dart';

class ReviewList extends StatefulWidget {
  final ReviewData data;
  const ReviewList({super.key, required this.data});

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  late Color rateColor;
  num value = 0;
  @override
  void initState() {
    value = widget.data.rating;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15).r,
          child: Row(
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      widget.data.image,
                      height: 80.h,
                      width: 80.w,
                      fit: BoxFit.fill,
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
                        Text(
                          widget.data.title,
                          style: sfBold().copyWith(fontSize: 17.sp),
                        ),
                        Text(
                          widget.data.away,
                          style: sfNormal()
                              .copyWith(color: AppColor.black, fontSize: 14.sp),
                        ),
                      ],
                    ),
                    5.verticalSpace,
                    Row(
                      children: List.generate(5, (index) {
                        index < value
                            ? rateColor = Colors.yellow
                            : rateColor = Colors.black;
                        return Icon(
                          Icons.star,
                          color: rateColor,
                        );
                      }),
                    ),
                    5.verticalSpace,
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      widget.data.address,
                      style: sfNormal()
                          .copyWith(color: AppColor.black, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
