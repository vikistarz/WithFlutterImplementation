import 'dart:convert';

import 'package:cross_platform_application/screens/serviceProviderDashBoard/serviceProviderEditProfile/serviceProviderEditCityDialog.dart';
import 'package:cross_platform_application/screens/serviceProviderDashBoard/serviceProviderEditProfile/serviceProviderEditServiceTypeDialog.dart';
import 'package:cross_platform_application/screens/serviceProviderDashBoard/serviceProviderEditProfile/serviceProviderEditStateDialog.dart';
import 'package:cross_platform_application/screens/serviceProviderDashBoard/serviceProviderEditProfile/serviceProviderEditSubCategoryDialog.dart';
import 'package:cross_platform_application/screens/serviceProviderDashBoard/serviceProviderEditProfile/serviceProviderEmailAddressEdit.dart';
import 'package:cross_platform_application/screens/serviceProviderDashBoard/serviceProviderEditProfile/serviceProviderFirstNameEdit.dart';
import 'package:cross_platform_application/screens/serviceProviderDashBoard/serviceProviderEditProfile/serviceProviderLastNameEdit.dart';
import 'package:cross_platform_application/screens/serviceProviderDashBoard/serviceProviderEditProfile/serviceProviderOfficeAddressEdit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../../database/appPrefHelper.dart';
import '../../database/saveValues.dart';
import '../../dialogs/errorMessageDialog.dart';
import '../../webService/apiConstant.dart';
import '../support/support.dart';
class ServiceProviderProfilePage extends StatefulWidget {
  const ServiceProviderProfilePage({super.key});

  @override
  State<ServiceProviderProfilePage> createState() => _ServiceProviderProfilePageState();
}

class _ServiceProviderProfilePageState extends State<ServiceProviderProfilePage> {

  bool contactVisible = true;
  bool contactNotVisible = true;
  bool supportVisible = true;
  bool isLoadingVisible = true;
  bool isProfileVisible = true;

  int? serviceProviderId;
  String errorMessage = "";
  String firstName = "";
  String lastName = "";
  String emailAddress = "";
  String phoneNumber = "";
  String street = "";
  String stateOfResidence = "";
  String city = "";
  String serviceType = "";
  String subCategory = "";
  String about = "";
  String skill = "";
  String imagePath = "";
  String openingHour = "";

  @override
  void initState() {
    super.initState();
    getSavedValue();
  }

