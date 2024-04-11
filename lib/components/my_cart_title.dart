import 'package:do_an_12/components/my_quaintity.dart';
import 'package:do_an_12/models/cart_item.dart';
import 'package:do_an_12/models/restaurant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;

  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
        builder: (context, restautant, child) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            cartItem.food.image,
                            height: 100,
                            width: 100,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              cartItem.food.name,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                            ),
                            Text(
                              cartItem.food.price.toString() + 'Đ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ],
                        ),
                        const Spacer(),
                        QuaintitySelector(
                            food: cartItem.food,
                            quaintity: cartItem.quantity,
                            onDecrement: () {
                              restautant.removeFromCart(cartItem);
                            },
                            onIncrement: () {
                              restautant.addToCart(cartItem.food);
                            })
                      ],
                    ),
                  )
                ],
              ),
            ));
  }
}
