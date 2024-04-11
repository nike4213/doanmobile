import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_12/models/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAdminController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productDescriptionController = TextEditingController();
  TextEditingController productImageController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  String category = 'general';

  List<Product> products = [];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    await fetchProducts();
    super.onInit();
  }

  addProduct() {
    try {
      DocumentReference doc = productCollection.doc();
      Product product = Product(
        id: doc.id,
        name: productNameController.text,
        category: category,
        description: productDescriptionController.text,
        price: double.tryParse(productPriceController.text),
        image: productImageController.text,
      );
      final productJson = product.toJson();
      doc.set(productJson);
      Get.snackbar('Thành công', 'Thêm sản phẩm thành công');
    } catch (e) {
      Get.snackbar('Lỗi', e.toString());
      print(e);
    }
  }

  fetchProducts() async {
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Product> retrievedProducts = productSnapshot.docs
              .map((doc) => Product.fromJson(doc.data() as Map<String, dynamic>))
              .toList();
      products.clear();
      products.assignAll(retrievedProducts);
      Get.snackbar('Thành công', 'Sản phẩm thêm thành công');
    } catch (e) {
      Get.snackbar('Lỗi', 'Không thành công');
      print(e);
    }
  }

  setValuesDefault() {
    productNameController.clear();
    productImageController.clear();
    productPriceController.clear();
    productDescriptionController.clear();
    update();
  }
}
