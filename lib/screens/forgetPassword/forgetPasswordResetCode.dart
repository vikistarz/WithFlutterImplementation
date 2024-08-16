import 'package:cross_platform_application/screens/forgetPassword/resetPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pinput/pin_put/pin_put.dart';

class ForgetPasswordResetCodePage extends StatefulWidget {
  const ForgetPasswordResetCodePage({super.key});

  @override
  State<ForgetPasswordResetCodePage> createState() => _ForgetPasswordResetCodePageState();
}

class _ForgetPasswordResetCodePageState extends State<ForgetPasswordResetCodePage> {

  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        toolbarHeight: 50.0,
        backgroundColor: Colors.white,
        leading: IconButton(
        icon: Icon(Icons.arrow_back, size: 25.0, color: HexColor("#212529"),), onPressed: (){
    Navigator.pop(context);
    }, color: HexColor("#212529")
    ) ,
    title: Text("Verification Code", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: HexColor("#212529"),),),
    centerTitle: true,
    ),
    body: SingleChildScrollView(
    scrollDirection: Axis.vertical,
     child: Column(
         children: [
           Center(
             child: Container(
               margin: EdgeInsets.only(top: 50.0),
               height: 210.0,
               width: 250.0,
               decoration: BoxDecoration(
                 image: DecorationImage(image: AssetImage("images/verification_code_logo.png",), fit: BoxFit.cover),
               ),
             ),
           ),
           Padding(
             padding: const EdgeInsets.only(top: 30),
             child: Text("Kindly enter the code sent to you", style: TextStyle(fontSize: 16.0),),
           ),

           Row(
             children: [
               Expanded(child: SizedBox(),
               ),

               Text("email", style: TextStyle(fontSize: 16.0),),

               Padding(
                 padding: const EdgeInsets.only(left: 5),
                 child: Text("Address", style: TextStyle(fontSize: 16.0, color: HexColor("#5E60CE")),),
               ),

               Expanded(child: SizedBox(),
               ),
             ],
           ),
       Padding(
         padding: const EdgeInsets.only(top: 30),
         child: OtpTextField(
           numberOfFields: 4,
           borderColor: Colors.black
           // showFieldAsBox: true,
           // controller: pinController,
         ),
       ),

           Padding(
             padding: const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
             child: Center(
               child: ElevatedButton(onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                     return ResetPasswordPage();
                   }));
               },
                 child: Text("Continue", style: TextStyle(fontSize: 18.0),),
                 style: ElevatedButton.styleFrom(
                   foregroundColor: Colors.white, backgroundColor: HexColor("#5E60CE"), padding: EdgeInsets.all(10.0),
                   minimumSize: Size(400.0, 50.0),
                   // fixedSize: Size(300.0, 50.0),
                   textStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                   elevation: 2,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),
                         topRight: Radius.circular(15.0),
                         bottomRight: Radius.circular(15.0),
                         bottomLeft: Radius.circular(15.0)),
                   ),
                   // side: BorderSide(color: Colors.black, width: 2),
                   // alignment: Alignment.topCenter
                 ),
               ),
             ),
           ),

         ],
     ),

    ),
    );
  }
}
