import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../choiceScreen/choiceScreenPage.dart';
import '../forgetPassword/passwordRecovery.dart';
import '../serviceProviderDashBoard/serviceProviderDashboard.dart';
class ServiceProviderFragment extends StatefulWidget {
  const ServiceProviderFragment({super.key});

  @override
  State<ServiceProviderFragment> createState() => _ServiceProviderFragmentState();
}

class _ServiceProviderFragmentState extends State<ServiceProviderFragment> {

  final emailAddressController = TextEditingController();
  final passwordController = TextEditingController();

  bool isVisible =  true;
  bool passwordVisible =  false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(0.0),
              height: 250.0,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("images/service_provider_design.png",), fit: BoxFit.cover),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                  child: Container(
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(color: HexColor("#212529"), width: 1.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: TextFormField(
                        controller: emailAddressController,
                        keyboardType:TextInputType.emailAddress,
                        decoration: InputDecoration(
                            hintText: "Email Address or Phone Number",
                            hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),
                            prefixIcon: Icon(Icons.person_outline_sharp,color: HexColor("#C3BDBD")),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
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
                      padding: const EdgeInsets.only(left: 0.0),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: passwordVisible,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          // labelText: "Last name",
                            hintText: "New Password",
                            hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),
                            prefixIcon: Icon(Icons.lock_open,color: HexColor("#C3BDBD")),
                            suffixIcon: IconButton(icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey,),
                              onPressed: (){
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                },
                                );
                              },
                            ),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return PasswordRecoveryPage();
                    }));
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(top: 20.0, right: 18.0),
                      child: Text("Forgot Password?",style: TextStyle(color: HexColor("#5E60CE"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0, bottom: 10.0),
                  child: Center(
                    child: ElevatedButton(onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ServiceProviderDashboardPage();
                      }));
                    },
                      child: Text("Log in", style: TextStyle(fontSize: 18.0),),
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

                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",style: TextStyle(color: HexColor("#5E60CE"), fontWeight: FontWeight.normal, fontSize:15.0,),),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return ChoiceScreenPage();
                              }));
                            },
                            child: Text("Sign Up",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:15.0,),)),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 80.0,
                )

              ],
            )
          ]
      ),
    );
  }
}
