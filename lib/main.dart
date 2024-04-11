import 'package:flutter/material.dart';
import 'package:login_page/pages/Signup_page.dart';
import 'package:login_page/pages/Splash.dart';
import 'package:login_page/pages/login_page.dart';
// import 'package:login_page/pages/DashBoard.dart';
import 'package:login_page/pages/home.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Flutter UI Tutorial',
      theme: ThemeData(
          fontFamily: "SF-Pro-Text"),
      home: LoginPage(),
    );
  }
}