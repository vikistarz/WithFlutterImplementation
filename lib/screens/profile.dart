import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#FFFFFFFF"),
          leading: IconButton(icon: Icon(Icons.arrow_back_ios_new, size: 25.0, color: Colors.black,) , onPressed: () {  },),
          title: Text("Upload Photo", style: TextStyle(color: Colors.black, fontSize: 15.0, ),),
          elevation: 2,
          titleSpacing: 20.0,
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
           children: [
             Container(
               height: 550.0,
               margin: EdgeInsets.only(top: 180.0, left: 10.0, right: 10.0,),
               decoration: BoxDecoration(
                 color: HexColor("#F6F6F6"),
                 borderRadius: BorderRadius.only(topLeft: Radius.elliptical(10, 10),topRight: Radius.elliptical(10, 10) ),
               ),
             ),
        
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Container(
                   height: 120.0,
                   width: 120.0,
                   margin: EdgeInsets.only(top: 120.0,),
                   decoration: BoxDecoration(
                     color: HexColor("#E4DFDF"),
                     borderRadius: BorderRadius.circular(90.0),
                     border: Border.all(color: Colors.white, width: 5.0),
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(Icons.person, size: 110.0,color: Colors.grey)
        
                     ],
                   ),
                 ),
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Container(
                   height: 140.0,
                   width: 140.0,
                   margin: EdgeInsets.only(top: 140.0, left: 100.0 ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Container(
                         height: 35.0,
                         width: 35.0,
                         margin: EdgeInsets.only(top: 10.0,),
                         decoration: BoxDecoration(
                           color: HexColor("#5E60CE"),
                           borderRadius: BorderRadius.circular(20.0),
                         ),
                         child:  Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: [
                                       Icon(Icons.camera_alt_rounded, size: 20.0, color: Colors.white,)
                                     ]
                                 ),
                       )
                     ],
                   ),
                 ),
               ],
             ),
             
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Container(
                   margin: EdgeInsets.only(top: 300.0),
                   child:  Column(
        
                     children: [
                      Padding(
                        padding: EdgeInsets.only(top: 2.0),
                        child: Text("please upload your profile picture to personalize your account and", style: TextStyle(fontSize: 10.0, color: Colors.black),),
                      ),
        
                       Padding(
                         padding: EdgeInsets.only(top: 2.0),
                         child: Text("help others recognize you. Choose an image that reflects your", style: TextStyle(fontSize: 10.0, color: Colors.black),),
                       ),
        
                       Padding(
                         padding: EdgeInsets.only(top: 2.0),
                         child: Text("personality or interests.", style: TextStyle(fontSize: 10.0, color: Colors.black),),
                       )
                     ],
                   ),
                 ),
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Container(
                   margin: EdgeInsets.only(top: 400.0, left: 16.0, right: 16.0),
                 child: ElevatedButton(
                   onPressed: () { },
                   child: Text("Add Photo"),
                   style: ElevatedButton.styleFrom(
                     foregroundColor: Colors.white, backgroundColor: HexColor("#5E60CE"), padding: EdgeInsets.all(10.0),
                     fixedSize: Size(280.0, 50.0),
                     textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
                     elevation: 5,
                     // side: BorderSide(color: Colors.black, width: 2),
                     // alignment: Alignment.topCenter
                   ),
                 ),
                 ),
               ],
             )
           ],
        ),
      ),
        );
  }
}
