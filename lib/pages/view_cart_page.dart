import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/model/cart_data.dart';
import 'package:task_27_03/pages/bill_page.dart';

import '../color/app_color.dart';
import '../custom_widgets/custom_app_bar.dart';
import '../custom_widgets/custom_button.dart';
import '../custom_widgets/text_styles.dart';
import '../views/cart_store_view.dart';

class ViewCartPage extends StatefulWidget {
  const ViewCartPage({super.key});

  @override
  State<ViewCartPage> createState() => _ViewCartPageState();
}

class _ViewCartPageState extends State<ViewCartPage> {
  List keysList = [];
  String storeName = "";
  ValueNotifier<int> total = ValueNotifier(00);
  ValueNotifier<List?> items = ValueNotifier([]);
  ValueNotifier<int> itemCount = ValueNotifier(0);
  @override
  void initState() {
    fetchCartMap();

    super.initState();
  }

  void fetchCartMap() {
    for (int i = 0; i < cartMap.value.keys.length; i++) {
      keysList = cartMap.value.keys
          .toList(); //keys are stored in list of keys named keysList
      storeName = keysList[i]; // keys are separated from keysList
      items.value = cartMap.value[storeName];
      if (items.value!.isNotEmpty) {
        itemCount.value = items.value!.length + itemCount.value;
      }
      print(items.value);
      for (int j = 0; j < items.value!.length; j++) {
        CartData cartData = items.value?[j];
        total.value = total.value + cartData.price * cartData.quantity;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context, itemCount.value);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColor.black,
              ),
            ),
            title: "View Cart",
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                color: AppColor.notificationColor,
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 53, vertical: 12)
                            .r,
                    child: Text(
                      "Next delivery on Wed, 14 Nov 2020",
                      style: sfMedium()
                          .copyWith(color: AppColor.green, fontSize: 15.spMin),
                    ),
                  ),
                ),
              ),
              5.verticalSpace,
              Container(
                width: double.infinity,
                color: AppColor.notificationColor,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16, top: 11, bottom: 11).r,
                  child:
                      // Consumer<TotalProvider>(
                      //   builder: (BuildContext context, TotalProvider totalProvider,
                      //       Widget? child) {
                      //     totalProvider.fetchCartMap();
                      //     return
                      Text(
                    "Sub Total (${itemCount.value} item) : \$${total.value}.00",
                    style: sfMedium()
                        .copyWith(color: AppColor.black, fontSize: 16.spMin),
                    //     );
                    //   },
                  ),
                ),
              ),
              5.verticalSpace,
              FutureBuilder(
                future: Future.delayed(Duration(seconds: 1)),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.hasError} occurred");
                    } else {
                      return ValueListenableBuilder(
                        valueListenable: cartMap,
                        builder: (context, value, child) {
                          return ListView.builder(
                            shrinkWrap: true,
                            primary: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: cartMap.value.length,
                            itemBuilder: (context, index) {
                              storeName = keysList[index];

                              return CartStoreView(
                                  storeName: storeName, items: items.value);
                            },
                          );
                        },
                      );
                    }
                  }
                  return CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 43, left: 39, right: 39).r,
        child: total.value < 10
            ? CustomButton(
                onPressed: () {},
                buttonStyle: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(AppColor.disableColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12).r,
                  child: Text(
                    "\$10 Min. to Checkout",
                    style: sfMedium()
                        .copyWith(fontSize: 16.spMin, color: AppColor.white),
                  ),
                ),
              )
            : CustomButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BillPage(total: total.value),
                      ));
                },
                buttonStyle: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(AppColor.green),
                  // backgroundColor: MaterialStatePropertyAll(AppColor.disableColor),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12).r,
                  child:
                      // Text("\$10 Min. to Checkout",style: sfMedium().copyWith(fontSize: 16.spMin,color: AppColor.white),),
                      Text(
                    "Proceed to Checkout",
                    style: sfMedium()
                        .copyWith(fontSize: 16.spMin, color: AppColor.white),
                  ),
                ),
              ),
      ),
    );
  }
}
