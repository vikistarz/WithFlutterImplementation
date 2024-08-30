import'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
class PhotoFragment extends StatelessWidget {
  const PhotoFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    color: Colors.white,
    ),
    child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Column(
         children: [
           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               Container(
                 width:150.0,
                 height: 135.0,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   border: Border.all(color: HexColor("#DEE1E7"), width: 2.0),
                   image: DecorationImage(image: AssetImage("images/man_working.png"),fit: BoxFit.cover,),
                  ),
               ),

               Expanded(child: SizedBox()),

               Container(
                 width:150.0,
                 height: 135.0,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   border: Border.all(color: HexColor("#DEE1E7"), width: 2.0),
                   image: DecorationImage(image: AssetImage("images/man_working.png"),fit: BoxFit.cover,),
                 ),

               ),
             ],
           ),

           SizedBox(
            height: 20.0,
           ),

           Row(
             mainAxisAlignment: MainAxisAlignment.start,
             children: [
               Container(
                 width:150.0,
                 height: 135.0,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   border: Border.all(color: HexColor("#DEE1E7"), width: 2.0),
                   image: DecorationImage(image: AssetImage("images/man_working.png"),fit: BoxFit.cover,),
                 ),
               ),

               Expanded(child: SizedBox()),

               Container(
                 width:150.0,
                 height: 135.0,
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
                   border: Border.all(color: HexColor("#DEE1E7"), width: 2.0),
                   image: DecorationImage(image: AssetImage("images/man_working.png"),fit: BoxFit.cover,),
                 ),

               ),
             ],
           ),

           SizedBox(
             height: 40.0,
           ),
         ],
        ),
      ),
      ),
    );
  }
}
