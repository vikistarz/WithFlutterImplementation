import 'package:cross_platform_application/webService/apiConstant.dart';
import'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../../database/appPrefHelper.dart';
import '../../../../../database/saveValues.dart';
import '../../../../../dialogs/errorMessageDialog.dart';
import '../../../../serviceProviderSignUp/models/ServiceTypeResponseModel.dart';
import '../../../../serviceSubCategories/serviceSubCategories.dart';

class SearchServiceProviderDialog extends StatefulWidget {
  const SearchServiceProviderDialog({super.key});

  @override
  State<SearchServiceProviderDialog> createState() => _SearchServiceProviderDialogState();
}

class _SearchServiceProviderDialogState extends State<SearchServiceProviderDialog> {

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

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  TextEditingController _searchController = TextEditingController();
  List<ServiceTypeResponseModel> _items = [];
  List<ServiceTypeResponseModel> _filteredItems = [];



  Future<List<ServiceTypeResponseModel>> fetchServices() async {
    loading();
    final String apiUrl = ApiConstant.getServicesApi;
    final response = await http.get(Uri.parse(apiUrl));

    print("request: " + response.toString());
    print(response.statusCode);

    if (response.statusCode == 200) {
      print('Response Body: ${response.body}');
      List<dynamic> items = json.decode(response.body);

      return items.map((json) => ServiceTypeResponseModel.fromJson(json)).toList();

    }

    else {
      isNotLoading();
      setState(() {
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              return ErrorMessageDialog(
                content: "An error occurred",
                onButtonPressed: () {
                  Navigator.of(context).pop();
                  // Add any additional action here
                  // isNotLoading();
                },
              );
            });
      });
      throw Exception('Failed to load items');
    }
  }

  Future<void> _loadItems() async {
    try {
      final items = await fetchServices();
      setState(() {
        _items = items;
        _filteredItems = items;
        loading();
      });
    } catch (e) {
      setState(() {
       loading();
      });
      print("Error loading items: $e");
    }
  }

  void _filterItems(String query) {
    if (query.isEmpty) {
      setState(() {
         _filteredItems = _items;
      });
    } else {
      setState(() {
        _filteredItems = _items
            .where((item) => item.serviceType.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 1.0,
      decoration: BoxDecoration(
          color: HexColor("#f2f2f2"),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0.0),
          topRight: Radius.circular(0.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              new GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(top:40.0,left: 16.0, right: 20.0),
                  width: 22.0,
                  height: 25.0,
                  child: Image(image: AssetImage("images/arrow_back.png"),),
                ),
              ),

              Expanded(child: SizedBox()),

              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Text("Search Category", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: HexColor("#212529"),),),
              ),

              Expanded(
                flex: 2,
                  child: SizedBox()),
            ],
          ),

          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search, color: HexColor("#C3BDBD"), size: 20.0,),
                    hintText: "Search Category",
                    hintStyle: TextStyle(fontSize: 13.0, color: Colors.grey, fontWeight: FontWeight.normal),
                    // Customize label color
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: HexColor("#212529"), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),// Border color when not focused
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: HexColor("#212529"), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),// Same border color when focused
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: HexColor("#212529"), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),// General border color
                    ),
                  ),
                  onChanged: (query) => _filterItems(query),
                ),
              ),

              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 27.0,
                  width: 27.0,
                  margin: EdgeInsets.only(right: 40.0, top: 55.0),
                  decoration: BoxDecoration(
                    color: HexColor("#5E60CE"),
                    borderRadius: BorderRadius.all(Radius.circular(14.0)),
                  ),
                  child: Icon(Icons.search, color: Colors.white, size: 13.0,),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 20.0,
          ),

          // _filteredItems.isEmpty
          //     ? Padding(
          //       padding: const EdgeInsets.only(top: 150.0),
          //       child: Center(child: Text('No results found', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),),
          //     )
          //     :

    Expanded(
      child: Container(
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
                   // itemCount: snapshot.data!.length,
                   itemCount: _filteredItems.length,
                   itemBuilder: (context, index) {

                     // final item = snapshot.data![index];
                     final item = _filteredItems[index];

                     return new GestureDetector(
                       onTap: () {
                          serviceType =  item.serviceType;
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ServicesSubCategories(serviceType: serviceType);
                      }));
                         // Navigator.pop(context, item.serviceType);
                       },
                       child: Container(
                         height: 55.0,
                             width: MediaQuery.of(context).size.width,
                             margin: EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0, bottom: 5.0),
                         child: Card(
                           color: Colors.white,
                           elevation: 2,
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(15.0),
                           ),
                     child: Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 30.0),
                           child: Image(image: AssetImage("images/service_provider_icon.png"), width: 20.0, height: 20.0,),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(left: 20.0),
                           child: Text(item.serviceType, style: TextStyle(fontSize: 10.0, color: HexColor("#212529")),),
                         ),
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
        ],
      ),
    );
  }
}
