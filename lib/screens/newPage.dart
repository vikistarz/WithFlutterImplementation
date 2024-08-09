import 'package:cross_platform_application/screens/businessLogin.dart';
import 'package:cross_platform_application/screens/personalLogin.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class NewPage extends StatefulWidget {
   NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  bool isVisible =  true;
  bool passwordVisible =  false;

  int pageIndex = 0;

  final pages = [
    const PersonalLogInPage(),
    const BusinessLogInpage(),

  ];


  @override
  void initState() {
    super.initState();
    isVisible = true;
    passwordVisible = true;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 45.0,
                  margin: EdgeInsets.only(right: 16.0, left: 16.0, top: 100.0),
                  decoration: BoxDecoration(
                    color: Colors.grey,
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
                            pageIndex = 0;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 50.0),
                          child: Text("PERSONAL"),
                        ),
                      ),

                      InkWell(
                        onTap: (){
                          setState(() {
                            isVisible = !isVisible;
                            pageIndex = 1;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 50.0),
                          child: Text("BUSINESS"),
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
                          margin: EdgeInsets.only(left: 16.0, top: 100.0),
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0)),
                          ),
                          child: const Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 30.0),
                                child: Icon(Icons.person, color: Colors.white, size: 25.0,),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text("PERSONAL", style: TextStyle(color: Colors.white),),
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
                          margin: EdgeInsets.only(right: 16.0, top: 100.0),
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0)),
                          ),
                          child:  Row(
                            children: [
                            Container(
                              width: 25.0,
                              height: 25.0,
                              margin: EdgeInsets.only(left: 35.0),
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(13.0)
                                ),
                            ),
                             child:    Icon(Icons.cases_outlined, color: Colors.white,size: 17.0,)
                            ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text("BUSINESS",style: TextStyle(color: Colors.white)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Stack(
              children: [
                Visibility(
                  visible:  isVisible,
                  // child: pages[pageIndex],
                  child: Container(
                    decoration: BoxDecoration(
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 70.0, left: 16.0, right: 16.0),
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(3.0)),
                              border: Border.all(color: Colors.grey, width: 1.0),
                            ),
                            child: TextFormField(
                              controller: userNameController,
                              keyboardType:TextInputType.name,
                              decoration: InputDecoration(
                                  hintText: "Username",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(Icons.person, color: Colors.grey,),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(3.0)),
                              border: Border.all(color: Colors.grey, width: 1.0),
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: passwordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                 // labelText: "Last name",
                                  hintText: "password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(Icons.lock, color: Colors.grey,),
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
                         Padding(
                           padding: const EdgeInsets.only(top: 15.0, left: 16.0, right: 16.0),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Row(
                                 children: [
                                   Icon(Icons.arrow_back_ios, size: 15.0, color: Colors.purple,),
                                   Text("Back to Sign Up",style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize:12.0 ))
                                 ],
                               ),
                               Text("Forgot Credentials",style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize:12.0,),)
                             ],
                           ),
                         ),


                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
                          child: Center(
                            child: ElevatedButton(onPressed: () {

                            },
                              child: Text("Log In"),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Colors.purple, padding: EdgeInsets.all(10.0),
                                minimumSize: Size(400.0, 50.0),
                                // fixedSize: Size(300.0, 50.0),
                                textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0)),
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
                ),

                Visibility(
                  visible: !isVisible,
                  child: Container(
                    decoration: BoxDecoration(
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 70.0, left: 16.0, right: 16.0),
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(3.0)),
                              border: Border.all(color: Colors.grey, width: 1.0),
                            ),
                            child: TextFormField(
                              controller: userNameController,
                              keyboardType:TextInputType.name,
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(Icons.person, color: Colors.grey,),
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
                          child: Container(
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(3.0)),
                              border: Border.all(color: Colors.grey, width: 1.0),
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: passwordVisible,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                // labelText: "Last name",
                                  hintText: "password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(Icons.lock, color: Colors.grey,),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0, left: 16.0, right: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.arrow_back_ios, size: 15.0, color: Colors.purple,),
                                  Text("Back to Sign Up",style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize:12.0 ))
                                ],
                              ),
                              Text("Forgot Credentials",style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize:12.0,),)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
                          child: Center(
                            child: ElevatedButton(onPressed: () {

                            },
                              child: Text("Log In"),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: Colors.purple, padding: EdgeInsets.all(10.0),
                                minimumSize: Size(400.0, 50.0),
                                // fixedSize: Size(300.0, 50.0),
                                textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0),
                                      bottomLeft: Radius.circular(10.0)),
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
                ),
              ],
            ),
           Container(
             margin: EdgeInsets.only(top: 100.0, left: 16.0, right: 16.0),
             height: 100.0,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),
                   topRight: Radius.circular(15.0),
             ),
               color: Colors.yellow,
           ),
           ),
          ],
        ),
      ),
    );
  }
}
