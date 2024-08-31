
import 'package:cross_platform_application/screens/logIn/ui/customerFragment.dart';
import 'package:cross_platform_application/screens/logIn/ui/serviceProviderFragment.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
class LogInPage extends StatefulWidget {
  LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  bool isVisible =  true;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async{
     SystemNavigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: HexColor("#212529"),
          toolbarHeight: 5.0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(0.0),
                    height: 250.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("images/login_logo_background.png",), fit: BoxFit.fitWidth),
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(20.0),
                          bottomLeft: Radius.circular(20.0)),
                  ),
                  ),

                  Center(
                    child: Container(
                      width: 250.0,
                      height: 80.0,
                      margin: EdgeInsets.only(top: 80.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage("images/handiwork_white_logo.png",), fit: BoxFit.fitWidth),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  Container(
                    height: 60.0,
                    margin: EdgeInsets.only(right: 16.0, left: 16.0, top: 25.0),
                    decoration: BoxDecoration(
                      color: HexColor("C9C9C9"),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        InkWell(
                          onTap: (){
                            setState(() {
                              isVisible = !isVisible;

                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 65.0),
                            child: Text("Customers", style: TextStyle(color: HexColor("#212529"), fontSize: 12.0),),
                          ),
                        ),

                        InkWell(
                          onTap: (){
                            setState(() {
                              isVisible = !isVisible;

                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 50.0),
                            child: Text("Service Providers",style: TextStyle(color: HexColor("#212529"), fontSize: 12.0)),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Visibility(visible: !personalVisible,
                  Row(
                    children: [
                      Expanded(
                        child: Visibility(
                          visible: isVisible,
                          child: Container(
                            height: 45.0,
                            margin: EdgeInsets.only(left: 22.0, top: 32.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0),
                                  bottomLeft: Radius.circular(30.0)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Icon(Icons.circle, color: HexColor("#5E60CE"), size: 10.0,),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 35.0),
                                  child: Text("Customers", style: TextStyle(color: HexColor("#212529"), fontSize: 12.0),),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Visibility(
                          visible: !isVisible,
                          child: Container(
                            height: 45.0,
                            margin: EdgeInsets.only(right: 22.0, top: 32.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0),
                                  bottomLeft: Radius.circular(30.0)),
                            ),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 25.0),
                                  child: Text("Service Providers",style: TextStyle(color: HexColor("#212529"), fontSize: 12.0)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Icon(Icons.circle, color: HexColor("#5E60CE"), size: 10.0,),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(
                height: 30.0,
              ),
              Stack(
                children: [
                  Visibility(
                    visible:  isVisible,
                    child: CustomerFragment(),
                  ),

                  Visibility(
                    visible:  !isVisible,
                    child: ServiceProviderFragment(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
