import 'package:do_an_12/models/cart_item.dart';
import 'package:collection/collection.dart';
import 'food.dart';
import 'package:flutter/material.dart';

class Restaurant extends ChangeNotifier {


  List<CartItem> _cart = [];

  List<CartItem> get cart => _cart;

  void addToCart(Food food) {
    CartItem? cartItem = _cart.firstWhereOrNull((item) {
      bool isSameFood = item.food == food;
      return isSameFood;
    });

    if (cartItem != null) {
      cartItem.quantity++;
    } else {
      _cart.add(
        CartItem(food: food),
      );
    }
    notifyListeners();
  }

  @override
  void notifyListeners();

  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartItem != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

  double getTotalPrice() {
    double total = 0.0;
    for (CartItem cartItem in _cart) {
      double itemTotal = cartItem.food.price;
      total += itemTotal * cartItem.quantity;
    }

    return total;
  }
  int getTotalItemCount(){
    int totalItemCount = 0;
    for (CartItem cartItem in _cart) {
      totalItemCount +=cartItem.quantity;
    }
    return totalItemCount;
  }
  void clearCart(){
    _cart.clear();
    notifyListeners();
  }
  String displayCartReceipt(){
    final receipt = StringBuffer();
   for (final cartItem in cart){
     receipt.writeln(
       "${cartItem.quantity} x ${cartItem.food.name} - ${_formatPrice(cartItem.food.price)}Đ"
     );
     receipt.writeln();
   }
   receipt.writeln();
    receipt.writeln("Tổng số lượng: ${getTotalItemCount()}");
   receipt.writeln("Tổng tiền: ${_formatPrice(getTotalPrice())} Đ");

   return receipt.toString();
  }

  String _formatPrice(double price){
    return "${price.toStringAsFixed(2)}";
  }
}
