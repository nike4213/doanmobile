import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/restaurant.dart';

class MyReceipt extends StatelessWidget {
  const MyReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 50),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(25),
        child: Consumer<Restaurant>(
          builder: (context, restaurant, child) =>
              Text(restaurant.displayCartReceipt()),
        ),
      ),
    );
  }
}
