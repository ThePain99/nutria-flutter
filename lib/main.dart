import 'package:flutter/material.dart';
import 'package:nutriapp/modules/information_init/info2Page.dart';
import 'package:nutriapp/modules/information_init/infoPage.dart';
import 'package:nutriapp/modules/login_and_register/loginPage.dart';
import 'package:nutriapp/modules/login_and_register/registerPage.dart';
import 'package:nutriapp/modules/nutritionist/sidebar_nutricionist/sidebarNutricionistLayout.dart';
import 'package:nutriapp/modules/user/sidebar/sidebarLayout.dart';

void main() {
  runApp(const NutriaApp());
}

class NutriaApp extends StatelessWidget {
  const NutriaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Nutria",
      theme: ThemeData(primarySwatch: Colors.green),
      home: const RegisterPage(),
    );
  }
}
