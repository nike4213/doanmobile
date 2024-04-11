import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_12/models/catagory/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/product/product.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  late CollectionReference categoryCollection;


  List<Product> productShowInUi = [];
  List<Product> products = [];
  List<Category> category = [];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    categoryCollection = firestore.collection('category');
    await fetchProducts();
    await fetchCategory();
    super.onInit();
  }
  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs
          .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      products.clear();
      products.assignAll(retrievedProducts);
      productShowInUi.assignAll(products);
      Get.snackbar('Thành công', 'Sản phẩm thêm thành công');
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thành công');
      print(e);
    }
  }

  fetchCategory() async {
    try {
      QuerySnapshot categorySnapshot = await categoryCollection.get();
      final List<Category> retrievedCategory = categorySnapshot.docs
          .map((doc) => Category.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      category.clear();
      category.assignAll(retrievedCategory);
      Get.snackbar('Thành công', 'Sản phẩm thêm thành công');
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thành công');
      print(e);
    }
  }

  fitterByCategory(String category){
    productShowInUi.clear();
    products = products.where((product) => product.category == category).toList();
    update();
  }
}
