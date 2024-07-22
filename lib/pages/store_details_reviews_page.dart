import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/custom_widgets/text_styles.dart';
import 'package:task_27_03/router/my_router.dart';

import '../model/review_data.dart';
import '../views/review_list.dart';

class StoreDeatilsReview extends StatefulWidget {
  const StoreDeatilsReview({super.key});

  @override
  State<StoreDeatilsReview> createState() => _StoreDeatilsReviewState();
}

class _StoreDeatilsReviewState extends State<StoreDeatilsReview> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 1)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text("${snapshot.error} occurred");
            }
            return Column(
              children: [
                15.verticalSpace,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        " All Reviews (${clientReviewData.length})",
                        style: sfBold().copyWith(fontSize: 16.sp),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, MyRouter.allReview);
                        },
                        child: Text(
                          "View All",
                          style: sfBold().copyWith(fontSize: 12.sp),
                        ),
                      ),
                    ],
                  ),
                ),
                15.verticalSpace,
                Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: 4,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        ReviewData data = clientReviewData[index];

                        return ReviewList(
                          data: data,
                        );
                      }),
                ),
              ],
            );
          } else {
            return Center(
              child: Center(
                child: Image.asset(
                  height: 30.h,
                  width: 30.w,
                  "assets/images/loading_dots.gif",
                ),
              ),
            );
          }
        });
  }
}
