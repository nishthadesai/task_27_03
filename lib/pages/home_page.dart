import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/custom_widgets/text_styles.dart';

import '../color/app_color.dart';
import '../custom_widgets/custom_app_bar.dart';
import '../model/basket_data.dart';
import '../router/my_router.dart';
import '../views/basket_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
            leading: Stack(
              children: [
                Positioned(
                  top: 15,
                  left: 15,
                  child: Icon(
                    Icons.notifications,
                    color: AppColor.black,
                    size: 28.r,
                  ),
                ),
                Positioned(
                  top: 12,
                  left: 30,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColor.green,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "2",
                        style: sfNormal()
                            .copyWith(color: AppColor.white, fontSize: 9.sp),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            title: "Huge Basket",
            action: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: badges.Badge(
                  badgeStyle: badges.BadgeStyle(badgeColor: AppColor.green),
                  position: BadgePosition.topEnd(),
                  badgeContent: Center(
                    child: Text(
                      "2",
                      style: sfNormal()
                          .copyWith(color: AppColor.white, fontSize: 9.sp),
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, MyRouter.viewCart);
                    },
                    child: Icon(
                      Icons.shopping_cart,
                      color: AppColor.black,
                      size: 28.r,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: Column(
        children: [
          Container(
            height: 50.h,
            width: double.infinity,
            color: AppColor.notificationColor,
            child: Center(
              child: Text(
                "Next delivery on Wed, 14 Nov 2020",
                style: sfMedium().copyWith(color: AppColor.green),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: basketItemsData.length,
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, index) {
                BasketData data = basketItemsData[index];
                return BasketList(data: data);
              },
            ),
          ),
        ],
      ),
    );
  }
}
