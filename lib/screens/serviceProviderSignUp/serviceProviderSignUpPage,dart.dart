import 'package:cross_platform_application/screens/choiceScreen/choiceScreenPage.dart';
import 'package:cross_platform_application/screens/serviceProviderSignUp/serviceProviderUploadImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../dialogs/stateOfResidenceDialog.dart';



class ServiceProviderSignUpPage extends StatefulWidget {
  const ServiceProviderSignUpPage({super.key});

  @override
  State<ServiceProviderSignUpPage> createState() => _ServiceProviderSignUpPageState();
}

class _ServiceProviderSignUpPageState extends State<ServiceProviderSignUpPage> {

  void _openStateOfResidenceDialog(){
    showModalBottomSheet(
      isScrollControlled: true,
        context: context, builder: (ctx) => StateOfResidenceDialog());
  }
  bool passwordVisible = false;
  bool cityVisible = false;
  bool officeAddressVisible = false;
  bool subCategoryVisible = false;



  @override
  void initState() {
    super.initState();

    passwordVisible = true;
  }

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final mobile1Controller = TextEditingController();
  final mobile2Controller = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final officeAddressController = TextEditingController();
  final referralCodeController = TextEditingController();

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
        title: Text("Get Started as a Service Provider", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: HexColor("#212529"),),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
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
                    controller: firstNameController,
                    keyboardType:TextInputType.name,
                    decoration: InputDecoration(
                        hintText: "First name",
                        hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextFormField(
                    controller: lastNameController,
                    keyboardType:TextInputType.name,
                    decoration: InputDecoration(
                        hintText: "Last name",
                        hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextFormField(
                    controller: emailAddressController,
                    keyboardType:TextInputType.emailAddress,
                    decoration: InputDecoration(
                        hintText: "Email Address",
                        hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextFormField(
                    controller: mobile1Controller,
                    keyboardType:TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: "Mobile 1",
                        hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),
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
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextFormField(
                    controller: mobile2Controller,
                    keyboardType:TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: "Mobile 2 (Optional)",
                        hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),
                        border: InputBorder.none
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
              child: InkWell(
                onTap: (){
                  setState(() {
                    cityVisible = true;
                  });
                _openStateOfResidenceDialog();
                },
                child: Container(
                  height: 50.0,
                  width:  400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    border: Border.all(color: HexColor("#212529"), width: 1.0),
                  ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Padding(
                       padding: const EdgeInsets.only(left: 16.0),
                       child: Text("State of Residence", style: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),),
                     ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.keyboard_arrow_down, size: 25.0, color: HexColor("#C3BDBD")),
                        ),
                      ),
                   ],
                 ),
                ),
              ),
            ),

            Visibility(
              visible: cityVisible,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
                child: InkWell(
                  onTap: (){

                  },
                  child: Container(
                    height: 50.0,
                    width:  400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      border: Border.all(color: HexColor("#212529"), width: 1.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text("City", style: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Icon(Icons.keyboard_arrow_down, size: 25.0, color: HexColor("#C3BDBD")),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            Visibility(
              visible: officeAddressVisible,
              child: Padding(
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
                      controller: officeAddressController,
                      keyboardType:TextInputType.name,
                      decoration: InputDecoration(
                          hintText: "Office number and Street name",
                          hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  height: 50.0,
                  width:  400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    border: Border.all(color: HexColor("#212529"), width: 1.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text("Service Type", style: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.keyboard_arrow_down, size: 25.0, color: HexColor("#C3BDBD")),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  height: 50.0,
                  width:  400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    border: Border.all(color: HexColor("#212529"), width: 1.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text("Sub-category", style: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.keyboard_arrow_down, size: 25.0, color: HexColor("#C3BDBD")),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
              child: InkWell(
                onTap: (){

                },
                child: Container(
                  height: 50.0,
                  width:  400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    border: Border.all(color: HexColor("#212529"), width: 1.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Text("Opening Hour", style: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Icon(Icons.keyboard_arrow_down, size: 25.0, color: HexColor("#C3BDBD")),
                        ),
                      ),
                    ],
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
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: passwordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      // labelText: "Last name",
                        hintText: "New Password",
                        hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),
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
                    controller: confirmPasswordController,
                    obscureText: passwordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                      // labelText: "Last name",
                        hintText: "Confirm Password",
                        hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),
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
                    controller: referralCodeController,
                    keyboardType:TextInputType.phone,
                    decoration: InputDecoration(
                        hintText: "Referral_code (Optional)",
                        hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),
                        border: InputBorder.none
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
              child: Center(
                child: ElevatedButton(onPressed: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context){
                     return ServiceProviderUploadImagePage();
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

            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text("already have an account?", style: TextStyle(color: HexColor("#5E60CE"), fontSize: 15.0),),
                  ),
                  InkWell(
                      onTap: (){

                      },
                      child: Text("Sign in", style: TextStyle(color: HexColor("#212529"), fontSize: 15.0),),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

