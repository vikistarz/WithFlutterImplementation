import 'dart:async';

import'package:flutter/material.dart';
class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), (){
      Navigator.of(context).pushReplacementNamed('/slider');
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ) ,
      body: Center(
          child: Image(image: AssetImage("images/new_handiwork_logo.png")),
      ),
    );
  }
}
