import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';

import '../../../dialogs/errorMessageDialog.dart';
import '../../../webService/apiConstant.dart';
import '../getReviewModel/CustomerReviewResponseModel.dart';
import 'package:http/http.dart' as http;

class GetRatingsReviewPage extends StatefulWidget {
  GetRatingsReviewPage({Key? key, required this.serviceProviderId}) : super(key: key);

  int serviceProviderId;

  @override
  State<GetRatingsReviewPage> createState() => _GetRatingsReviewPageState();
}

class _GetRatingsReviewPageState extends State<GetRatingsReviewPage> {

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

  Future<List<GetReviewResponseModel>> fetchReviews(int serviceProviderId) async {
    final String apiUrl = ApiConstant.baseUri + 'skill-provider-reviews/details/$serviceProviderId';

    loading();

    final response = await http.get(
        Uri.parse(apiUrl));

    print("request: " + response.toString());
    print(response.statusCode);

    if (response.statusCode == 200) {
      print('Response Body: ${response.body}');
      final jsonResponse = json.decode(response.body);
      // Access the skill_provider object
      Map<String, dynamic> skillProviderDetailsAndReviews = jsonResponse['skillProviderDetailsAndReviews'];

      // Access the reviews array inside skill_provider
      List<dynamic> reviewArray = skillProviderDetailsAndReviews['reviews'];
      return reviewArray.map((json) => GetReviewResponseModel.fromJson(json)).toList();


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
            width: 16.0,
            height: 18.0,
            child: Image(image: AssetImage("images/arrow_back.png"),),
          ),
        ),
      ),
      body: FutureBuilder<List<GetReviewResponseModel>>(
        future: fetchReviews(widget.serviceProviderId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: EdgeInsets.only(top: 0.0),
              child:  Visibility(
                visible: !isLoadingVisible,
                child: SpinKitFadingCircle(
                  color: HexColor("#212529"),
                  size: 50.0,),
              ),);
          }
          else if (snapshot.hasError) {
            // print('Error: $error');
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

                          fetchReviews(widget.serviceProviderId);
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
                reverse: true,
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {

                  final item = snapshot.data![index];

                  // Parse the ISO 8601 date string into a DateTime object
                  DateTime parsedDate = DateTime.parse(item.createdAt);

                  // Format the DateTime object to a readable format
                  String formattedDate = DateFormat('MMMM d, yyyy').format(parsedDate);

                  print(formattedDate); // Outputs: October 30, 2024

                  return Container(
                    // height: 250.0,
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(right: 10.0, left: 10.0, bottom: 15.0),
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [

                              Padding(
                                padding: const EdgeInsets.only(left: 16.0, top: 10.0),
                                child: RatingBar.builder(
                                  initialRating: item.rating.toDouble(),
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 5,
                                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                  itemBuilder: (context,_) => Icon(Icons.star, color: HexColor("#FFC107"),),
                                  onRatingUpdate: (rating){

                                    setState(() {

                                      // Get the selected rating value
                                    });
                                  },
                                  itemSize: 16.0,
                                  unratedColor: Colors.grey[300],
                                ),
                              ),

                              Expanded(child: SizedBox()),

                              Padding(
                                padding: const EdgeInsets.only(right: 20.0, top: 10.0),
                                child: Text(formattedDate, style: TextStyle(fontSize: 9.0, color: HexColor("#858585")),),
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                            child: Text(item.comment, style: TextStyle(fontSize: 11.0, color: HexColor("#858585")),),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, bottom: 10.0, top: 5.0),
                            child: Text(item.customerName + "-", style: TextStyle(fontSize: 11.0, color: HexColor("#212529")),),
                          ),

                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
