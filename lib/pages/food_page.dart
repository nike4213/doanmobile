import 'package:do_an_12/components/my_button.dart';
import 'package:do_an_12/controller/purchaseController.dart';
import 'package:do_an_12/models/food.dart';
import 'package:do_an_12/models/restaurant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:do_an_12/models/product/product.dart';

class FoodPage extends StatefulWidget {
  const FoodPage({
    super.key,
  });

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  void addToCart(Food food) {
    Navigator.pop(context);

    context.read<Restaurant>().addToCart(food);
  }

  @override
  Widget build(BuildContext context) {
    Product product = Get.arguments['data'];
    return Stack(
      children: [
        GetBuilder<PurchaseController>(builder: (ctrl) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  ClipRect(
                    child: Image.network(product.image ?? ''),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.name ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${product.price ?? ''}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          product.description ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MyButton(
                    text: 'Thêm Vào Giỏ Hàng',
                    onTap: () {
                      ctrl.submitOrder(
                          price: product.price ?? 0,
                          item: product.name ?? '',
                          description: product.description ?? '');
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          );
        }),
        SafeArea(
          child: Opacity(
            opacity: 0.5,
            child: Container(
              margin: const EdgeInsets.only(left: 25),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),
        )
      ],
    );
  }
}
