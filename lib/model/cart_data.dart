import 'package:flutter/cupertino.dart';

class CartData {
  String image, name, weight;
  int price, quantity;

  CartData({
    required this.image,
    required this.name,
    required this.price,
    required this.weight,
    required this.quantity,
  });
}

ValueNotifier<Map<dynamic, List<dynamic>>> cartMap = ValueNotifier({});
// Map<dynamic, List<dynamic>> cartMap = {
// "walmart": [
//   CartData(
//       image: "milk", name: "name", price: 3, weight: "weight", quantity: 20),
//   CartData(
//       image: "image", name: "name", price: 5, weight: "weight", quantity: 30),
// ],
// "safeway": [
//   CartData(
//       image: "image", name: "name", price: 3, weight: "weight", quantity: 20),
//   CartData(
//       image: "image", name: "name", price: 5, weight: "weight", quantity: 30),
// ],
// };
