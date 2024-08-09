import 'package:cross_platform_application/screens/signUpPage.dart';
import'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
   DetailPage({Key? key, required this.firstName, required this.password}) : super(key: key);

  String firstName, password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    leading: IconButton(onPressed: (){
     Navigator.pop(context);
    }, icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 22.0,),),
    title: Text("Details Page", style: TextStyle(color: Colors.white, fontSize: 15.0),),
    centerTitle: true,
    backgroundColor: Colors.blue,
  ) ,
      body: Column(
        children: [
          Container(
             child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(firstName),
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(password),
                 )
               ],
             ),
          ),
        ],
      ),
    );
  }
}
