import 'dart:convert';

import 'package:cross_platform_application/database/appPrefHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../database/saveValues.dart';
import '../../../dialogs/errorMessageDialog.dart';
import '../../../webService/apiConstant.dart';
import '../../verifyAccount/verifyAccount.dart';
import 'package:http/http.dart' as http;

class ServiceProviderHomeFragment extends StatefulWidget {
  const ServiceProviderHomeFragment({super.key});

  @override
  State<ServiceProviderHomeFragment> createState() => _ServiceProviderHomeFragmentState();
}

class _ServiceProviderHomeFragmentState extends State<ServiceProviderHomeFragment> {

  int? serviceProviderId;
  String errorMessage = "";
  String firstName = "";
  bool isLoadingVisible = true;
  bool isVerifiedVisible =  true;
  bool isUnverifiedVisible = true;
  bool isRejectedVisible = true;

  @override
  void initState() {
    super.initState();
    getSavedValue();
  }

  Future<void> _refresh() async {
    // Simulate a network request or any async task
    await Future.delayed(Duration(seconds: 2));

    // Add a new item to the list after refreshing
    setState(() {
      fetchUserData(serviceProviderId!);
      // items.add("Item ${items.length + 1}");
    });
  }

  getSavedValue() async  {
    SaveValues mySaveValues = SaveValues();
   int? id = await mySaveValues.getInt(AppPreferenceHelper.SERVICE_PROVIDER_ID);
    setState(() {
      serviceProviderId = id;
    });
  }

  void loading(){
    setState(() {
      isLoadingVisible = false;
    });
  }

  void isNotLoading(){
    setState(() {
      isLoadingVisible = true;
    });
  }

  Future<void> fetchUserData(int id) async {
    loading();
    final String apiUrl = ApiConstant.baseUri + 'skill-providers/view/$id';

    try {
      final response = await http.get(
          Uri.parse(apiUrl));

      print("request: " + response.toString());
      print(response.statusCode);


      if (response.statusCode == 200) {
        isNotLoading();
        // Parse the JSON response
        final data = json.decode(response.body);
        print('Response Body: ${response.body}');

        // Extract specific fields from the JSON
        String first_name = data['skillProvider']["firstName"];

        // Update the state with the extracted data
        setState(() {
          firstName = first_name;
        });

      } else {
        isNotLoading();
        print('Response Body: ${response.body}');
        // If the response code is not 200, show error
        final data = json.decode(response.body);

        // Extract specific fields from the JSON
        errorMessage = data['error'];
        setState(() {
          setState(() {
            showModalBottomSheet(
                isDismissible: false,
                enableDrag: false,
                context: context,
                builder: (BuildContext context) {
                  return ErrorMessageDialog(
                    content: errorMessage,
                    onButtonPressed: () {
                      Navigator.of(context).pop();
                      // Add any additional action here
                      isNotLoading();
                    },
                  );
                });
          });
        });
      }
    } catch (error) {
      // Handle any exceptions during the HTTP request
      isNotLoading();
      setState(() {
        showModalBottomSheet(
            isDismissible: false,
            enableDrag: false,
            context: context,
            builder: (BuildContext context) {
              return ErrorMessageDialog(
                content: "Sorry no internet Connection",
                onButtonPressed: () {
                  Navigator.of(context).pop();
                  // Add any additional action here
                  isNotLoading();
                },
              );
            });
      });
    }
  }

  String capitalize(String text) {
    if (text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }


  @override
  Widget build(BuildContext context) {
    final capitalisedFirstName  = capitalize(firstName);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _refresh,
            color: Colors.white,
            backgroundColor: Colors.grey,
            displacement: 40.0,
            strokeWidth: 3.0,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, left: 20.0),
                            child: Text(firstName == null ? "First Name" : "$capitalisedFirstName",style: TextStyle(color: HexColor("#5E60CE"), fontStyle: FontStyle.italic, fontSize:16.0,),),
                          ),

