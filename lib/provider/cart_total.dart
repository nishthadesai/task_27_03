import 'package:flutter/cupertino.dart';

import '../model/cart_data.dart';

class TotalProvider extends ChangeNotifier {
  int itemCount = 0;
  int total = 00;
  List keysList = [];
  String storeName = "";
  List items = [];
  void fetchCartMap() {
    for (int i = 0; i < cartMap.value.keys.length; i++) {
      keysList = cartMap.value.keys
          .toList(); //keys are stored in list of keys named keysList
      storeName = keysList[i]; // keys are separated from keysList
      items = cartMap.value[storeName]!;
      if (items.isNotEmpty) {
        itemCount = items.length + itemCount;
      }
      for (int j = 0; j < items.length; j++) {
        CartData cartData = items[j];
        total = total + cartData.price * cartData.quantity;
      }
    }
    notifyListeners();
  }
}
