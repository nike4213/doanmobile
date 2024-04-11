import 'package:do_an_12/controller/home_controller.dart';
import 'package:do_an_12/pages/food_page.dart';
import 'package:do_an_12/components/my_appbar.dart';
import 'package:do_an_12/components/my_food_tile.dart';
import 'package:do_an_12/components/my_tab_bar.dart';
import 'package:do_an_12/models/food.dart';
import 'package:do_an_12/models/restaurant.dart';
import 'package:do_an_12/widget/drop_down_btn.dart';
import 'package:do_an_12/widget/products_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  // List<Food> _fillerMenuByCategory(FoodCategory category, List<Food> fullMenu) {
  //   return fullMenu.where((food) => food.category == category).toList();
  // }
  //
  // List<Widget> getFoodInThisCategory(List<Food> fullMenu) {
  //   return FoodCategory.values.map((category) {
  //     List<Food> categoryMenu = _fillerMenuByCategory(category, fullMenu);
  //
  //     return ListView.builder(
  //       itemCount: categoryMenu.length,
  //       physics: const NeverScrollableScrollPhysics(),
  //       padding: EdgeInsets.zero,
  //       itemBuilder: (context, index) {
  //         final food = categoryMenu[index];
  //         return FoodTittle(
  //           food: food,
  //           onTap: () => Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => FoodPage(food: food),
  //             ),
  //           ),
  //         );
  //       },
  //     );
  //   }).toList();
  // }

  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return RefreshIndicator(
        onRefresh: () async {
          ctrl.fetchProducts();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Color(0xFF373866),
                )),
            centerTitle: true,
          ),
          body: Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ctrl.category.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          ctrl.fitterByCategory(
                              ctrl.category[index].name ?? '');
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: Chip(
                            label: Text(ctrl.category[index].name ?? 'Error'),
                          ),
                        ),
                      );
                    }),
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: ctrl.productShowInUi.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        name: ctrl.productShowInUi[index].name ?? 'No name',
                        imageUrl: ctrl.productShowInUi[index].image ?? 'url',
                        price: ctrl.productShowInUi[index].price ?? 0,
                        onTap: () {
                          Get.to(FoodPage(),
                              arguments: {'data': ctrl.productShowInUi[index]});
                        },
                      );
                    }),
              )
            ],
          ),
          // body: NestedScrollView(
          //   headerSliverBuilder: (context, innerBoxIsScrolld) => [
          //     MyAppBar(
          //       title: MyTabBar(
          //         tabController: _tabController,
          //       ),
          //       child: Column(
          //         mainAxisAlignment: MainAxisAlignment.end,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Divider(
          //             indent: 25,
          //             endIndent: 25,
          //             color: Theme.of(context).colorScheme.secondary,
          //           )
          //         ],
          //       ),
          //     ),
          //   ],
          //   body: Consumer<Restaurant>(
          //     builder: (context, restaurant, child) => TabBarView(
          //       controller: _tabController,
          //       children: getFoodInThisCategory(restaurant.menu),
          //     ),
          //   ),
          // ),
        ),
      );
    });
  }
}
