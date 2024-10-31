import 'dart:convert';

import'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../database/appPrefHelper.dart';
import '../../../database/saveValues.dart';
import '../../../dialogs/errorMessageDialog.dart';
import '../../../dialogs/logOutDialog.dart';
import '../../../webService/apiConstant.dart';
import '../customerProfile.dart';
import 'package:http/http.dart' as http;


class CustomerAccountFragment extends StatefulWidget {
  const CustomerAccountFragment({super.key});

  @override
  State<CustomerAccountFragment> createState() => _CustomerAccountFragmentState();
}

class _CustomerAccountFragmentState extends State<CustomerAccountFragment> {

  bool isLoadingVisible = true;

  int? customerId ;
  String errorMessage = "";
  String firstName = "";
  String lastName = "";
  String homeAddress = "";

  @override
  void initState() {
    super.initState();
    getSavedValue();
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
        String last_name = data['customer']['lastName'];
        String home_address = data['customer']['address'];

        // Update the state with the extracted data
        setState(() {
          firstName = first_name;
          lastName = last_name;
          homeAddress = home_address;
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

  void _openLogOutDialog(){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context, builder: (ctx) => LogOutDialog());
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
    final capitalisedLastName  = capitalize(lastName);
    final capitalisedAddress  = capitalize(homeAddress);
    return Scaffold(
      backgroundColor: HexColor("#f4f4f4"),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:15.0, left: 20.0),
              child: Text("Profile",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.bold, fontSize:16.0,),),
            ),

            Container(
              height: 200.0,
              margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: HexColor("#212529"), width: 1.0),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 55.0,
                      margin: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
                      decoration: BoxDecoration(
                       color: HexColor("#5E60CE"),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              color: HexColor("#C3BDBD"),
                              blurRadius: 3.0,
                              spreadRadius: 2,
                              offset: Offset(1,1),
                            )
                          ]
                      ),
                      child:  Center(
                        child: Text(firstName + "" + lastName == null ? "" : "${capitalisedFirstName+ " " + capitalisedLastName}",style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize:15.0,),),
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context){
                         return CustomerProfilePage();
                       }));
                    },
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: 40.0,
                        width: 150.0,
                        margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                        ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                  child:SizedBox(

                                  )
                              ),
                              Text("View Profile",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                              Container(
                                  width: 25.0,
                                  height: 25.0,
                                  margin: EdgeInsets.only(left: 5.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(13.0),),
                                    border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                                  ),
                                  child:    Icon(Icons.person_outline,color: HexColor("#5E60CE"),size: 20.0,)
                              ),
                              Expanded(
                                  child:SizedBox(

                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                  ),

                Row(
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20.0),
                    child: Image(image: AssetImage("images/location_image.png"), width: 15.0, height: 15.0,),
                  ),

                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 5.0, right: 20.0),
                      child:Text(homeAddress == null ? "" : "$capitalisedAddress",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.bold, fontSize:11.0,),),
                    ),
                  ],
                ),
             ],
        ),
      ),

            InkWell(
              onTap: (){

              },
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: 55.0,
                  margin: EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor("#C3BDBD"),
                          blurRadius: 1.0,
                          spreadRadius: 1,
                          offset: Offset(1,1),
                        )
                      ]
                  ),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20.0),
                          child: Image(image: AssetImage("images/wallet.png"), width: 20.0, height: 20.0,),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 10.0, right: 20.0),
                          child:Text("Wallet",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                        ),
                      ],
                    ),
                  )
                ),
              ),
            ),

            InkWell(
              onTap: (){

              },
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    height: 55.0,
                    margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        boxShadow: [
                          BoxShadow(
                            color: HexColor("#C3BDBD"),
                            blurRadius: 1.0,
                            spreadRadius: 1,
                            offset: Offset(1,1),
                          )
                        ]
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20.0),
                            child: Image(image: AssetImage("images/add_bank_account.png"), width: 20.0, height: 20.0,),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 10.0, right: 20.0),
                            child:Text("Add Bank Account",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                          ),

                        ],
                      ),
                    )
                ),
              ),
            ),



            new GestureDetector(
              onTap: (){
                _openLogOutDialog();
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    height: 55.0,
                    margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0, bottom: 50.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        boxShadow: [
                          BoxShadow(
                            color: HexColor("#C3BDBD"),
                            blurRadius: 1.0,
                            spreadRadius: 1,
                            offset: Offset(1,1),
                          )
                        ]
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20.0),
                            child: Image(image: AssetImage("images/logout_square.png"), width: 20.0, height: 20.0,),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 10.0, right: 20.0),
                            child:Text("Log Out",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                          ),

                        ],
                      ),
                    )
                ),
              ),
            ),

          ]
     ),
    ),
    );
  }

}
