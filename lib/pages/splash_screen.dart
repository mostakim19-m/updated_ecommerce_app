import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practice_projects/pages/bottom_navbar.dart';
import 'package:practice_projects/pages/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      Get.offAll(()=> BottomNavbar());
    },);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('E_Commerce App',style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w900,
          color: Colors.white
        ),),
      ),
      backgroundColor: Colors.indigo,
    );
  }
}
