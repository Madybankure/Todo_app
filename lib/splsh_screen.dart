// ignore_for_file: unnecessary_import, implementation_imports, prefer_const_constructors

import 'dart:async';
import 'dart:ui';

 
 
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:todo_six_pm/login_screen.dart';
 

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>  LoginScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
       
        body: Center(
            child: Container(
          height: 200,
          width: 200,
          child: Image(image: AssetImage('assets/icons/firebase.png'),)
        )),
      ),
    );
  }
}


