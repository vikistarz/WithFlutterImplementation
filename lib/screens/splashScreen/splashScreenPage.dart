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
      body: Center(
          child: Image(image: AssetImage("images/new_handiwork_logo.png")),
      ),
    );
  }
}
