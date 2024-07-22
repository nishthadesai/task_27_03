import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/color/app_color.dart';
import 'package:task_27_03/custom_widgets/text_styles.dart';
import 'package:task_27_03/model/sub_category_data.dart';
import 'package:task_27_03/pages/product_details_page.dart';
import 'package:task_27_03/router/my_router.dart';

class ProductView extends StatefulWidget {
  final SubCategoryData data;
  final String storeName;
  const ProductView({super.key, required this.data, required this.storeName});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  ValueNotifier<bool> oneQuantity = ValueNotifier(false);
  ValueNotifier<bool> zeroQuantity = ValueNotifier(true);

  ValueNotifier<int> quantity = ValueNotifier(0);
  @override
  void initState() {
    super.initState();
    quantity.value = widget.data.quantity;

    if (widget.data.quantity == 0) {
      zeroQuantity.value = true;
      oneQuantity.value = false;
    } else {
      zeroQuantity.value = false;
      oneQuantity.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, MyRouter.productDetails,
              arguments: Details(widget.data, widget.storeName));
        },
        child: Card(
          elevation: 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColor.white,
            ),
            width: 0.35.sw,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.asset(
                          widget.data.image,
                          height: 100,
                        ),
                      ),
                      5.horizontalSpace,
                      ValueListenableBuilder(
                        valueListenable: zeroQuantity,
                        builder: (BuildContext context, value, Widget? child) {
                          return Visibility(
                            visible: zeroQuantity.value,
                            child: DottedBorder(
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
                                  padding: const EdgeInsets.all(3.0).r,
                                  child: GestureDetector(
                                    onTap: () {
                                      oneQuantity.value = true;
                                      zeroQuantity.value = false;
                                      quantity.value++;
                                      widget.data.quantity = quantity.value;
                                    },
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
                        },
                      ),
                      ValueListenableBuilder(
                        valueListenable: oneQuantity,
                        builder: (BuildContext context, value, Widget? child) {
                          return Visibility(
                            visible: oneQuantity.value,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: AppColor.green),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0).r,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    3.verticalSpace,
                                    GestureDetector(
                                      onTap: () {
                                        quantity.value++;
                                        widget.data.quantity = quantity.value;
                                        // setState(() {
                                        //   widget.data.quantity++;
                                        // });
                                      },
                                      child: Icon(
                                        size: 20.r,
                                        Icons.add,
                                        color: AppColor.black,
                                      ),
                                    ),
                                    3.verticalSpace,
                                    ValueListenableBuilder(
                                      builder: (context, value, child) {
                                        return Text(
                                          "$value",
                                          style: sfNormal().copyWith(
                                              fontSize: 15.spMin,
                                              fontWeight: FontWeight.bold),
                                        );
                                      },
                                      valueListenable: quantity,
                                    ),
                                    3.verticalSpace,
                                    GestureDetector(
                                      onTap: () {
                                        quantity.value--;
                                        widget.data.quantity = quantity.value;
                                        if (quantity.value == 0) {
                                          zeroQuantity.value = true;
                                          oneQuantity.value = false;
                                        }
                                      },
                                      child: ValueListenableBuilder(
                                        valueListenable: quantity,
                                        builder: (context, value, child) {
                                          return Icon(
                                            value == 1
                                                ? Icons.delete
                                                : Icons.remove,
                                            size: 20.r,
                                            color: value == 1
                                                ? AppColor.red
                                                : AppColor.black,
                                          );
                                        },
                                      ),
                                    ),
                                    5.verticalSpace,
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  8.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${widget.data.price}',
                        style: sfBold().copyWith(fontSize: 14.spMin),
                      ),
                      Text(widget.data.weight),
                    ],
                  ),
                  5.verticalSpace,
                  Text(
                    widget.data.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: sfNormal().copyWith(
                      fontSize: 18.spMin,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
