import'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../database/appPrefHelper.dart';
import '../../../database/saveValues.dart';
import '../../../dialogs/errorMessageDialog.dart';
import '../models/StateResponseModel.dart';
import '../models/SubCategoryResponseModel.dart';

class SubCategoryDialog extends StatefulWidget {
  const SubCategoryDialog({super.key});

  @override
  State<SubCategoryDialog> createState() => _SubCategoryDialogState();
}

class _SubCategoryDialogState extends State<SubCategoryDialog> {

  int? serviceTypeId;


  @override
  void initState() {
    super.initState();
    getSavedValue();
  }

  getSavedValue() async  {
    SaveValues mySaveValues = SaveValues();
    int? service_type_id = await mySaveValues.getInt(AppPreferenceHelper.SELECTED_SERVICE_TYPE_ID);
    setState(() {
      serviceTypeId = service_type_id;
    });
  }

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


  Future<SubCategoryResponseModel> fetchSubCategory(int id) async {
    loading();

    final response = await http.get(
        Uri.parse("https://server.handiwork.com.ng/api/skillType/service/servicewithcategories/$id"));
    if (response.statusCode == 200) {
      print('Response Body: ${response.body}');
      return SubCategoryResponseModel.fromJson(json.decode(response.body));
      // final jsonResponse = json.decode(response.body);
      // List<dynamic> items = jsonResponse['subCategories'];
      // return items.map((json) => SubCategoryResponseModel.fromJson(json)).toList();
    }

    else {
      isNotLoading();
      throw Exception('Failed to load items');
    }
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
        child: FutureBuilder<SubCategoryResponseModel>(
           future: fetchSubCategory(serviceTypeId!),
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

                             fetchSubCategory(serviceTypeId!);
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
                 ),
               );
             }

             else {
               final data = snapshot.data!;
               return ListView.builder(
                 shrinkWrap: true,
                 itemCount: data.subCategories.length,
                 itemBuilder: (context, index) {
                   // final item = snapshot.data![index];

                   return new GestureDetector(
                     onTap: () {
                       Navigator.pop(context, data.subCategories[index]);
                     },
                     child: Container(
                       margin: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                       child: Text(data.subCategories[index], style: TextStyle(color: Colors.white, fontSize: 18.0),),
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
