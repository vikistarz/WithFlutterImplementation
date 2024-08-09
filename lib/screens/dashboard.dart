import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          // color: Colors.orange,
          width: 350.0,
          height: 250.0,
          // padding: EdgeInsets.only(left: 50.0,right:  50.0, top: 50.0,bottom:  20.0),
          margin: EdgeInsets.only(top: 50.0, left: 70.0, right: 70.0, bottom: 20.0),
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.orange,
            // borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey, width: 5.0),
              shape: BoxShape.circle,
            image: DecorationImage(image: AssetImage("images/img.png")),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade900,
                blurRadius: 7.0,
                spreadRadius: 10,
                offset: Offset(2,2),
              )
            ]
          ),

          // child: Text("Am tired", style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
          // ),
        )
    );
  }
}