                          Visibility(
                            visible: !isLoadingVisible,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5, left: 30.0),
                              child: SpinKitFadingCircle(
                                color: HexColor("#212529"),
                                size: 20.0,
                              ),
                            ),
                          )
                        ],
                      ),

                    ],
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text("How can we be of help today?",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.bold, fontSize:20.0,),),
                    ),
                  ),
            
                  new GestureDetector(
                    onTap: (){
            
                    },
                    child: Container(
                      height: 40.0,
                      margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: HexColor("#212529"), width: 1.0),
                      ),
                      child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Icon(Icons.search, color: HexColor("#212529"), size: 20.0,),
                            ),
            
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text("Search Category",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:11.0,),),
                            ),
            
                            Expanded(
                              child:SizedBox(
            
                              ),
                            ),
            
                            Container(
                              height: 27.0,
                              width: 27.0,
                              margin: EdgeInsets.only(right: 20.0),
                              decoration: BoxDecoration(
                                color: HexColor("#5E60CE"),
                                borderRadius: BorderRadius.all(Radius.circular(14.0)),
                              ),
                              child: Icon(Icons.search, color: Colors.white, size: 13.0,),
                            ),
                          ]
                      ),
                    ),
                  ),
            
                  Padding(
                    padding: const EdgeInsets.only(top:25, left: 20.0),
                    child: Text("Let people know what you do",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                  ),
            
                  new GestureDetector(
                    onTap: (){
            
                    },
                    child: Container(
                      height: 55.0,
                      margin: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                      decoration: BoxDecoration(
                        color: HexColor("#F9F9F9"),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20.0),
                              height: 30.0,
                              width: 30.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage("images/about_me_icon.png",),),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top:12.0, left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Edit About me",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.bold, fontSize:12.0,),),
                                  Text("Stand a better chance of being hired!",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:9.0,),),
                                ],
                              ),
                            ),
            
                            Expanded(
                              child: SizedBox(
            
                              ),
                            ),
            
                            Padding(
                              padding: const EdgeInsets.only(top: 0.0, right: 20.0),
                              child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.black, size: 20.0,),
                            ),
            
                          ]
                      ),
                    ),
                  ),
            
            
                  Padding(
                    padding: const EdgeInsets.only(top:25, left: 20.0),
                    child: Text("Browse by Category",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.bold, fontSize:11.0,),),
                  ),
            
                  // first box
                  Row(
                    children: [
                      Expanded(
                        child:new GestureDetector(
                          onTap: (){
            
                          },
                          child: Container(
                            height: 105.0,
                            margin: EdgeInsets.only(top: 10.0, left: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    height: 60.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage("images/fashion.png",),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:0.0),
                                    child: Text("Fashion",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
            
                      Expanded(
                        child:new GestureDetector(
                          onTap: (){
            
                          },
                          child: Container(
                            height: 105.0,
                            margin: EdgeInsets.only(top: 10.0, right: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    height: 60.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage("images/automobile.png",),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:0.0),
                                    child: Text("Automobile",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            
                  SizedBox(
                    height: 15.0,
                  ),
            
                  //   second box
                  Row(
                    children: [
                      Expanded(
                        child:new GestureDetector(
                          onTap: (){
            
                          },
                          child: Container(
                            height: 105.0,
                            margin: EdgeInsets.only(top: 10.0, left: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    height: 60.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage("images/beautician.png",),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:0.0),
                                    child: Text("Beautician",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
            
                      SizedBox(
                        width: 15.0,
                      ),
            
                      Expanded(
                        child:new GestureDetector(
                          onTap: (){
            
                          },
                          child: Container(
                            height: 105.0,
                            margin: EdgeInsets.only(top: 10.0, right: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    height: 60.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage("images/catering.png",),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:0.0),
                                    child: Text("Catering",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            
                  SizedBox(
                    height: 15.0,
                  ),
            
                  //   third box
            
                  Row(
                    children: [
                      Expanded(
                        child:new GestureDetector(
                          onTap: (){
            
                          },
                          child: Container(
                            height: 105.0,
                            margin: EdgeInsets.only(top: 10.0, left: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    height: 60.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage("images/plumbing.png",),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:0.0),
                                    child: Text("Plumbing",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
            
                      SizedBox(
                        width: 15.0,
                      ),
            
                      Expanded(
                        child:new GestureDetector(
                          onTap: (){
            
                          },
                          child: Container(
                            height: 105.0,
                            margin: EdgeInsets.only(top: 10.0, right: 20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0),
                                    height: 60.0,
                                    width: 60.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage("images/cleaning.png",),),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top:0.0),
                                    child: Text("Cleaning/Laundry",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
            
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 10.0),
                    child: ElevatedButton(onPressed: () {
            
                    },
                      child: Text("View All", style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: HexColor("#212529"), padding: EdgeInsets.all(10.0),
                        minimumSize: Size(80.0, 40.0),
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
            
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 105.0,
                          margin: EdgeInsets.only(top: 20.0, left: 20.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("images/profile_view_background.png",),fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child:  Padding(
                                    padding: const EdgeInsets.only(top:10.0, right: 16),
                                    child: Text("Last 30d",style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize:6.0,),),
                                  ),
                                ),
            
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:10.0, left: 16),
                                    child: Text("Profile Visits",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:8.0,),),
                                  ),
                                ),
            
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top:0.0, left: 0.0),
                                      child: Text("324",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:24.0,),),
                                    ),
            
                                    Container(
                                      height: 25.0,
                                      width: 35.0,
                                      margin: EdgeInsets.only(top: 0.0, left: 0.0),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage("images/profile_view_chart.png",),fit: BoxFit.cover),
                                      ),
                                    ),
                                  ],
                                )
            
                                // Align(
                                //   alignment: Alignment.topLeft,
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(top:0.0, left: 12),
                                //     child: Text("324",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:24.0,),),
                                //   ),
                                // ),
            
                              ],
                            ),
                          ),
                        ),
                      ),
            
                      SizedBox(
                        width: 15.0,
                      ),
            
                      Expanded(
                        child: Container(
                          height: 105.0,
                          margin: EdgeInsets.only(top: 20.0, right: 20.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(image: AssetImage("images/view_portfolio_background.png",),fit: BoxFit.cover),
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          ),
                          child: Center(
                            child: ElevatedButton(onPressed: () {
            
                            },
                              child: Text("View Portfolio", style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.normal),),
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white, backgroundColor: HexColor("#212529"), padding: EdgeInsets.all(10.0),
                                minimumSize: Size(80.0, 30.0),
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
                      ),
                    ],
                  ),
            
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                    child: Container(
                      height: 65.0,
            
                      decoration: BoxDecoration(
                        // color: Colors.black,
                        image: DecorationImage(image: AssetImage("images/booking_view.png",), fit: BoxFit.fitWidth,),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      child: InkWell(
                        onTap: (){},
                        child: Center(
                            child: Image(image: AssetImage("images/booking_icon.png"), width: 80.0, height: 25.0,)),
                      ),
                    ),
                  ),
            
                  SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
          ),

          // rejected
          Visibility(
            visible: !isRejectedVisible,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor("#E66969").withOpacity(0.78),
                        blurRadius: 0.0,
                        spreadRadius: 0,
                        offset: Offset(0,0),
                      )
                    ]
                ),
                child: Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.info_outline, color: Colors.white, size: 20.0,),
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, top: 14.0),
                          child: Text("Sorry, your file did not meet our verification criteria", style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: Colors.white),),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text("Upload a valid image or PDF file.", style: TextStyle(fontSize: 8.0, fontWeight: FontWeight.bold, color: Colors.white),),
                        ),
                      ],
                    ),

                    Expanded(child: SizedBox()),

                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Center(
                        child: ElevatedButton(onPressed: () {

                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return VerifyAccountPage();
                          }));

                        },
                          child: Text("Re-verify", style: TextStyle(fontSize: 7.0),),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.transparent, padding: EdgeInsets.all(10.0),
                            minimumSize: Size(55.0, 20.0),
                            textStyle: TextStyle(fontSize: 7.0, fontWeight: FontWeight.normal),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5.0),
                                  bottomLeft: Radius.circular(5.0)),
                            ),
                            side: BorderSide(color: Colors.white, width: 0.5),
                            // alignment: Alignment.topCenter
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),

          // unverified
          Visibility(
            visible: isUnverifiedVisible,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor("#212529").withOpacity(0.78),
                        blurRadius: 0.0,
                        spreadRadius: 0,
                        offset: Offset(0,0),
                      )
                     ]
                ),
                child: Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.info_outline, color: Colors.white, size: 20.0,),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, top: 3.0),
                      child: Text("To become a verified Service Provider kindly verify account.", style: TextStyle(fontSize: 7.0, fontWeight: FontWeight.bold, color: Colors.white),),
                    ),

                    Expanded(child: SizedBox()),

                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Center(
                        child: ElevatedButton(onPressed: () {

                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return VerifyAccountPage();
                          }));

                        },
                          child: Text("Verify", style: TextStyle(fontSize: 7.0),),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: Colors.transparent, padding: EdgeInsets.all(10.0),
                            minimumSize: Size(55.0, 20.0),
                            textStyle: TextStyle(fontSize: 7.0, fontWeight: FontWeight.normal),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5.0),
                                  bottomLeft: Radius.circular(5.0)),
                            ),
                            side: BorderSide(color: Colors.white, width: 0.5),
                            // alignment: Alignment.topCenter
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),

          // verified
          Visibility(
            visible: !isVerifiedVisible,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor("#6590ff").withOpacity(0.78),
                        blurRadius: 0.0,
                        spreadRadius: 0,
                        offset: Offset(0,0),
                      )
                    ]
                ),
                child: Row(
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.info_outline, color: Colors.white, size: 20.0,),
                    ),

                    Expanded(child: SizedBox()),

                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text("Verification Pending", style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.white),),
                    ),

                    Expanded(child: SizedBox()),


                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

