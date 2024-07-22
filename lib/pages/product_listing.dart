import 'dart:async';

import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/custom_widgets/custom_app_bar.dart';
import 'package:task_27_03/model/sub_category_data.dart';

import '../color/app_color.dart';
import '../custom_widgets/text_styles.dart';
import '../router/my_router.dart';
import '../views/product_view.dart';

class Product {
  final String storeName;

  final List<dynamic> listData;

  Product(this.storeName, this.listData);
}

class ProductListing extends StatefulWidget {
  const ProductListing({
    super.key,
  });

  @override
  State<ProductListing> createState() => _ProductListingState();
}

class _ProductListingState extends State<ProductListing> {
  @override
  Widget build(BuildContext context) {
    final productData = ModalRoute.of(context)!.settings.arguments as Product;
    SubCategoryData data = productData.listData[
        0]; //We fetch only first data in data object for using its category as title
    return Scaffold(
      backgroundColor: AppColor.categoryScaffoldColor,
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
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppColor.black,
                size: 28.r,
              ),
            ),
            title: data.category,
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
      body: FutureBuilder(
        future: Future.delayed(
          Duration(seconds: 1),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: AppColor.green),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text("${snapshot.hasError} occurred"));
            } else {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 232,
                ),
                itemCount: productData.listData.length,
                itemBuilder: (context, index) {
                  SubCategoryData subCategoryData = productData.listData[index];
                  return ProductView(
                    storeName: productData.storeName,
                    data: subCategoryData,
                  );
                },
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(color: AppColor.green),
          );
        },
      ),
    );
  }
}
