import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_27_03/custom_widgets/custom_button.dart';
import 'package:task_27_03/router/my_router.dart';

import '../color/app_color.dart';
import '../custom_widgets/custom_app_bar.dart';
import '../custom_widgets/text_styles.dart';

class BillPage extends StatefulWidget {
  final int total;
  const BillPage({super.key, required this.total});

  @override
  State<BillPage> createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
  int currentIndex = 0;
  int flag = 0;
  late ValueNotifier<int> _valueNotifier;
  Map<dynamic, dynamic> promoMap = {"Flat5": 5, "Flat10": 10};
  ValueNotifier<double> discount = ValueNotifier(0);
  TextEditingController promoController = TextEditingController();
  double subTotal = 0.0;
  ValueNotifier<double> totalPrice = ValueNotifier(0.0);
  ValueNotifier<bool> isApplied = ValueNotifier(false);
  double tax = 0.0;
  List<Map<dynamic, dynamic>>? userAddress;

  @override
  void initState() {
    _valueNotifier = ValueNotifier(currentIndex);
    tax = widget.total * 0.1;
    subTotal = widget.total + tax;

    super.initState();
  }

  Future<String?> getNumber() async {
    SharedPreferences numberPref = await SharedPreferences.getInstance();
    return numberPref.getString("loginNumber");
  }

  Future<List<Map<dynamic, dynamic>>?> getAddress() async {
    var box = await Hive.openBox('user_address');
    String? phoneNo =
        await getNumber(); //function banavi ne call kre tyare ek var ma store krvanu if return any datatype
    List<dynamic>? addressList = await box.get(phoneNo);
    if (addressList != null) {
      List<Map<dynamic, dynamic>> convertedAddress =
          addressList.cast<Map<dynamic, dynamic>>().toList();
      return convertedAddress;
    } else {
      return null;
    }
  }

