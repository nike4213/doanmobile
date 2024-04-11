import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PurchaseController extends GetxController {
  TextEditingController addresscontroller = TextEditingController();

  double orderPrice = 0;
  String itemName = '';
  String orderAddress = '';

  submitOrder({
    required double price,
    required String item,
    required String description,
  }) {
    orderPrice = price;
    itemName = item;
    orderAddress= addresscontroller.text;
    print('$orderPrice $itemName $orderAddress');
  }
}
