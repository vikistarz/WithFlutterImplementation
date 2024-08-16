import 'package:cross_platform_application/screens/forgetPassword/forgetPasswordResetCode.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({super.key});

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {

  final emailAddressController = TextEditingController();

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
        title: Text("Password Recovery", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: HexColor("#212529"),),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 40.0),
                height: 210.0,
                width: 250.0,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("images/recover_password_logo.png",), fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Text("Kindly enter your email address", style: TextStyle(fontSize: 16.0),),
            ),

            Row(
              children: [
                Expanded(child: SizedBox(),
                ),

                Text("to get a", style: TextStyle(fontSize: 16.0),),

                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text("Reset Code", style: TextStyle(fontSize: 16.0, color: HexColor("#5E60CE")),),
                ),

                Expanded(child: SizedBox(),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: HexColor("#212529"), width: 1.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextFormField(
                    controller: emailAddressController,
                    keyboardType:TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "Email Address",
                        hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),
                        // prefixIcon: Icon(Icons.person_outline_sharp,color: HexColor("#C3BDBD")),
                        border: InputBorder.none
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0, bottom: 10.0),
              child: Center(
                child: ElevatedButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                         return ForgetPasswordResetCodePage();
                  }));
                },
                  child: Text("Get Code", style: TextStyle(fontSize: 18.0),),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: HexColor("#5E60CE"), padding: EdgeInsets.all(10.0),
                    minimumSize: Size(400.0, 50.0),
                    // fixedSize: Size(300.0, 50.0),
                    textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
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
