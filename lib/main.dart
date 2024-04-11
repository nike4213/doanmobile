import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_an_12/admin/admin_login.dart';

import 'package:do_an_12/auth/login_or_registed.dart';
import 'package:do_an_12/controller/home_admin_controller.dart';
import 'package:do_an_12/firebase_options.dart';
import 'package:do_an_12/models/restaurant.dart';
import 'package:do_an_12/services/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'controller/home_controller.dart';



void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(HomeAdminController());
  Get.put(HomeController());
  runApp(
    ChangeNotifierProvider(
        create: (context) => Restaurant(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      // home: const AdminLogin(),
    );
  }
}

