import 'package:cross_platform_application/screens/support/support.dart';
import'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'customerEditProfile/customerEmailAddressEdit.dart';
import 'customerEditProfile/customerFirstNameEdit.dart';
import 'customerEditProfile/customerHomeAddressEdit.dart';
import 'customerEditProfile/customerLastNameEdit.dart';

class CustomerProfilePage extends StatefulWidget {
  CustomerProfilePage({super.key});

  @override
  State<CustomerProfilePage> createState() => _CustomerProfilePageState();
}

class _CustomerProfilePageState extends State<CustomerProfilePage> {

  bool contactVisible = true;
  bool contactNotVisible = true;
  bool supportVisible = true;

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
            width: 50.0,
            height: 40.0,
            child: Image(image: AssetImage("images/arrow_back.png"),),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                  child: Text(firstName == null ? "First Name" : "$firstName", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                ),
              ),

          Container(
          margin: EdgeInsets.only(left: 20.0, top: 1.0),
          width:70.0,
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
                      child: Text(lastName == null ? "Last Name" : "$lastName", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 1.0),
                    width:70.0,
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
                          child: Text(emailAddress == null ?"Email Address" : "$emailAddress", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20.0, top: 1.0),
                        width:90.0,
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
                          child: Text("Phone Number", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(left: 20.0, top: 1.0),
                        width:90.0,
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
                      child: Text(homeAddress == null ?"Home Address" : "$homeAddress", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(left: 20.0, top: 1.0),
                    width:90.0,
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


          ],
        ),
      ),
    );
  }

  // open edit firstName dialog
  String? firstName;

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
  String? lastName;

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
  String? emailAddress;

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
  String? homeAddress;

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
