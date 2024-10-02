import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
     SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  bool isContactArrowVisible =  true;
  bool isGlobalArrowVisible =  true;
  bool isTermsArrowVisible =  true;
  bool isFreeArrowVisible =  true;
  bool isGetJobArrowVisible =  true;
  bool isFindMeArrowVisible =  true;

  bool isContactVisible = true;
  bool isGlobal = true;
  bool isFreeVisible =  true;
  bool isGetJobVisible =  true;
  bool isFindMeVisible =  true;

  String phoneNumber = "08029425815";
  String countryCode = "234";

  void openWhatsApp() async  {
    var whatsappUrl = Uri.parse("whatsapp://send?phone=${countryCode + phoneNumber}");
    try {
      launchUrl(whatsappUrl);
    }
    catch(e){
      debugPrint.toString();
    }
  }


  void makePhoneCall() async {
    var callUri = Uri.parse("tel:$phoneNumber");
    try{
      launchUrl(callUri);
    }
    catch(e){
      debugPrint.toString();
    }
  }


  void sendSMS() async {
    var smsUri = Uri.parse("sms:$phoneNumber");
    try{
      launchUrl(smsUri);
    }
    catch(e){
      debugPrint.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50.0,
        backgroundColor: Colors.white,
        leading:  new GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 16.0, right: 20.0),
            width: 16.0,
              height: 18.0,
            child: Image(image: AssetImage("images/arrow_back.png"),),
             ),
        ),
        title: Text("Support", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: HexColor("#212529"),),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 15.0, right: 16.0, left: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(color: HexColor("#DEE1E7"), width: 1.5),
          ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Image(image: AssetImage("images/phone_line.png"), width: 20.0, height: 20.0,),
              ),

                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text("Contact Us", style: TextStyle(color: HexColor("#212529"), fontSize: 12.0, fontWeight: FontWeight.normal,)),
                ),

                Expanded(child: SizedBox()),

               Stack(
                 children: [
                   Visibility(
                     visible: !isContactArrowVisible,
                     child: Align(
                       alignment: Alignment.centerRight,
                       child: new GestureDetector(
                         onTap: () {
                           setState(() {
                             isContactVisible = !isContactVisible;
                             isContactArrowVisible = !isContactArrowVisible;
                           });
                         },
                       child: Container(
                         width: 150.0,
                         height: 45.0,
                         child: Align(
                           alignment: Alignment.centerRight,
                           child: Padding(
                             padding: const EdgeInsets.only(right: 30.0),
                             child: Icon(Icons.keyboard_arrow_up, size: 30.0,color: HexColor("#DEE1E7"),),
                           ),
                         ),
                       ),
                       ),
                     ),
                   ),

                     Visibility(
                       visible: isContactArrowVisible,
                       child: Align(
                         alignment: Alignment.centerRight,
                         child: new GestureDetector(
                           onTap: () {
                             setState(() {
                               isContactVisible = !isContactVisible;
                               isContactArrowVisible = !isContactArrowVisible;
                             });
                           },
                           child: Container(
                             width: 150.0,
                             height: 45.0,
                             child: Align(
                               alignment: Alignment.centerRight,
                               child: Padding(
                                 padding: const EdgeInsets.only(right: 30.0),
                                 child: Icon(Icons.keyboard_arrow_down, size: 30.0,color: HexColor("#DEE1E7"),),
                               ),
                             ),
                           ),
                         ),
                       ),
                   ),
                 ],
               ),
              ],
            ),
          ),

        Visibility(
          visible: !isContactVisible,
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 10.0, right: 16.0, left: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
            ),
            child: Column(

              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 17.0),
                    child: Text("Help Line", style: TextStyle(color: HexColor("#212529"), fontSize: 11.0, fontWeight: FontWeight.normal,)),
                  ),
                ),

                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0, top: 10.0),
                    child: Text("+234 802 942 5815", style: TextStyle(color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.bold,)),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    new GestureDetector(
                     onTap: (){
                       openWhatsApp();
                    },

                      child: Container(
                        height: 45.0,
                        width: 45.0,
                        margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 40.0, bottom: 30.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(22.0)),
                            boxShadow: [
                              BoxShadow(
                                color: HexColor("#C3BDBD"),
                                blurRadius: 0.5,
                                spreadRadius: 0.5,
                                offset: Offset(0.5,0.5),
                              ),
                            ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image(image: AssetImage("images/whatsapp_icon.png",),
                          ),
                        ),
                      ),
                    ),

                    new GestureDetector(
                      onTap: (){
                        sendSMS();
                      },
                      child: Container(
                        height: 45.0,
                        width: 45.0,
                        margin: EdgeInsets.only(top: 20.0, right: 20.0, bottom: 30.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(22.0)),
                            boxShadow: [
                              BoxShadow(
                                color: HexColor("#C3BDBD"),
                                blurRadius: 0.5,
                                spreadRadius: 0.5,
                                offset: Offset(0.5,0.5),
                              )
                            ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image(image: AssetImage("images/email.png",),
                          ),
                        ),
                      ),
                    ),

                    new GestureDetector(
                      onTap: () {
                        makePhoneCall();
                      },
                      child: Container(
                        height: 45.0,
                        width: 45.0,
                        margin: EdgeInsets.only(top: 20.0, bottom: 30.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(22.0)),
                            boxShadow: [
                              BoxShadow(
                                color: HexColor("#C3BDBD"),
                                blurRadius: 0.5,
                                spreadRadius: 0.5,
                                offset: Offset(0.5,0.5),
                              )
                            ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image(image: AssetImage("images/phone_line.png",),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],

            ),
          ),
        ),

              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 15.0, right: 16.0, left: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(color: HexColor("#DEE1E7"), width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Image(image: AssetImage("images/quill_paper.png"), width: 25.0, height: 25.0,),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("Terms of Use & Privacy Policy", style: TextStyle(color: HexColor("#212529"), fontSize: 12.0, fontWeight: FontWeight.normal,)),
                    ),

                    Expanded(child: SizedBox()),

                    Stack(
                      children: [
                        Visibility(
                          visible: !isTermsArrowVisible,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: new GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   isContactVisible = !isContactVisible;
                                //   isArrowVisible = !isArrowVisible;
                                // });
                              },
                              child: Container(
                                // width: 100.0,
                                height: 45.0,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:20.0, right: 30.0),
                                    child: Icon(Icons.keyboard_arrow_up, size: 30.0,color: HexColor("#DEE1E7"),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Visibility(
                          visible: isTermsArrowVisible,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: new GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   isContactVisible = !isContactVisible;
                                //   isArrowVisible = !isArrowVisible;
                                // });
                              },
                              child: Container(
                                // width: 100.0,
                                height: 45.0,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:20.0, right: 30.0),
                                    child: Icon(Icons.keyboard_arrow_down, size: 30.0,color: HexColor("#DEE1E7"),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                child: Text("FAQs", style: TextStyle(color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.bold,)),
              ),

              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 10.0, right: 16.0, left: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(color: HexColor("#DEE1E7"), width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("Is Handiwork Worldwide?", style: TextStyle(color: HexColor("#212529"), fontSize: 12.0, fontWeight: FontWeight.normal,)),
                    ),

                    Expanded(child: SizedBox()),

                    Stack(
                      children: [
                        Visibility(
                          visible: !isGlobalArrowVisible,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: new GestureDetector(
                              onTap: () {
                                setState(() {
                                  isGlobal = !isGlobal;
                                  isGlobalArrowVisible = !isGlobalArrowVisible;
                                });
                              },
                              child: Container(
                                width: 100.0,
                                height: 45.0,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: Icon(Icons.keyboard_arrow_up, size: 30.0,color: HexColor("#DEE1E7"),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Visibility(
                          visible: isGlobalArrowVisible,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: new GestureDetector(
                              onTap: () {
                                setState(() {
                                  isGlobal = !isGlobal;
                                  isGlobalArrowVisible = !isGlobalArrowVisible;
                                });
                              },
                              child: Container(
                                width: 100.0,
                                height: 45.0,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: Icon(Icons.keyboard_arrow_down, size: 30.0,color: HexColor("#DEE1E7"),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

        Visibility(
          visible: !isGlobal,
          child: Container(
            width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 10.0, right: 16.0, left: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
          ),
          child:
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0, bottom: 25.0),
                child: Text("Not yet, we are working daily to expand our operations around the country. If your location is not active on the app, expect us to be there soon.", style: TextStyle(color: HexColor("#212529"), fontSize: 10.0, fontWeight: FontWeight.normal,)),
              ),
            ),
          ),

              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 15.0, right: 16.0, left: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(color: HexColor("#DEE1E7"), width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("Is it free?", style: TextStyle(color: HexColor("#212529"), fontSize: 12.0, fontWeight: FontWeight.normal,)),
                    ),

                    Expanded(child: SizedBox()),

                    Stack(
                      children: [
                        Visibility(
                          visible: !isFreeArrowVisible,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: new GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFreeVisible = !isFreeVisible;
                                  isFreeArrowVisible = !isFreeArrowVisible;
                                });
                              },
                              child: Container(
                                width: 100.0,
                                height: 45.0,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: Icon(Icons.keyboard_arrow_up, size: 30.0,color: HexColor("#DEE1E7"),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Visibility(
                          visible: isFreeArrowVisible,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: new GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFreeVisible = !isFreeVisible;
                                  isFreeArrowVisible = !isFreeArrowVisible;
                                });
                              },
                              child: Container(
                                width: 100.0,
                                height: 45.0,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: Icon(Icons.keyboard_arrow_down, size: 30.0,color: HexColor("#DEE1E7"),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Visibility(
                visible: !isFreeVisible,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 10.0, right: 16.0, left: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                  ),
                  child:
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0, bottom: 25.0),
                    child: Text("Yes it is absolutely free!", style: TextStyle(color: HexColor("#212529"), fontSize: 10.0, fontWeight: FontWeight.normal,)),
                  ),
                ),
              ),

              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 15.0, right: 16.0, left: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(color: HexColor("#DEE1E7"), width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("How soon can i get a jobs?", style: TextStyle(color: HexColor("#212529"), fontSize: 12.0, fontWeight: FontWeight.normal,)),
                    ),

                    Expanded(child: SizedBox()),

                    Stack(
                      children: [
                        Visibility(
                          visible: !isGetJobArrowVisible,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: new GestureDetector(
                              onTap: () {
                                setState(() {
                                  isGetJobVisible = !isGetJobVisible;
                                  isGetJobArrowVisible = !isGetJobArrowVisible;
                                });
                              },
                              child: Container(
                                width: 100.0,
                                height: 45.0,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: Icon(Icons.keyboard_arrow_up, size: 30.0,color: HexColor("#DEE1E7"),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Visibility(
                          visible: isGetJobArrowVisible,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: new GestureDetector(
                              onTap: () {
                                setState(() {
                                  isGetJobVisible = !isGetJobVisible;
                                  isGetJobArrowVisible = !isGetJobArrowVisible;
                                });
                              },
                              child: Container(
                                width: 100.0,
                                height: 45.0,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: Icon(Icons.keyboard_arrow_down, size: 30.0,color: HexColor("#DEE1E7"),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Visibility(
                visible: !isGetJobVisible,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 10.0, right: 16.0, left: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                  ),
                  child:
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0, bottom: 25.0),
                    child: Text("Getting a job depends on how well you’re able to showcase your portfolio and your frequent update on your profile.", style: TextStyle(color: HexColor("#212529"), fontSize: 10.0, fontWeight: FontWeight.normal,)),
                  ),
                ),
              ),


              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 15.0, right: 16.0, left: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  border: Border.all(color: HexColor("#DEE1E7"), width: 1.5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("How will clients find me?", style: TextStyle(color: HexColor("#212529"), fontSize: 12.0, fontWeight: FontWeight.normal,)),
                    ),

                    Expanded(child: SizedBox()),

                    Stack(
                      children: [
                        Visibility(
                          visible: !isFindMeArrowVisible,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: new GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFindMeVisible = !isFindMeVisible;
                                  isFindMeArrowVisible = !isFindMeArrowVisible;
                                });
                              },
                              child: Container(
                                width: 100.0,
                                height: 45.0,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: Icon(Icons.keyboard_arrow_up, size: 30.0,color: HexColor("#DEE1E7"),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        Visibility(
                          visible: isFindMeArrowVisible,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: new GestureDetector(
                              onTap: () {
                                setState(() {
                                  isFindMeVisible = !isFindMeVisible;
                                  isFindMeArrowVisible = !isFindMeArrowVisible;
                                });
                              },
                              child: Container(
                                width: 100.0,
                                height: 45.0,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 30.0),
                                    child: Icon(Icons.keyboard_arrow_down, size: 30.0,color: HexColor("#DEE1E7"),),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Visibility(
                visible: !isFindMeVisible,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(top: 10.0, right: 16.0, left: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0, bottom: 25.0),
                    child: Text("Our team works tirelessly to make you are visible through SEO and that clients get to engage with you.", style: TextStyle(color: HexColor("#212529"), fontSize: 10.0, fontWeight: FontWeight.normal,)),
                  ),
                ),
              ),

              SizedBox(
                height: 50.0,
              ),
            ],
        ),
      ),
    );
  }
}
