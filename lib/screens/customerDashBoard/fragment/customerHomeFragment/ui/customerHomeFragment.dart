import 'dart:convert';

import 'package:cross_platform_application/screens/serviceProviderSignUp/dialogs/stateOfResidenceDialog.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../../database/appPrefHelper.dart';
import '../../../../../database/saveValues.dart';
import '../../../../../dialogs/errorMessageDialog.dart';
import '../../../../../webService/apiConstant.dart';
import '../../../../serviceProviderDetails/ui/details.dart';
import '../../../../serviceSubCategories/serviceSubCategories.dart';
import '../dialog/searchServiceProviderDialog.dart';
import 'package:http/http.dart' as http;

class CustomerHomeFragment extends StatefulWidget {
  const CustomerHomeFragment({super.key});

  @override
  State<CustomerHomeFragment> createState() => _CustomerHomeFragmentState();
}

class _CustomerHomeFragmentState extends State<CustomerHomeFragment> {
  int? customerId;
  String errorMessage = "";
  String firstName = "";
  bool isLoadingVisible = true;


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
      fetchUserData(customerId!);
      // items.add("Item ${items.length + 1}");
    });
  }

  getSavedValue() async  {
    SaveValues mySaveValues = SaveValues();
    customerId = await mySaveValues.getInt(AppPreferenceHelper.CUSTOMER_ID);
    setState(() {
      fetchUserData(customerId!);
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
    final String apiUrl = ApiConstant.baseUri + 'customers/view/$id';

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
        String first_name = data['customer']["firstName"];

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
      body: RefreshIndicator(
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

              // "How can we be of help today?"

              new GestureDetector(
                onTap: (){
                  _openSearchServiceTypeDialog();
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
                 child: Text("Browse by Category",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.bold, fontSize:11.0,),),
               ),

              // first box
              Row(
                children: [
                  Expanded(
                    child:new GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ServicesSubCategories(serviceType: "Fashion Services");
                        }));
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
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ServicesSubCategories(serviceType: "AUTO-Mechanic/A.C/Rewire/Pane");
                        }));
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
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ServicesSubCategories(serviceType: "Beautician");
                        }));
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
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ServicesSubCategories(serviceType: "Catering Services");
                        }));
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
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ServicesSubCategories(serviceType: "Plumbing Service");
                        }));
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
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return ServicesSubCategories(serviceType: "cleaning/laundry/fumigation");
                        }));
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
                padding: const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 100.0),
                  child: ElevatedButton(onPressed: () {
                    _openSearchServiceTypeDialog();
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
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _openSearchServiceTypeDialog() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand fully
      builder: (BuildContext context) {
        return SearchServiceProviderDialog();
      },
    );
  }

}


