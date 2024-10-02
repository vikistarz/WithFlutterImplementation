import 'package:cross_platform_application/screens/serviceProviderDetails/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../dialogs/errorMessageDialog.dart';
import '../../webService/apiConstant.dart';
import 'model/filterServicesResponseModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ServicesSubCategories extends StatefulWidget {
   ServicesSubCategories({Key? key, required this.serviceType}) : super(key: key);

  String serviceType;


  @override
  State<ServicesSubCategories> createState() => _ServicesSubCategoriesState();
}

class _ServicesSubCategoriesState extends State<ServicesSubCategories> {
   String errorMessage = "";

   bool isLoadingVisible = true;
   bool dataVisible = true;
   bool isNoResultVisible = true;
   bool isVerified = true;
   bool isNotVerified = true;
   

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

   Future<List<FilterServiceResponseModel>> fetchSubCategories(String serviceType) async {
     loading();

     final String apiUrl = ApiConstant.baseUri + 'skill-providers/searchSkillServiceType/$serviceType';
     final response = await http.get(
         Uri.parse(apiUrl));

     print("request: " + response.toString());
     print(response.statusCode);

     if (response.statusCode == 200) {
       print('Response Body: ${response.body}');
       final jsonResponse = json.decode(response.body);
       List<dynamic> items = jsonResponse['skillProviders'];
       return items.map((json) => FilterServiceResponseModel.fromJson(json)).toList();
     }

     else if(response.statusCode == 404){
       isNotLoading();

        dataVisible = false;
        isNoResultVisible = false;

     }
     throw Exception('Failed to load items');

   }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#f2f2f2"),
      appBar: AppBar(
        toolbarHeight: 50.0,
        backgroundColor: HexColor("#f2f2f2"),
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
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
           children: [
             Padding(
               padding: const EdgeInsets.only(left: 20.0),
               child: Text(widget.serviceType + " " + "near you",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.bold, fontSize:13.0,),),
             ),

             Expanded(child: SizedBox()),

             Padding(
               padding: const EdgeInsets.only(right: 20.0),
               child: Image(image: AssetImage("images/filter_icon.png"),width: 25.0, height: 23.0,),
             ),
           ],
            ),
          ),

          Stack(
          children: [
            Visibility(
              visible: dataVisible,
              child: Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: FutureBuilder<List<FilterServiceResponseModel>>(
                    future: fetchSubCategories(widget.serviceType),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(
                          padding: EdgeInsets.only(top: 200.0),
                          child:  Visibility(
                            visible: !isLoadingVisible,
                            child: SpinKitFadingCircle(
                              color: HexColor("#212529"),
                              size: 40.0,),
                          ),);
                      }
                      else if (snapshot.hasError) {
                        return Dialog(
                          backgroundColor: Colors.white,
                          child: Container(
                            height: 170.0,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40.0, left: 25.0),
                                      child: Image(image: AssetImage("images/error_icon.png"), width: 40.0, height: 40.0,),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 20.0),
                                      child: Text('Sorry an error occurred', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal,),),
                                    )
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0, left: 16.0, right: 16.0),
                                  child: Center(
                                    child: ElevatedButton(onPressed: () {

                                      fetchSubCategories(widget.serviceType);
                                    },
                                      child: Text("Try Again", style: TextStyle(fontSize: 14.0),),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white, backgroundColor: HexColor("#FF2121"), padding: EdgeInsets.all(10.0),
                                        minimumSize: Size(200.0, 30.0),
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
                              ],
                            ),
                            // child: Center(child: Text('Error: ${snapshot.error}')),
                          ),
                        );
                      }
                      else if(!snapshot.hasData || snapshot.data!.isEmpty || snapshot.data == null){
                        return Dialog(
                          backgroundColor: Colors.white,
                          child: Container(
                            height: 170.0,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 40.0, left: 25.0),
                                      child: Image(image: AssetImage("images/error_icon.png"), width: 40.0, height: 40.0,),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 20.0),
                                      child: Text('No Item Found', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.normal,),),
                                    )
                                  ],
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 15.0, left: 16.0, right: 16.0),
                                  child: Center(
                                    child: ElevatedButton(onPressed: () {

                                      Navigator.pop(context);
                                    },
                                      child: Text("Try Again", style: TextStyle(fontSize: 14.0),),
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white, backgroundColor: HexColor("#FF2121"), padding: EdgeInsets.all(10.0),
                                        minimumSize: Size(200.0, 30.0),
                                        // fixedSize: Size(300.0, 50.0),
                                        textStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                                        elevation: 5,
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
                              ],
                            ),
                            // child: Center(child: Text('Error: ${snapshot.error}')),
                          ),
                        );

                      }
                      else {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10.0 ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {

                              final item = snapshot.data![index];

                              if(item.isVerified == 'accept'){
                                 isVerified = false;
                                 isNotVerified = true;
                              }
                              else{
                                isVerified = true;
                                isNotVerified = false;
                              }

                              return new GestureDetector(
                                child: Container(
                                  // height: 250.0,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(top: 7.0, right: 15.0, left: 15.0, bottom: 5.0),
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                          Stack(
                                            children: [
                                              Visibility(
                                                visible: !isNotVerified,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 23.0, top: 13.0, bottom: 5.0),
                                                  child: Text('Not Verified', style: TextStyle(fontSize: 7.0, color: HexColor("#5E60CE"), fontWeight: FontWeight.bold),),
                                                ),
                                              ),

                                              Visibility(
                                                visible: !isVerified,
                                                child: Container(
                                                  padding: const EdgeInsets.only(left: 45.0, top: 13.0),
                                                  child: Image(image: AssetImage("images/verify_icon.png"),width: 24.0, height: 24.0,),
                                                ),
                                              ),
                                            ],
                                        ),

                                        Row(
                                          children: [

                                            Padding(
                                              padding: const EdgeInsets.only(left: 20.0, top: 0.0),
                                              child: CircleAvatar(
                                                radius: 20.0,
                                                backgroundColor: HexColor("#E4DFDF"),
                                                backgroundImage: NetworkImage("https://server.handiwork.com.ng/" + item.imagePath),
                                                child: item.imagePath == null ? Image(image: AssetImage("images/profile_white.png"),
                                                ) : null,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 20.0),
                                              child: Text(item.firstName + " " + " " + item.lastName, style: TextStyle(fontSize: 15.0, color: HexColor("#212529")),),
                                            ),
                                          ],
                                        ),

                                        Align(
                                          alignment: Alignment.topCenter,
                                          child: Text(item.subCategory, style: TextStyle(fontSize: 12.0, color: HexColor("#212529")),),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            children: [

                                              Expanded(child: SizedBox()),

                                              ElevatedButton(onPressed: () {
                                                Navigator.push(context, MaterialPageRoute(builder: (context){
                                                  return ServiceProviderDetailsPage(firstName: item.firstName, lastName: item.lastName, email: item.email,
                                                    phone: item.phone, id: item.id, stateOfResidence: item.stateOfResidence, city: item.city, serviceType: item.serviceType,
                                                    officeAddress: item.address, subCategory: item.subCategory, openingHour: item.openingHour, verified: item.isVerified,
                                                    imagePath: item.imagePath, skills: item.skills!, about: item.about!);
                                                }));
                                              },
                                                child: Text("View Profile", style: TextStyle(fontSize: 11.0),),
                                                style: ElevatedButton.styleFrom(
                                                  foregroundColor: Colors.white, backgroundColor: HexColor("#5E60CE"), padding: EdgeInsets.all(10.0),
                                                  minimumSize: Size(120.0, 30.0),
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

                                              Padding(
                                                padding: const EdgeInsets.only(left: 20.0),
                                                child: ElevatedButton(onPressed: () {



                                                },
                                                  child: Text("Make Schedule", style: TextStyle(fontSize: 11.0),),
                                                  style: ElevatedButton.styleFrom(
                                                    foregroundColor: Colors.white, backgroundColor: HexColor("#212529"), padding: EdgeInsets.all(10.0),
                                                    minimumSize: Size(120.0, 30.0),
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

                                              Expanded(child: SizedBox()),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),

            Visibility(
              visible: !isNoResultVisible,
              child: Container(
                height: 500.0,
                child:  Padding(
                  padding: const EdgeInsets.only(top: 250.0),
                  child: Text("No Result", style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),),
                ),
              ),
            ),
          ],
          ),
        ],
      ),
    );
  }
}
