import 'dart:async';

import 'package:flutter/material.dart';

import 'my_home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage(),));
    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffefff00  ),
              Color(0xff7f6000)
            ],

            begin: Alignment.topCenter,
            end: Alignment.bottomCenter

          )
        ),
        child: const Center(
          child: Text('KHUWARI APP', style: TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w500),),
        ),
      ),
    );
  }
}
