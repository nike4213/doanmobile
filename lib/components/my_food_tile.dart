import 'package:do_an_12/models/food.dart';
import 'package:flutter/material.dart';

class FoodTittle extends StatelessWidget {
  final Food food;
  final void Function()? onTap;

  const FoodTittle({
    super.key,
    required this.food,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(food.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                    Text(
                      food.price.toString() + 'Đ',style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10.0),
                    Text(food.description,style: TextStyle(fontSize: 20)),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  food.image,
                  height: 120,
                ),
              ),
            ]),
          ),
        ),
        Divider(
          endIndent: 25,
          indent: 25,
        )
      ],
    );
  }
}
