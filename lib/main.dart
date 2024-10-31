import 'package:cross_platform_application/screens/slider/slider.dart';
import 'package:cross_platform_application/screens/splashScreen/splashScreenPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: HexColor("#212529"),

  systemNavigationBarIconBrightness: Brightness.light));

  runApp(MyStarz());
}

class MyStarz extends StatelessWidget {
  const MyStarz({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Handiwork2',
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        routes: {
          '/splash':(context) => SplashScreenPage(),
          '/slider': (context) => SliderPage(),
        },
        // home: NewHomePage()
    );
  }
}

