import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_12/components/my_textfield.dart';
import 'package:do_an_12/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/my_button.dart';

class RegiserPage extends StatefulWidget {
  final void Function()? onTap;

  const RegiserPage({super.key, required this.onTap});

  @override
  State<RegiserPage> createState() => _RegiserPageState();
}

class _RegiserPageState extends State<RegiserPage> {
  final _emailController = TextEditingController();
  final _passwordController=TextEditingController();
  final _nameController=TextEditingController();
  final _confirmPasswordController=TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
  Future signUp() async{
    if(passwordConfirmed()){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
    }
    addUserDetail(
        _emailController.text.trim(),
    );
  }

  Future addUserDetail(String email) async{
    await FirebaseFirestore.instance.collection('user').add({
      'email':email,
    });
  }

  bool passwordConfirmed(){
    if(_passwordController.text.trim()==
        _confirmPasswordController.text.trim()){
      return true;
    }else{
      return false;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Đăng Ký',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextField(
              controller: _emailController,
              hintText: 'Email',
              obsureText: false,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              controller: _passwordController,
              hintText: 'Mật khẩu',
              obsureText: true,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              controller: _confirmPasswordController,
              hintText: 'Nhập lại Mật khẩu',
              obsureText: true,
            ),
            const SizedBox(
              height: 25,
            ),
            MyButton(
              text: "Đăng Ký",
              onTap: signUp,
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Bạn đã có tài khoản?",
                ),
                const SizedBox(
                  height: 6,
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    " Đăng Nhập ngay",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
