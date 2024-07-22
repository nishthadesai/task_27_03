import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/color/app_color.dart';
import 'package:task_27_03/model/cart_data.dart';

import '../custom_widgets/text_styles.dart';

class CartItemView extends StatefulWidget {
  final CartData cartData;
  final List? cartItem;
  final String keys;
  final int index;
  final int itemCount;
  const CartItemView(
      {super.key,
      required this.cartData,
      required this.index,
      required this.itemCount,
      this.cartItem,
      required this.keys});

  @override
  State<CartItemView> createState() => _CartItemViewState();
}

class _CartItemViewState extends State<CartItemView> {
  ValueNotifier<int> quantity = ValueNotifier<int>(0);
  @override
  void initState() {
    quantity.value = widget.cartData.quantity;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 10, top: 5, bottom: 5).r,
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                widget.cartData.image,
                height: 80.h,
                width: 70.w,
                fit: BoxFit.fill,
              ),
              15.horizontalSpace,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            widget.cartData.name,
                            style: sfMedium().copyWith(fontSize: 15.spMin),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10).r,
                          child: InkWell(
                            onTap: () {
                              print(widget.index);
                              widget.cartItem?.removeAt(widget.index);
                              if (widget.cartItem?.length == 0) {
                                cartMap.value.remove(widget.keys);
                              }
                              cartMap.notifyListeners();
                            },
                            child: Icon(
                              Icons.delete_outline_rounded,
                              color: AppColor.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    9.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: quantity,
                          builder: (context, value, child) {
                            return Text(
                              "\$ ${widget.cartData.price * value}.00",
                              style: sfBold().copyWith(fontSize: 16.spMin),
                            );
                          },
                        )
                        // ,
                      ],
                    ),
                    9.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.cartData.weight,
                          style: sfNormal().copyWith(fontSize: 14.spMin),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (quantity.value > 1) {
                                  quantity.value--;
                                  widget.cartData.quantity = quantity.value;
                                } else {
                                  widget.cartItem?.removeAt(widget.index);
                                  if (widget.cartItem?.length == 0) {
                                    cartMap.value.remove(widget.keys);
                                  }
                                  cartMap.notifyListeners();
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColor.green,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  size: 22.r,
                                  Icons.remove,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                            28.horizontalSpace,
                            ValueListenableBuilder(
                              valueListenable: quantity,
                              builder: (context, value, child) {
                                return Text(
                                  value.toString(),
                                  style:
                                      sfNormal().copyWith(fontSize: 20.spMin),
                                );
                              },
                            ),
                            28.horizontalSpace,
                            InkWell(
                              onTap: () {
                                quantity.value++;
                                widget.cartData.quantity = quantity.value;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColor.green,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  size: 22.r,
                                  Icons.add,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          5.verticalSpace,
          cartMap.value[widget.keys]!.length != widget.index + 1
              ? Divider(
                  color: AppColor.grey.withOpacity(0.4),
                )
              : Divider(
                  color: Colors.transparent,
                  height: 0,
                ),
        ],
      ),
    );
  }
}
