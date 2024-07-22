import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/color/app_color.dart';
import 'package:task_27_03/pages/store_details_reviews_page.dart';

import '../custom_widgets/text_styles.dart';
import '../model/basket_data.dart';
import '../router/my_router.dart';
import '../views/about_us_view.dart';

class StoreDetails extends StatefulWidget {
  const StoreDetails({super.key});

  @override
  State<StoreDetails> createState() => _StoreDetailsState();
}

class _StoreDetailsState extends State<StoreDetails>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  ScrollController? _scrollViewController;

  TabBar get _tabBar => TabBar(
        indicator: const UnderlineTabIndicator(borderSide: BorderSide.none),
        dividerColor: AppColor.white,
        controller: tabController,
        labelColor: AppColor.green,
        labelPadding: const EdgeInsets.all(0),
        unselectedLabelColor: AppColor.grey,
        tabs: [
          buildAboutUsTab(),
          buildReviewsTab(),
        ],
      );
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    super.initState();
  }

  bool isDisplay = false;
  @override
  Widget build(BuildContext context) {
    final listData = ModalRoute.of(context)!.settings.arguments as BasketData;
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              stretch: false,
              bottom: PreferredSize(
                preferredSize: _tabBar.preferredSize,
                child: Material(
                  color: AppColor.white, //<-- SEE HERE
                  child: _tabBar,
                ),
              ),
              scrolledUnderElevation: 0,
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              automaticallyImplyLeading: false,
              expandedHeight: 290.h,
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset(
                          height: 230.h,
                          width: double.infinity,
                          "assets/images/store_img.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        height: 230.h,
                        width: double.infinity,
                        color: AppColor.black.withOpacity(0.5),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 20, top: 40).r,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: AppColor.white,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(
                          top: 40,
                        ).r,
                        child: Text(
                          "Store Details",
                          style: sfMedium().copyWith(color: AppColor.white),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40, right: 20).r,
                        alignment: Alignment.topRight,
                        child: badges.Badge(
                          badgeStyle:
                              badges.BadgeStyle(badgeColor: AppColor.green),
                          position: BadgePosition.topEnd(),
                          badgeContent: Center(
                            child: Text(
                              "2",
                              style: sfNormal().copyWith(
                                  color: AppColor.white, fontSize: 9.spMin),
                            ),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, MyRouter.viewCart);
                            },
                            child: Icon(
                              Icons.shopping_cart,
                              color: AppColor.white,
                              size: 28.spMin,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 1,
                        right: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ).r,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, MyRouter.categoryPage,
                                  arguments: listData);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                top: 175,
                              ).r,
                              child: Card(
                                elevation: 2,
                                shadowColor: AppColor.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: BorderRadius.circular(15).r,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0).r,
                                    child: Row(
                                      children: [
                                        Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Image.asset(
                                              listData.image,
                                              height: 75.h,
                                              width: 75.w,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: AppColor.green,
                                                borderRadius:
                                                    BorderRadius.circular(15).r,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                            horizontal: 5)
                                                        .r,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: AppColor.white,
                                                      size: 15.r,
                                                    ),
                                                    1.horizontalSpace,
                                                    Text(
                                                      "4.5",
                                                      style:
                                                          sfMedium().copyWith(
                                                        color: AppColor.white,
                                                        fontSize: 12.spMin,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        15.horizontalSpace,
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 0.30.sw,
                                                    child: Text(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      listData.title,
                                                      style: sfBold().copyWith(
                                                          fontSize: 17.spMin),
                                                    ),
                                                  ),
                                                  Text(
                                                    listData.away,
                                                    style: sfNormal().copyWith(
                                                        color: AppColor.grey,
                                                        fontSize: 14.spMin),
                                                  ),
                                                ],
                                              ),
                                              5.verticalSpace,
                                              Text(
                                                listData.subTitle,
                                                style: sfNormal().copyWith(
                                                    color: AppColor.grey,
                                                    fontSize: 12.spMin),
                                              ),
                                              5.verticalSpace,
                                              Text(
                                                listData.address,
                                                style: sfNormal().copyWith(
                                                    color: AppColor.grey,
                                                    fontSize: 12.spMin),
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: SafeArea(
          top: false,
          bottom: true,
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20)
                          .r,
                      child: AboutUs(),
                    ),
                    StoreDeatilsReview(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }
}

Widget buildAboutUsTab() {
  return Tab(
    child: Padding(
      padding: const EdgeInsets.only(right: 2.5).r,
      child: Container(
        padding: EdgeInsets.all(0).r,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.notificationColor,
          border: Border(
            right: BorderSide.none,
          ),
        ),
        child: Center(
          child: Text(
            "About Us",
            style: TextStyle(
              fontSize: 16.spMin,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildReviewsTab() {
  return Tab(
    child: Padding(
      padding: const EdgeInsets.only(left: 2.5).r,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(0).r,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.notificationColor,
          border: Border(
            right: BorderSide.none,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Reviews",
            style: TextStyle(fontSize: 16.spMin, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    ),
  );
}
