import 'package:do_an_12/components/my_button.dart';
import 'package:do_an_12/database/firestore.dart';
import 'package:do_an_12/models/restaurant.dart';
import 'package:do_an_12/pages/thankyou.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/my_receipt.dart';
import '../components/my_textfield.dart';

class PayMentPay extends StatefulWidget {
  const PayMentPay({super.key});

  @override
  State<PayMentPay> createState() => _PayMentPayState();
}

class _PayMentPayState extends State<PayMentPay> {
  FirestoreService db = FirestoreService();

  @override
  void initState() {
    super.initState();

    String receipt = context.read<Restaurant>().displayCartReceipt();
    // String info = context.read().displayInfo();
    db.saveOrderToDatabase(receipt);
    // db.saveInfoToDatabase(info);
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void CheckOut() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ThankYou(),
        ));
  }

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyReceipt(),
            Text(
              'Nhập Thông tin',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: nameController,
              hintText: 'Nhập họ tên',
              obsureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              controller: addressController,
              hintText: 'Địa chỉ',
              obsureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              controller: phoneController,
              hintText: 'Điện thoại',
              obsureText: false,
            ),
            const SizedBox(
              height: 25,
            ),
            MyButton(
              text: "Thanh Toán ",
              onTap: CheckOut,
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