  Future<void> fetchAddress() async {
    List<Map<dynamic, dynamic>>? addressList = await getAddress();
    if (addressList != null) {
      setState(() {
        userAddress = addressList;
      });
    } else {
      debugPrint('No user data found');
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
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: AppColor.black,
              ),
            ),
            title: "Place Your Order",
          ),
        ),
        preferredSize: Size.fromHeight(kToolbarHeight),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: AppColor.notificationColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 53, vertical: 13)
                            .r,
                    child: Text(
                      "Next delivery on Wed, 14 Nov 2020",
                      style: sfMedium()
                          .copyWith(color: AppColor.green, fontSize: 15.spMin),
                    ),
                  ),
                ),
              ),
              15.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 19).r,
                    child: ValueListenableBuilder(
                      valueListenable: isApplied,
                      builder: (BuildContext context, value, Widget? child) {
                        if (value == false) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      onTapOutside: (PointerDownEvent event) {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                      },
                                      controller: promoController,
                                      keyboardType: TextInputType.name,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      textInputAction: TextInputAction.done,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none,
                                        hintText: "Enter Code here",
                                        hintStyle: sfMedium().copyWith(
                                            color: AppColor.halfBlack,
                                            fontSize: 14.spMin),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: DottedLine(
                                        dashGapLength: 3,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              46.horizontalSpace,
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    if (widget.total >= 100) {
                                      for (int i = 0;
                                          i < promoMap.length;
                                          i++) {
                                        if (promoMap.containsKey(
                                            promoController.text)) {
                                          flag = promoMap[promoController.text];
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Not a valid promo',
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                      if (flag != 0) {
                                        discount.value = subTotal * flag / 100;
                                        totalPrice.value =
                                            subTotal - discount.value;
                                        isApplied.value = true;
                                      } else {
                                        isApplied.value = false;
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Add items above \$100',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text(
                                    "Apply",
                                    style: sfMedium().copyWith(
                                        fontSize: 16.spMin,
                                        color: AppColor.green),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 13).r,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 2)
                                          .r,
                                      child: Text(
                                        "${promoController.text}\%",
                                        style: sfNormal()
                                            .copyWith(color: AppColor.green),
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: AppColor.green.withOpacity(0.2)),
                                  ),
                                ),
                                Center(
                                  child: InkWell(
                                    onTap: () {
                                      isApplied.value = false;
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: AppColor.black, width: 2)),
                                      child: Icon(
                                        Icons.close,
                                        size: 18.r,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    )),
              ),
              15.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 19)
                          .r,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Sub Total",
                                style: sfNormal().copyWith(fontSize: 16.spMin),
                              ),
                              8.horizontalSpace,
                              Icon(
                                Icons.info_outline,
                                size: 13.r,
                              ),
                            ],
                          ),
                          Text(
                            "\$ ${widget.total.toStringAsFixed(2)}",
                            style: sfMedium().copyWith(fontSize: 16.spMin),
                          ),
                        ],
                      ),
                      12.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Tax",
                                style: sfNormal().copyWith(fontSize: 16.spMin),
                              ),
                              8.horizontalSpace,
                              Icon(
                                Icons.info_outline,
                                size: 13.r,
                              ),
                            ],
                          ),
                          Text(
                            "\$ ${tax.toStringAsFixed(2)}",
                            style: sfMedium().copyWith(fontSize: 16.spMin),
                          ),
                        ],
                      ),
                      12.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Service Fee",
                                style: sfNormal().copyWith(fontSize: 16.spMin),
                              ),
                              8.horizontalSpace,
                              Icon(
                                Icons.info_outline,
                                size: 13.r,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "\$ 2.00",
                                style: sfMedium().copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 14.spMin,
                                  color: AppColor.black.withOpacity(0.3),
                                ),
                              ),
                              10.horizontalSpace,
                              Text(
                                "\$ 0.00",
                                style: sfMedium().copyWith(fontSize: 16.spMin),
                              ),
                            ],
                          ),
                        ],
                      ),
                      18.verticalSpace,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Delivery Fees",
                                style: sfNormal().copyWith(fontSize: 16.spMin),
                              ),
                              8.horizontalSpace,
                              Icon(
                                Icons.info_outline,
                                size: 13.r,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "\$ 3.00",
                                style: sfMedium().copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  fontSize: 14.spMin,
                                  color: AppColor.black.withOpacity(0.3),
                                ),
                              ),
                              10.horizontalSpace,
                              Text(
                                "\$ 0.00",
                                style: sfMedium().copyWith(fontSize: 16.spMin),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: 25.h,
                        color: AppColor.grey.withOpacity(0.1),
                      ),
                      ValueListenableBuilder(
                        valueListenable: isApplied,
                        builder: (context, value, child) {
                          if (value) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "\$ ${subTotal.toStringAsFixed(2)}",
                                      style: sfMedium()
                                          .copyWith(fontSize: 16.spMin),
                                    ),
                                  ],
                                ),
                                12.verticalSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Promo Applied (OFF$flag\%)",
                                      style: sfNormal()
                                          .copyWith(fontSize: 16.spMin),
                                    ),
                                    Text(
                                      "- \$ ${discount.value.toStringAsFixed(2)}",
                                      style: sfMedium().copyWith(
                                          fontSize: 16.spMin,
                                          color: AppColor.red),
                                    ),
                                  ],
                                ),
                                Divider(
                                  indent: 280.w,
                                  color: AppColor.black,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          "Total Amount",
                                          style: sfBold()
                                              .copyWith(fontSize: 16.spMin),
                                        ),
                                        8.horizontalSpace,
                                        Icon(
                                          Icons.info_outline,
                                          size: 13.r,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "\$ ${totalPrice.value.toStringAsFixed(2)}",
                                      style:
                                          sfBold().copyWith(fontSize: 16.spMin),
                                    ),
                                  ],
                                )
                              ],
                            );
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "\$ ${subTotal.toStringAsFixed(2)}",
                                  style:
                                      sfMedium().copyWith(fontSize: 16.spMin),
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              15.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ).r,
                        child: Text(
                          "Shipping",
                          style: sfMedium().copyWith(fontSize: 16.spMin),
                        ),
                      ),
                      5.verticalSpace,
                      Divider(),
                      10.verticalSpace,
                      userAddress?.length == 0
                          ? Center(
                              child: Text(
                                "Please add your shipping details.",
                                style: sfNormal().copyWith(fontSize: 14.spMin),
                              ),
                            )
                          : FutureBuilder(
                              future: fetchAddress(),
                              builder: (context, snapshot) {
                                return Column(
                                  children: [
                                    ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: userAddress?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        var address = userAddress![index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                                  horizontal: 16)
                                              .r,
                                          child: Container(
                                            child: Card(
                                              elevation: 2,
                                              color: AppColor.white,
                                              surfaceTintColor: AppColor.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                            vertical: 12,
                                                            horizontal: 21)
                                                        .r,
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        _valueNotifier.value =
                                                            index;
                                                        _valueNotifier
                                                            .notifyListeners();
                                                      },
                                                      child:
                                                          ValueListenableBuilder(
                                                        valueListenable:
                                                            _valueNotifier,
                                                        builder: (context,
                                                            value, child) {
                                                          return Icon(
                                                            Icons.album_rounded,
                                                            color: value ==
                                                                    index
                                                                ? AppColor.green
                                                                : AppColor.grey,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    30.horizontalSpace,
                                                    Flexible(
                                                      child: Text(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 2,
                                                        "${address['unitNumber']} ${address['address']}, ${address['city']}, ${address['state']}, ${address['zipCode']}",
                                                        style: sfNormal()
                                                            .copyWith(
                                                                fontSize:
                                                                    14.spMin),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                      18.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16).r,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  color: AppColor.green,
                                ),
                                7.horizontalSpace,
                                TextButton(
                                  style: ButtonStyle(
                                      padding: MaterialStatePropertyAll(
                                    EdgeInsets.zero,
                                  )),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, MyRouter.addNewAddress);
                                  },
                                  child: Text(
                                    "Add New",
                                    style: sfMedium().copyWith(
                                        fontSize: 16.spMin,
                                        color: AppColor.green),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              style: ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                EdgeInsets.zero,
                              )),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, MyRouter.manageAddress);
                              },
                              child: Text(
                                "Manage Address",
                                style: sfMedium().copyWith(
                                    fontSize: 16.spMin, color: AppColor.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              15.verticalSpace,
              Container(
                decoration: BoxDecoration(
                  color: AppColor.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16).r,
                        child: Text(
                          "Payment information",
                          style: sfMedium().copyWith(fontSize: 16.spMin),
                        ),
                      ),
                      5.verticalSpace,
                      Divider(),
                      10.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16).r,
                        child: Container(
                          child: Card(
                            color: AppColor.white,
                            shadowColor: AppColor.black,
                            elevation: 2,
                            surfaceTintColor: AppColor.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 21)
                                  .r,
                              child: Row(
                                children: [
                                  Image.asset(
                                    height: 40.h,
                                    width: 64.w,
                                    "assets/images/mastercard.png",
                                    fit: BoxFit.fill,
                                  ),
                                  35.horizontalSpace,
                                  Flexible(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          "Anthony Bailey",
                                          style: sfBold()
                                              .copyWith(fontSize: 16.spMin),
                                        ),
                                        6.verticalSpace,
                                        Text(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          "•••• •••• •••• 5678",
                                          style: sfMedium()
                                              .copyWith(fontSize: 14.spMin),
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
                      // Center(
                      //   child: Text(
                      //     "Please add your card Details",
                      //     style: sfNormal().copyWith(fontSize: 14.spMin),
                      //   ),
                      // ),
                      18.verticalSpace,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16).r,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.add_circle_outline,
                                  color: AppColor.green,
                                ),
                                7.horizontalSpace,
                                Text(
                                  "Add New",
                                  style: sfMedium().copyWith(
                                      fontSize: 16.spMin,
                                      color: AppColor.green),
                                ),
                              ],
                            ),
                            Text(
                              "Change Card",
                              style: sfMedium().copyWith(
                                  fontSize: 16.spMin, color: AppColor.green),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20).r,
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14).r,
                      child: Text(
                        "Place Order",
                        style: sfMedium().copyWith(
                            fontSize: 16.spMin, color: AppColor.white),
                      ),
                    ),
                    buttonStyle: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(AppColor.green),
                    ),
                    onPressed: () {},
                  ),
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
    discount.dispose();
    totalPrice.dispose();
    isApplied.dispose();
    promoController.dispose();
    super.dispose();
  }
}
