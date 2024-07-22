import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/model/cart_data.dart';
import 'package:task_27_03/model/sub_category_data.dart';

import '../color/app_color.dart';
import '../custom_widgets/custom_app_bar.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/text_styles.dart';
import '../router/my_router.dart';

class Details {
  String storeName;
  SubCategoryData productData;
  Details(this.productData, this.storeName);
}

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  CarouselController buttonCarouselController = CarouselController();
  int carouselCurrentIndex = 0;
  ValueNotifier<int> quantity = ValueNotifier(0);
  List<dynamic> cartList = [];
  List? storedList;
  @override
  void initState() {
    // getResult();
    super.initState();
  }

  // Future<void> getResult() async {
  //   final result = await Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => const ViewCartPage()));
  // }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Details;
    quantity.value = args.productData.quantity;
    final items = [
      Image.asset(
        args.productData.image,
        height: 180.h,
        width: 140.w,
        fit: BoxFit.fill,
      ),
      Image.asset(
        args.productData.image1,
        height: 180.h,
        width: 140.w,
        fit: BoxFit.fill,
      ),
      Image.asset(
        args.productData.image2,
        height: 180.h,
        width: 140.w,
        fit: BoxFit.fill,
      ),
      Image.asset(
        args.productData.image3,
        height: 180.h,
        width: 140.w,
        fit: BoxFit.fill,
      ),
      Image.asset(
        args.productData.image4,
        height: 180.h,
        width: 140.w,
        fit: BoxFit.fill,
      ),
    ];
    return Scaffold(
      extendBody: true,
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
            title: "Product Details",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: AppColor.white),
              // height: MediaQuery.of(context).size.height * 0.40,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 160.h,
                      width: 180.w,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          // autoPlay: true,
                          // autoPlayInterval: Duration(seconds: 3),
                          // autoPlayAnimationDuration:
                          //     Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              carouselCurrentIndex = index;
                            });
                          },
                          height: 160.h,
                        ),
                        items: items,
                      ),
                    ),
                    15.verticalSpace,
                    DotsIndicator(
                      decorator: DotsDecorator(
                          spacing: EdgeInsets.all(3),
                          size: Size(12.w, 2.h),
                          activeSize: Size(12.w, 2.h),
                          color: AppColor.grey.withOpacity(0.5),
                          activeColor: AppColor.green,
                          activeShape: UnderlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.zero)),
                          shape: UnderlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.zero))),
                      dotsCount: items.length,
                      position: carouselCurrentIndex,
                    ),
                    15.verticalSpace,
                    Row(
                      children: [
                        Text(
                          args.productData.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: sfNormal().copyWith(
                            fontSize: 20.spMin,
                          ),
                        )
                      ],
                    ),
                    15.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15).r,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${args.productData.price}',
                            style: sfBold().copyWith(fontSize: 20.spMin),
                          ),
                          ValueListenableBuilder(
                            valueListenable: quantity,
                            builder: (context, value, child) {
                              if (value == 0) {
                                return DottedBorder(
                                  color: AppColor.green,
                                  borderType: BorderType.Circle,
                                  borderPadding: EdgeInsets.all(0.2),
                                  strokeWidth: 1.5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColor.addColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.8).r,
                                      child: GestureDetector(
                                        onTap: () {
                                          quantity.value++;
                                          args.productData.quantity =
                                              quantity.value;
                                        },
                                        child: Center(
                                          child: Icon(
                                            Icons.add,
                                            size: 20.r,
                                            color: AppColor.green,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: AppColor.green),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0).r,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        5.horizontalSpace,
                                        GestureDetector(
                                          onTap: () {
                                            quantity.value--;
                                            args.productData.quantity =
                                                quantity.value;
                                          },
                                          child: Icon(
                                            size: 20.r,
                                            value == 1
                                                ? Icons.delete
                                                : Icons.remove,
                                            color: value == 1
                                                ? AppColor.red
                                                : AppColor.black,
                                          ),
                                        ),
                                        10.horizontalSpace,
                                        Text(
                                          "$value",
                                          style: sfNormal().copyWith(
                                              fontSize: 16.spMin,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        10.horizontalSpace,
                                        GestureDetector(
                                          onTap: () {
                                            quantity.value++;
                                            args.productData.quantity =
                                                quantity.value;
                                          },
                                          child: Icon(
                                            size: 20.r,
                                            Icons.add,
                                            color: AppColor.black,
                                          ),
                                        ),
                                        5.horizontalSpace,
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          ),
                          Text(
                            args.productData.weight,
                            style: sfNormal().copyWith(fontSize: 16.spMin),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            20.verticalSpace,
            Container(
              // height: MediaQuery.of(context).size.height * 0.40,
              decoration: BoxDecoration(color: AppColor.white),
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Product Details",
                      style: sfMedium().copyWith(fontSize: 20.spMin),
                    ),
                    10.verticalSpace,
                    Text(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 16,
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem sum has been the industry's standard dummy text ever since the 1500s, when an unknown rinter ok a galley of type and scrambled it tomake a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                      style: sfNormal().copyWith(fontSize: 16.spMin),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColor.white.withOpacity(0.9),
              offset: const Offset(20, 10),
              blurRadius: 10.r,
            ),
          ],
          color: AppColor.notificationColor.withOpacity(0.1),
        ),
        child: SizedBox(
          height: 60.h,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 35, right: 35),
            child: CustomButton(
              onPressed: cartMap.value.containsValue(storedList)
                  ? () {
                      Navigator.pushNamed(context, MyRouter.viewCart);
                    }
                  : () {
                      if (quantity.value > 0) {
                        cartList.add(
                          CartData(
                            image: args.productData.image,
                            name: args.productData.name,
                            weight: args.productData.weight,
                            price: int.parse(args.productData.price),
                            quantity: args.productData.quantity,
                          ),
                        );
                        CartData newData = cartList[0];
                        if (cartMap.value.containsKey(args.storeName)) {
                          storedList = cartMap.value[args.storeName];

                          List? titleList = [];
                          for (int i = 0; i < storedList!.length; i++) {
                            CartData sampleData = storedList?[i];
                            titleList.add(sampleData.name);
                          }

                          if (titleList.contains(newData.name)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'This item is already in Cart',
                                ),
                              ),
                            );
                          } else {
                            storedList?.add(cartList[0]);
                            cartMap.value
                                .update(args.storeName, (value) => value);
                            Navigator.pushNamed(context, MyRouter.viewCart);
                          }
                        } else {
                          cartMap.value[args.storeName] = cartList;
                          storedList = cartMap.value[args.storeName];
                          Navigator.pushNamed(context, MyRouter.viewCart);
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Please add at least one  quantity',
                            ),
                          ),
                        );
                      }
                    },
              buttonStyle: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(AppColor.green)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.shopping_bag,
                      color: AppColor.white,
                    ),
                    10.horizontalSpace,
                    Text(
                      cartMap.value.containsValue(storedList)
                          ? "Go to Cart"
                          : "Add to cart",
                      style: sfNormal()
                          .copyWith(color: AppColor.white, fontSize: 20.spMin),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
