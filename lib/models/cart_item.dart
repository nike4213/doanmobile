import 'package:do_an_12/models/food.dart';
import 'package:flutter/material.dart';


class CartItem{
  Food food;
  int quantity;

  CartItem({
    required this.food,
    this.quantity = 1,
});
  double get totalPrice{
  return  food.price*quantity;
  }
}