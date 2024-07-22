import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/custom_widgets/custom_field.dart';
import 'package:task_27_03/model/sub_category_data.dart';
import 'package:task_27_03/router/my_router.dart';

import '../color/app_color.dart';
import '../custom_widgets/text_styles.dart';
import '../model/basket_data.dart';
import '../model/category_name_data.dart';
import '../views/all_category_view.dart';
import '../views/choose_category.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final TextEditingController textController = TextEditingController();
  final Map<int, List<List<dynamic>>> subcategory = {
    0: [milkList, iceCreamList],
    1: [chipsList, chipsList, chipsList, chipsList],
    2: [fishList],
    3: [],
    4: []
  };
  late ValueNotifier<int> _currentIndex;
  ValueNotifier<dynamic> _subCategoryList = ValueNotifier([
    milkList,
    iceCreamList
  ]); //new list for access only 0 current index value
  @override
  void initState() {
    _currentIndex =
        ValueNotifier<int>(0); //initialize currentIndex=0; //default index
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final listData = ModalRoute.of(context)!.settings.arguments as BasketData;
    return Scaffold(
      backgroundColor: AppColor.categoryScaffoldColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              scrolledUnderElevation: 0,
              surfaceTintColor: Colors.white,
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(25),
                child: Container(
                  height: 15.h,
                  color: AppColor.categoryScaffoldColor,
                ),
              ),
              floating: true,
              pinned: true,
              automaticallyImplyLeading: false,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: [StretchMode.zoomBackground],
                background: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Image.asset(
                      height: 262.h,
                      width: double.infinity,
                      "assets/images/store_img.png",
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: 262.h,
                      width: double.infinity,
                      color: AppColor.black.withOpacity(0.5),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20, top: 50).r,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: AppColor.white,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      margin: EdgeInsets.only(
                        top: 50,
                      ).r,
                      child: Text(
                        listData.title,
                        style: sfMedium().copyWith(
                            color: AppColor.white, fontSize: 18.spMin),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, MyRouter.viewCart);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 50, right: 20).r,
                        alignment: Alignment.topRight,
                        child: badges.Badge(
                          badgeStyle:
                              badges.BadgeStyle(badgeColor: AppColor.green),
                          position: BadgePosition.topEnd(),
                          badgeContent: Center(
                            child: Text(
                              "2",
                              style: sfNormal().copyWith(
                                  color: AppColor.white, fontSize: 9.sp),
                            ),
                          ),
                          child: Icon(
                            Icons.shopping_cart,
                            color: AppColor.white,
                            size: 25.r,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 98).r,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              height: 73,
                              width: 73,
                              listData.image,
                            ),
                          ),
                          11.verticalSpace,
                          Text(
                            listData.address,
                            style: sfNormal().copyWith(
                                color: AppColor.white, fontSize: 12.spMin),
                          ),
                          11.verticalSpace,
                          CustomTextField(
                              contentPadding: EdgeInsets.all(1),
                              prefix: Icon(Icons.search, size: 25.r),
                              controller: textController,
                              keyboardType: TextInputType.name,
                              hintText: "Search Walmart...",
                              validation: (value) {
                                return null;
                              },
                              textCapitalization: TextCapitalization.none,
                              textInputAction: TextInputAction.done,
                              obscureText: false),
                          15.verticalSpace,
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ///heading 1
              Container(
                color: AppColor.notificationColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10)
                          .r,
                      child: Text(
                        "Choose your Category",
                        style: sfBold(),
                      ),
                    ),
                    Container(
                      height: 100,
                      // color: Colors.green,
                      child: ValueListenableBuilder(
                        valueListenable: _currentIndex,
                        builder: (context, value, child) {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: categoryList.length,
                            itemBuilder: (context, index) {
                              ChooseCategoryData categoryData =
                                  categoryList[index];
                              return GestureDetector(
                                onTap: () {
                                  _currentIndex.value = index;
                                  _currentIndex.notifyListeners();
                                  // print("abc${subcategory[_currentIndex]}");
                                  if (subcategory[_currentIndex.value] !=
                                      null) {
                                    _subCategoryList
                                            .value = //[fishList] if _currentIndex.value=2;
                                        subcategory[_currentIndex.value]!;
                                    _subCategoryList.notifyListeners();
                                  } else {
                                    print("no data");
                                  }
                                },
                                child: ChooseCategory(
                                  index: index,
                                  currentIndex: _currentIndex.value,
                                  categoryData: categoryData,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20).r,
                child: ValueListenableBuilder(
                    valueListenable: _subCategoryList,
                    builder: (context, value, child) {
                      return FutureBuilder(
                          future: Future.delayed(
                            Duration(seconds: 1),
                          ),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                    color: AppColor.green),
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasError) {
                                return Center(
                                    child:
                                        Text("${snapshot.hasError} occurred"));
                              } else {
                                return Column(
                                  children: List.generate(
                                    _subCategoryList.value.length,
                                    (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 20),
                                          child: AllCategories(
                                            storeName: listData.title,
                                            subCategoryList: value[index],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.green),
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
