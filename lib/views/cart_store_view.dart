import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_27_03/custom_widgets/text_styles.dart';
import 'package:task_27_03/model/cart_data.dart';

import 'cart_item_view.dart';

class CartStoreView extends StatefulWidget {
  final List? items;
  final String storeName;
  const CartStoreView({super.key, required this.storeName, this.items});

  @override
  State<CartStoreView> createState() => _CartStoreViewState();
}

class _CartStoreViewState extends State<CartStoreView> {
  ValueNotifier<List?> cartItem = ValueNotifier([]);
  int itemCount = 0;
  @override
  void initState() {
    itemCount = cartMap.value[widget.storeName]!.length;
    cartItem.value = cartMap.value[widget.storeName];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12, left: 26).r,
                child: Text(
                  widget.storeName,
                  style: sfMedium().copyWith(fontSize: 16.spMin),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(cartMap.value[widget.storeName]!.length,
                    (index) {
                  print(index);
                  CartData cartData = cartItem.value?[index];
                  return CartItemView(
                    cartItem: widget.items,
                    cartData: cartData,
                    index: index,
                    keys: widget.storeName,
                    itemCount: itemCount,
                  );
                }),
              ),
            ],
          ),
        ),
        10.verticalSpace,
      ],
    );
  }
}
