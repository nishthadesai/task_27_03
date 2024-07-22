import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/pages/product_listing.dart';
import 'package:task_27_03/views/product_view.dart';

import '../color/app_color.dart';
import '../custom_widgets/text_styles.dart';
import '../model/sub_category_data.dart';
import '../router/my_router.dart';

class AllCategories extends StatefulWidget {
  final String storeName;
  final List<dynamic> subCategoryList;
  const AllCategories(
      {super.key, required this.subCategoryList, required this.storeName});

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  late SubCategoryData data; //for title
  @override
  void initState() {
    data = widget.subCategoryList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.notificationColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.category,
                  style: sfBold().copyWith(fontSize: 16.spMin),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, MyRouter.productList,
                        arguments:
                            Product(widget.storeName, widget.subCategoryList));
                  },
                  child: Row(
                    children: [
                      Text(
                        "More",
                        style: sfMedium().copyWith(fontSize: 14.spMin),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 12.r,
                        color: AppColor.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  height: 235,
                  child: Row(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.subCategoryList.length > 5
                            ? 5
                            : widget.subCategoryList.length,
                        itemBuilder: (context, index) {
                          SubCategoryData productData =
                              widget.subCategoryList[index];
                          return ProductView(
                            storeName: widget.storeName,
                            data: productData,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, MyRouter.productList,
                          arguments: Product(
                              widget.storeName, widget.subCategoryList));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0).r,
                        child: Icon(
                          Icons.arrow_forward,
                          size: 25.r,
                          color: AppColor.green,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
