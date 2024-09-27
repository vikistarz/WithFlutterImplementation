import 'package:cross_platform_application/webService/apiConstant.dart';
import'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../database/appPrefHelper.dart';
import '../../../database/saveValues.dart';
import '../../../dialogs/errorMessageDialog.dart';
import '../models/ServiceTypeResponseModel.dart';
import '../models/StateResponseModel.dart';

class ServiceTypeDialog extends StatefulWidget {
  const ServiceTypeDialog({super.key});

  @override
  State<ServiceTypeDialog> createState() => _ServiceTypeDialogState();
}

class _ServiceTypeDialogState extends State<ServiceTypeDialog> {

  String serviceType = "";
  int serviceTypeId = 0;
  String errorMessage = "";
  bool isLoadingVisible = true;

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


  Future<List<ServiceTypeResponseModel>> fetchServices() async {
    loading();
    final String apiUrl = ApiConstant.getServicesApi;
    final response = await http.get(
        Uri.parse(apiUrl));

    print("request: " + response.toString());
    print(response.statusCode);

    if (response.statusCode == 200) {
      print('Response Body: ${response.body}');
       List<dynamic> items = json.decode(response.body);
      return items.map((json) => ServiceTypeResponseModel.fromJson(json)).toList();

    }

    else {
      isNotLoading();
      throw Exception('Failed to load items');
    }
  }

  void saveUserDetails() async {

    SaveValues mySaveValues = SaveValues();

    await mySaveValues.saveInt(AppPreferenceHelper.SELECTED_SERVICE_TYPE_ID, serviceTypeId);

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.95,
      decoration: BoxDecoration(
          color: HexColor("#212529"),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, left: 20.0),
            child: IconButton(
              onPressed: (){
              Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios, size: 25.0, color: Colors.white,),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
            height: 55.0,
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, color: HexColor("#C3BDBD"), size: 23.0,),
                hintText: "Search Here",
                hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),

    Expanded(
      child: Container(
        height: 500.0,
        margin: EdgeInsets.only(bottom: 20.0),
        child: FutureBuilder<List<ServiceTypeResponseModel>>(
           future: fetchServices(),
           builder: (context, snapshot) {
             if (snapshot.connectionState == ConnectionState.waiting) {
               return Padding(
                 padding: EdgeInsets.only(top: 0.0),
                 child:  Visibility(
                   visible: !isLoadingVisible,
                   child: SpinKitFadingCircle(
                   color: Colors.white,
                   size: 50.0,),
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

                             fetchServices();
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
               // return Dialog(
               //
               //   backgroundColor: Colors.white,
               //   child: Container(
               //     height: 200.0,
               //       child: Center(child: Text('Error: ${snapshot.error}'))),
               // );
               // return Center(child: Text('Error: ${snapshot.error}'));
             }
             else if(!snapshot.hasData || snapshot.data!.isEmpty){
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
             else {
               return ListView.builder(
                 shrinkWrap: true,
                 itemCount: snapshot.data!.length,
                 itemBuilder: (context, index) {
                   final item = snapshot.data![index];

                   return new GestureDetector(
                     onTap: () {
                       serviceTypeId = item.id;
                       saveUserDetails();
                       Navigator.pop(context, item.serviceType);
                     },
                     child: Padding(
                       padding: const EdgeInsets.only(top: 15.0, left: 20.0),
                       child: Text(item.serviceType, style: TextStyle(color: Colors.white, fontSize: 18.0),),
                     ),
                   );
                     },
                  );
                }
               },
             ),
            ),
    ),
        ],
      ),
    );
  }
}
