import 'dart:core';

class Food {
  String name;
  String description;
  String image;
  double price;
  FoodCategory category;

  Food({
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'Tên': name,
      'Hình ảnh': image,
      'Giá': price,
      'Mô tả': description,
      'Danh mục': category,
    };
  }

  factory Food.formMap(Map<String, dynamic> json) {
    return Food(
        name: json['Tên'],
        image: json['Hình ảnh'],
        description: json['Mô tả'],
        price: json['Giá'],
        category: json['Danh mục']);
  }
}

enum FoodCategory {
  Burger,
  Sandwich,
  Salad,
  Icecream
}
