import 'package:do_an_12/components/my_button.dart';
import 'package:do_an_12/pages/home_page.dart';
import 'package:do_an_12/pages/payment_pay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/firestore.dart';

class ThankYou extends StatefulWidget {
  const ThankYou({super.key});

  @override
  State<ThankYou> createState() => _ThankYouState();
}

class _ThankYouState extends State<ThankYou> {
  FirestoreService db = FirestoreService();
  void initState() {
    super.initState();


  }
  void Return() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Cám ơn bạn đã mua hàng',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 50),
        ),
        SizedBox(
          height: 50,
        ),
        MyButton(
          text: 'Trở lại',
          onTap: Return,
        )
      ]),
    );
  }
}
