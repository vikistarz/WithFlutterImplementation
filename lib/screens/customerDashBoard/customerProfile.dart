import 'dart:convert';

import 'package:cross_platform_application/screens/support/support.dart';
import'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../database/appPrefHelper.dart';
import '../../database/saveValues.dart';
import '../../dialogs/errorMessageDialog.dart';
import '../../webService/apiConstant.dart';
import 'customerEditProfile/customerEmailAddressEdit.dart';
import 'customerEditProfile/customerFirstNameEdit.dart';
import 'customerEditProfile/customerHomeAddressEdit.dart';
import 'customerEditProfile/customerLastNameEdit.dart';
import 'package:http/http.dart' as http;

class CustomerProfilePage extends StatefulWidget {
  CustomerProfilePage({super.key});

  @override
  State<CustomerProfilePage> createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {

  bool contactVisible = true;
  bool contactNotVisible = true;
  bool supportVisible = true;
  bool isLoadingVisible = true;
  bool isProfileVisible = true;

  int? customerId;
  String errorMessage = "";
  String firstName = "";
  String lastName = "";
  String emailAddress = "";
  String phoneNumber = "";
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

  Future<void> _refresh() async {
    // Simulate a network request or any async task
    await Future.delayed(Duration(seconds: 2));

    // Add a new item to the list after refreshing
    setState(() {
      fetchUserData(customerId!);
      // items.add("Item ${items.length + 1}");
    });
  }

  void contactOne(){
    supportVisible = false;
    contactVisible = false;
    contactNotVisible = false;
  }

  void contactTwo(){
    contactNotVisible = true;
    supportVisible = true;
    contactVisible = true;
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
        String email_address = data['customer']['email'];
        String phone_number = data['customer']['phone'];
        String home_address = data['customer']['address'];

        // Update the state with the extracted data
        setState(() {
          isProfileVisible = !isProfileVisible;

          firstName = first_name;
          lastName = last_name;
          emailAddress = email_address;
          phoneNumber = phone_number;
          homeAddress = home_address;

          saveProfile();
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

    void saveProfile() async {
    SaveValues mySaveValues = SaveValues();
    await mySaveValues.saveString(AppPreferenceHelper.FIRST_NAME, firstName);
    await mySaveValues.saveString(AppPreferenceHelper.LAST_NAME, lastName);
    await mySaveValues.saveString(AppPreferenceHelper.EMAIL_ADDRESS, emailAddress);
    await mySaveValues.saveString(AppPreferenceHelper.PHONE_NUMBER, phoneNumber);
    await mySaveValues.saveString(AppPreferenceHelper.HOME_ADDRESS, homeAddress);
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
    final capitalisedEmail  = capitalize(emailAddress);
    final capitalisedPhone  = capitalize(phoneNumber);
    final capitalisedAddress  = capitalize(homeAddress);
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
            width: 50.0,
            height: 40.0,
            child: Image(image: AssetImage("images/arrow_back.png"),),
          ),
        ),
      ),
      body:RefreshIndicator(
    onRefresh: _refresh,
    color: Colors.white,
    backgroundColor: Colors.grey,
    displacement: 40.0,
    strokeWidth: 3.0,
    child:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: [

           Padding(
             padding: const EdgeInsets.only(top: 150.0),
             child: Visibility(
                    visible: !isLoadingVisible,
                    child: SpinKitFadingCircle(
                      color: HexColor("#212529"),
                      size: 40.0,
                    )
                ),
           ),


            Visibility(
              visible: !isProfileVisible,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:30.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text("Edit Profile", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: HexColor("#5E60CE"),),),
                    ),
                  ),

                  // first name
                  Container(
                    margin: EdgeInsets.only(top:30.0, left: 16.0, right: 16.0),
                    width: MediaQuery.of(context).size.width,
                    height: 60.0,
                    child: Stack(
                      children: [

                        Container(
                          margin: EdgeInsets.only(top:10.0),
                          width: MediaQuery.of(context).size.width,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: HexColor("#212529"), width: 1.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top:15.0, left:25.0, right: 25.0),
                            child: Text(firstName == null ? "First Name" : "$capitalisedFirstName", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 20.0, top: 1.0),
                          width:80.0,
                          height: 20.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text("First Name", style: TextStyle(
                                color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0, right: 13.0),
                            child: new GestureDetector(
                              onTap: (){
                                _firstNameEditDialog();
                              },
                              child: Container(
                                  width: 30.0,
                                  height: 30.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image(image: AssetImage("images/edit_pen.png"), width: 20.0, height: 20.0,),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //   last name

                  Container(
                    margin: EdgeInsets.only(top:20.0, left: 16.0, right: 16.0),
                    width: MediaQuery.of(context).size.width,
                    height: 60.0,
                    child: Stack(
                      children: [

                        Container(
                          margin: EdgeInsets.only(top:10.0),
                          width: MediaQuery.of(context).size.width,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: HexColor("#212529"), width: 1.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top:15.0, left:25.0, right: 25.0),
                            child: Text(lastName == null ? "Last Name" : "$capitalisedLastName", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 20.0, top: 1.0),
                          width:80.0,
                          height: 20.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text("Last Name", style: TextStyle(
                                color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0, right: 13.0),
                            child: new GestureDetector(
                              onTap: (){
                                _lastNameEditDialog();
                              },
                              child: Container(
                                  width: 30.0,
                                  height: 30.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image(image: AssetImage("images/edit_pen.png"), width: 20.0, height: 20.0,),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //   email address and phone number

                  Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top:20.0, left: 16.0, right: 16.0),
                        width: MediaQuery.of(context).size.width,
                        height: 60.0,
                        child: Stack(
                          children: [

                            Container(
                              margin: EdgeInsets.only(top:10.0),
                              width: MediaQuery.of(context).size.width,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(color: HexColor("#212529"), width: 1.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top:15.0, left:25.0, right: 25.0),
                                child: Text(emailAddress == null ?"Email Address" : "$capitalisedEmail", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 20.0, top: 1.0),
                              width:100.0,
                              height: 20.0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text("Email Address", style: TextStyle(
                                    color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.normal),),
                              ),
                            ),

                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20.0, right: 13.0),
                                child: new GestureDetector(
                                  onTap: (){
                                    _emailAddressEditDialog();
                                  },
                                  child: Container(
                                      width: 30.0,
                                      height: 30.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Image(image: AssetImage("images/edit_pen.png"), width: 20.0, height: 20.0,),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // only phone number

                      Container(
                        margin: EdgeInsets.only(top:100.0, left: 16.0, right: 16.0),
                        width: MediaQuery.of(context).size.width,
                        height: 60.0,
                        child: Stack(
                          children: [

                            Container(
                              margin: EdgeInsets.only(top:10.0),
                              width: MediaQuery.of(context).size.width,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                border: Border.all(color: HexColor("#212529"), width: 1.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top:15.0, left:25.0, right: 25.0),
                                child: Text(phoneNumber == null ?"Phone Number" : "$capitalisedPhone", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(left: 20.0, top: 1.0),
                              width:100.0,
                              height: 20.0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text("Phone Number", style: TextStyle(
                                    color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.normal),),
                              ),
                            ),

                            Stack(
                              children: [
                                Visibility(
                                  visible: contactVisible,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0, right: 13.0),
                                      child: new GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            contactOne();
                                          });
                                        },
                                        child: Container(
                                            width: 30.0,
                                            height: 30.0,
                                            child: Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Image(image: AssetImage("images/information_square.png"), width: 20.0, height: 20.0,),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),

                                Visibility(
                                  visible: !contactNotVisible,
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20.0, right: 13.0),
                                      child: new GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            contactTwo();
                                          });
                                        },
                                        child: Container(
                                            width: 30.0,
                                            height: 30.0,
                                            child: Padding(
                                              padding: const EdgeInsets.all(2.0),
                                              child: Image(image: AssetImage("images/information_square.png"), width: 20.0, height: 20.0,),
                                            )),
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
                        visible: !supportVisible,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.only(top:60.0, right: 30.0),
                            width: 220.0,
                            height: 70.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(image: AssetImage("images/number_info.png",),),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 12.0),
                                  child: Text("Kindly contact Handiwork if you require", style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.normal, color: HexColor("#212529"),),),
                                ),
                                Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0, right: 5.0),
                                        child: Text("a change of number.", style: TextStyle(fontSize: 11.0, fontWeight: FontWeight.normal, color: HexColor("#212529"),),),
                                      ),
                                      new GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context){
                                              return SupportPage();
                                            }));
                                          },
                                          child: Text("Contact Now", style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: HexColor("#5E60CE"),),)),
                                    ]
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // home address

                  Container(
                    margin: EdgeInsets.only(top:20.0, left: 16.0, right: 16.0),
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [

                        Container(
                          margin: EdgeInsets.only(top:10.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5.0)),
                            border: Border.all(color: HexColor("#212529"), width: 1.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top:15.0, left:25.0, right: 45.0, bottom: 15.0),
                            child: Text(homeAddress == null ?"Home Address" : "$capitalisedAddress", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 20.0, top: 1.0),
                          width:100.0,
                          height: 20.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text("Home Address", style: TextStyle(
                                color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0, right: 13.0),
                            child: new GestureDetector(
                              onTap: (){
                                _homeAddressEditDialog();
                              },
                              child: Container(
                                  width: 30.0,
                                  height: 30.0,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image(image: AssetImage("images/edit_pen.png"), width: 20.0, height: 20.0,),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 400.0,
                  )


                ],
              ),
            ),

          ],

        ),
      ),
      ),
    );
  }

  // open edit firstName dialog


  Future<void> _firstNameEditDialog() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand fully
      builder: (BuildContext context) {
        return CustomerFirstNameEditDialog();
      },
    );

    // Handle the result from the bottom sheet
    if (result != null) {
      setState(() {
        firstName = result;
      });
    }
  }

  // open edit lastName dialog

  Future<void> _lastNameEditDialog() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand fully
      builder: (BuildContext context) {
        return CustomerLastNameEditDialog();
      },
    );

    // Handle the result from the bottom sheet
    if (result != null) {
      setState(() {
        lastName = result;
      });
    }
  }


  // open edit emailAddress dialog

  Future<void> _emailAddressEditDialog() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand fully
      builder: (BuildContext context) {
        return CustomerEmailAddressEditDialog();
      },
    );

    // Handle the result from the bottom sheet
    if (result != null) {
      setState(() {
        emailAddress = result;
      });
    }
  }

  // open edit homeAddress dialog

  Future<void> _homeAddressEditDialog() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand fully
      builder: (BuildContext context) {
        return CustomerHomeAddressEditDialog();
      },
    );

    // Handle the result from the bottom sheet
    if (result != null) {
      setState(() {
        homeAddress = result;
      });
    }
  }
}
