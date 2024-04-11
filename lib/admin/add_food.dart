import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_12/components/my_button.dart';
import 'package:do_an_12/controller/home_admin_controller.dart';
import 'package:do_an_12/database/firestore.dart';
import 'package:do_an_12/widget/drop_down_btn.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:random_string/random_string.dart';

String? selectedValue;

class AddFood extends StatefulWidget {
  final void Function()? onTap;

  const AddFood({super.key, required this.onTap});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final List<String> fooditems = ['Burger', 'Salad', 'Sandwich', 'Icecream'];
  String? value;
  final namecontroller = TextEditingController();
  final pricecontroller = TextEditingController();
  final detailcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  Uint8List webImage = Uint8List(8);


  Future getImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var selected = File(image.path);
        setState(() {
          selectedImage = selected;
        });
      } else {
        print('Vui lòng chọn ảnh');
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          selectedImage = File('a');
        });
      } else {
        print('Vui lòng chọn ảnh');
      }
    } else {
      print('Lỗi');
    }
  }

  uploadItem() async {
    if (selectedImage != null &&
        namecontroller.text != "" &&
        pricecontroller.text != "" &&
        detailcontroller.text != "") {
      String addId = randomAlphaNumeric(10);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("blogImages").child(addId);
      final UploadTask task = firebaseStorageRef.putFile(selectedImage!);

      var downloadUrl = await (await task).ref.getDownloadURL();

      Map<String, dynamic> addItem = {
        "Hình ảnh": downloadUrl,
        "Tên": namecontroller.text,
        "Giá": pricecontroller.text,
        "Mô tả": detailcontroller.text
      };
      await FirestoreService().addFoodItem(addItem, value!).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Món đã được thêm",
              style: TextStyle(fontSize: 18.0),
            )));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeAdminController>(builder: (ctrl) {
      return Scaffold(
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
          title: Text(
            "Thêm Món",
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20.0, bottom: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Chọn hình ảnh",
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFececf8),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: ctrl.productImageController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Nhập hình",
                      ),
                    ),
                  ),
                  // selectedImage == null
                  //     ? GestureDetector(
                  //         onTap: () {
                  //           getImage();
                  //         },
                  //         child: Center(
                  //           child: Material(
                  //             elevation: 4.0,
                  //             borderRadius: BorderRadius.circular(20),
                  //             child: Container(
                  //               width: 150,
                  //               height: 150,
                  //               decoration: BoxDecoration(
                  //                 border: Border.all(
                  //                     color: Colors.black, width: 1.5),
                  //                 borderRadius: BorderRadius.circular(20),
                  //               ),
                  //               child: Icon(
                  //                 Icons.camera_alt_outlined,
                  //                 color: Colors.black,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       )
                  //     : Center(
                  //         child: Material(
                  //           elevation: 4.0,
                  //           borderRadius: BorderRadius.circular(20),
                  //           child: Container(
                  //             width: 150,
                  //             height: 150,
                  //             decoration: BoxDecoration(
                  //               border:
                  //                   Border.all(color: Colors.black, width: 1.5),
                  //               borderRadius: BorderRadius.circular(20),
                  //             ),
                  //             child: ClipRRect(
                  //               borderRadius: BorderRadius.circular(20),
                  //               child: kIsWeb
                  //                   ? Image.memory(
                  //                       webImage,
                  //                       fit: BoxFit.fill,
                  //                     )
                  //                   : Image.file(
                  //                       selectedImage!,
                  //                       fit: BoxFit.fill,
                  //                     ),
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "Tên món",
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFececf8),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: ctrl.productNameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Nhập tên món",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "Giá",
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFececf8),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: ctrl.productPriceController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Nhập giá",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Text(
                    "Mô tả",
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFececf8),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      maxLines: 6,
                      controller: ctrl.productDescriptionController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Nhập mô tả",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    "Chọn danh mục",
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // Flexible(
                  //   child: DropDownBtn(
                  //     items: ['Burger','Salad','Icecream','Sandwich'],
                  //     selectedItemText: ctrl.category,
                  //     onSelected: (selectedValue) {
                  //       ctrl.category= selectedValue ?? 'general';
                  //       ctrl.update();
                  //     },
                  //   ),
                  // ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Color(0xFFececf8),
                        borderRadius: BorderRadius.circular(10)),
                    child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                      items: fooditems
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged:  (selectedValue){
                        ctrl.category = selectedValue ?? 'general';
                        ctrl.update();
                          },
                      dropdownColor: Colors.white,
                      hint: Text("Chọn danh mục"),
                      iconSize: 36,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      value: value,
                    )),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),

                  GestureDetector(
                    onTap: () {
                      ctrl.addProduct();
                    },
                    child: Center(
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          width: 150,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              "Thêm",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