  getSavedValue() async  {
    SaveValues mySaveValues = SaveValues();
    serviceProviderId = await mySaveValues.getInt(AppPreferenceHelper.SERVICE_PROVIDER_ID);
    setState(() {
      fetchUserData(serviceProviderId!);
    });
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
        String last_name = data['skillProvider']['lastName'];
        String email_address = data['skillProvider']['email'];
        String phone_number = data['skillProvider']['phone'];
        String state_of_residence = data['skillProvider']['stateOfResidence'];
        String citi = data['skillProvider']["city"];
        String office_streets = data['skillProvider']['street'];
        String service_type = data['skillProvider']['serviceType'];
        String sub_category = data['skillProvider']['subCategory'];
        String opening_hour = data['skillProvider']['openingHour'];
        String abouts = data['skillProvider']['about'] ?? 'about';
        String skills = data['skillProvider']['skills']  ?? 'Skills';
        String image_path = data['skillProvider']['imagePath'];

        String save_image_path = "https://server.handiwork.com.ng/" + image_path;

        // Update the state with the extracted data
        setState(() {
          isProfileVisible = !isProfileVisible;

          firstName = first_name;
          lastName = last_name;
          emailAddress = email_address;
          phoneNumber = phone_number;
          stateOfResidence = state_of_residence;
          city = citi;
          street = office_streets;
          serviceType = service_type;
          subCategory = sub_category;
          openingHour = opening_hour;
          about = abouts;
          skill = skills;
          imagePath = save_image_path;

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
      print('Error: $error');
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
    await mySaveValues.saveString(AppPreferenceHelper.STATE, stateOfResidence);

    await mySaveValues.saveString(AppPreferenceHelper.CITY, city);
    await mySaveValues.saveString(AppPreferenceHelper.HOME_ADDRESS, street);
    await mySaveValues.saveString(AppPreferenceHelper.SERVICE_TYPE, serviceType);
    await mySaveValues.saveString(AppPreferenceHelper.SUB_CATEGORY, subCategory);
    await mySaveValues.saveString(AppPreferenceHelper.OPENING_HOUR, openingHour);

    await mySaveValues.saveString(AppPreferenceHelper.About_ME, about);
    await mySaveValues.saveString(AppPreferenceHelper.SKILLS, skill);
    await mySaveValues.saveString(AppPreferenceHelper.GET_PROFILE_PHOTO_PATH, imagePath);
    await mySaveValues.saveString(AppPreferenceHelper.SUB_CATEGORY, subCategory);
    await mySaveValues.saveString(AppPreferenceHelper.OPENING_HOUR, openingHour);
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
    final capitalisedState  = capitalize(stateOfResidence);
    final capitalisedCity  = capitalize(city);
    final capitalisedStreet  = capitalize(street);
    final capitalisedServiceType  = capitalize(serviceType);
    final capitalisedSubcategory  = capitalize(subCategory);
    final capitalisedOpeningHour  = capitalize(openingHour);
    final capitalisedAboutMe  = capitalize(about);
    final capitalisedSkills  = capitalize(skill);

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
              padding: const EdgeInsets.only(top: 100.0),
              child: Visibility(
                    visible: !isLoadingVisible,
                    child: SpinKitFadingCircle(
                      color: HexColor("#212529"),
                      size: 40.0,
                    ),
              ),
            ),

            Visibility(
              visible: !isProfileVisible,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top:10.0),
                    width: MediaQuery.of(context).size.width,
                    height: 170.0,
                    decoration: BoxDecoration(
                      color: HexColor("#F6F6F6"),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Column(
                      children: [
                        Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child:  SizedBox(),
                              ),

                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child:  CircleAvatar(
                                    backgroundColor: HexColor("#E4DFDF"),
                                    backgroundImage: NetworkImage(imagePath),
                                    radius: 58.0,
                                  ),
                                ),
                              ),

                              Expanded(
                                child:  SizedBox(),
                              ),

                              InkWell(
                                onTap: () {
                                  // showImageOptions(context);
                                },
                                child: Container(
                                    margin: EdgeInsets.only(right: 20.0, top: 10.0),
                                    height: 35.0,
                                    width: 35.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(17.0)),
                                      color: HexColor("#5E60CE"),
                                    ),
                                    child: Icon(Icons.camera_alt_sharp, size: 25.0, color: Colors.white,)
                                ),
                              ),

                            ]
                        ),

                        Padding(
                          padding: EdgeInsets.only(top:10.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text("Edit Profile", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: HexColor("#5E60CE"),),),
                          ),
                        ),

                      ],
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
                            child: Text(firstName == null ?"First Name" : "$capitalisedFirstName", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
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
                            child: Text(lastName == null ? "Last Name" : "$capitalisedLastName", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
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
                                child: Text(emailAddress == null ? "Email Address" : "$capitalisedEmail", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
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
                                child: Text(phoneNumber == null ? "Email Address" : "$capitalisedPhone", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
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

                  //   state of residence
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
                            child: Text(stateOfResidence == null ? "State of Residence" : "$capitalisedState", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 20.0, top: 1.0),
                          width:110.0,
                          height: 20.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text("State of Residence", style: TextStyle(
                                color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0, right: 13.0),
                            child: new GestureDetector(
                              onTap: (){

                                _stateOfResidenceEditDialog();
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


                  // City

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
                            child: Text(city == null ? "City" : "$capitalisedCity", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 20.0, top: 1.0),
                          width:30.0,
                          height: 20.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text("City", style: TextStyle(
                                color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0, right: 13.0),
                            child: new GestureDetector(
                              onTap: (){

                                _cityEditDialog();
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


                  // office street address

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
                            child: Text(street == null ? "Office Street Address" : "$capitalisedStreet", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 20.0, top: 1.0),
                          width:125.0,
                          height: 20.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text("Office Street Address", style: TextStyle(
                                color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0, right: 13.0),
                            child: new GestureDetector(
                              onTap: (){
                                _officeAddressEditDialog();

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


                  // service type

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
                            child: Text(serviceType == null ? "Service Type" : "$capitalisedServiceType", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 20.0, top: 1.0),
                          width:80.0,
                          height: 20.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text("Service Type", style: TextStyle(
                                color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0, right: 13.0),
                            child: new GestureDetector(
                              onTap: (){

                                _serviceTypeEditDialog();
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


                  // Sub Category

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
                            child: Text(subCategory == null ? "Sub Category" : "$capitalisedSubcategory", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 20.0, top: 1.0),
                          width:80.0,
                          height: 20.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text("Sub Category", style: TextStyle(
                                color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0, right: 13.0),
                            child: new GestureDetector(
                              onTap: (){

                                _subCategoryEditDialog();
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

                  // Opening Hour

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
                            child: Text(openingHour == null ? "Opening Hour" : "$capitalisedOpeningHour", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 20.0, top: 1.0),
                          width:85.0,
                          height: 20.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text("Opening Hour", style: TextStyle(
                                color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0, right: 13.0),
                            child: new GestureDetector(
                              onTap: (){

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

                  // About

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
                            padding: const EdgeInsets.only(top:15.0, left:25.0, right: 50.0, bottom: 15.0),
                            child: Text(about == null ? "About" : "$capitalisedAboutMe", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 20.0, top: 1.0),
                          width:40.0,
                          height: 20.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text("About", style: TextStyle(
                                color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0, right: 13.0),
                            child: new GestureDetector(
                              onTap: (){

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

                  // About

                  Container(
                    margin: EdgeInsets.only(top:20.0, left: 16.0, right: 16.0, bottom: 50.0),
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
                            padding: const EdgeInsets.only(top:15.0, left:25.0, right: 50.0, bottom: 15.0),
                            child: Text(skill == null ? "Skills" : "$capitalisedSkills", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(left: 20.0, top: 1.0),
                          width:40.0,
                          height: 20.0,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text("Skills", style: TextStyle(
                                color: Colors.grey, fontSize: 12.0, fontWeight: FontWeight.normal),),
                          ),
                        ),

                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0, right: 13.0, left: 20.0),
                            child: new GestureDetector(
                              onTap: (){

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
        return ServiceProviderFirstNameEditDialog();
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
        return ServiceProviderLastNameEditDialog();
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
        return ServiceProviderEmailAddressEditDialog();
      },
    );

    // Handle the result from the bottom sheet
    if (result != null) {
      setState(() {
        emailAddress = result;
      });
    }
  }

  // open edit stateOfResidence dialog

  Future<void> _stateOfResidenceEditDialog() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand fully
      builder: (BuildContext context) {
        return ServiceProviderEditStateDialog();
      },
    );

    // Handle the result from the bottom sheet
    if (result != null) {
      setState(() {
        stateOfResidence = result;
      });
    }
  }

  // open edit city dialog

  Future<void> _cityEditDialog() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand fully
      builder: (BuildContext context) {
        return ServiceProviderEditCityDialog();
      },
    );

    // Handle the result from the bottom sheet
    if (result != null) {
      setState(() {
        city = result;
      });
    }
  }


  // open edit officeAddress dialog

  Future<void> _officeAddressEditDialog() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand fully
      builder: (BuildContext context) {
        return ServiceProviderOfficeAddressEditDialog();
      },
    );

    // Handle the result from the bottom sheet
    if (result != null) {
      setState(() {
        street = result;
      });
    }
  }

  // open edit serviceType dialog

  Future<void> _serviceTypeEditDialog() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand fully
      builder: (BuildContext context) {
        return ServiceProviderEditServiceTypeDialog();
      },
    );

    // Handle the result from the bottom sheet
    if (result != null) {
      setState(() {
        serviceType = result;
      });
    }
  }

  // open edit subCategory dialog

  Future<void> _subCategoryEditDialog() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand fully
      builder: (BuildContext context) {
        return ServiceProviderEditSubCategoryDialog();
      },
    );

    // Handle the result from the bottom sheet
    if (result != null) {
      setState(() {
        subCategory = result;
      });
    }
  }


}



