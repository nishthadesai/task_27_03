import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color/app_color.dart';
import '../custom_widgets/custom_app_bar.dart';
import '../custom_widgets/text_styles.dart';
import '../model/review_data.dart';

class AllReviewPage extends StatefulWidget {
  const AllReviewPage({super.key});

  @override
  State<AllReviewPage> createState() => _AllReviewPageState();
}

class _AllReviewPageState extends State<AllReviewPage> {
  late Color rateColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: PreferredSize(
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: Offset(0, 3),
                blurRadius: 3.0,
              ),
            ],
          ),
          child: CustomAppBar(
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColor.black,
              ),
            ),
            title: "All Reviews",
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0).r,
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: clientReviewData.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              ReviewData data = clientReviewData[index];
              num value = data.rating;
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 15)
                            .r,
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset(
                                data.image,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.title,
                                    style: sfBold().copyWith(fontSize: 17.sp),
                                  ),
                                  Text(
                                    data.away,
                                    style: sfNormal().copyWith(
                                        color: AppColor.black, fontSize: 14.sp),
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
                                data.address,
                                style: sfNormal().copyWith(
                                    color: AppColor.black, fontSize: 12.sp),
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
            },
          ),
        ),
      ),
    );
  }
}
