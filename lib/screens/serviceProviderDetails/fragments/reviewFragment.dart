import 'dart:convert';

import'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;

import '../../../database/appPrefHelper.dart';
import '../../../database/saveValues.dart';
import '../../../dialogs/errorMessageDialog.dart';
import '../../../dialogs/successMessageDialog.dart';
import '../../../webService/apiConstant.dart';

class ReviewFragment extends StatefulWidget {
  ReviewFragment({Key? key, required this.serviceProviderId}) : super(key: key);

 int serviceProviderId;


  @override
  State<ReviewFragment> createState() => _ReviewFragmentState();
}

class _ReviewFragmentState extends State<ReviewFragment> {

  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  String token = "";
  String errorMessage = "";
  int? customerId;
  int ratingValue = 0;

  @override
  void initState() {
    super.initState();
    getSavedValue();
  }

  getSavedValue() async  {
    SaveValues mySaveValues = SaveValues();
    customerId = await mySaveValues.getInt(AppPreferenceHelper.SERVICE_PROVIDER_ID);
  }

  void _validateFormField() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isButtonEnabled = true;
      });
    } else {
      setState(() {
        _isButtonEnabled = false;
      });
    }
  }

  final commentController = TextEditingController();

  Future<void> postComment() async {

    final String apiUrl = ApiConstant.baseUri + 'skill-provider-reviews/create-review';

    try {
      final response = await http.post(Uri.parse(apiUrl),
        headers:<String, String>{
          "Content-type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          "skillProviderId": widget.serviceProviderId,
          "customerId": customerId,
          "rating": ratingValue,
          "comment": commentController.text,
        }),
      );

      print("request: " + response.toString());
      print(response.statusCode);

      if (response.statusCode == 200) {

        print('Response Body: ${response.body}');
        // successful post request, handle the response here
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        setState(() {
          commentController.text = "";
          ratingValue = 0;

          showModalBottomSheet(
              isDismissible: false,
              enableDrag: false,
              context: context,
              builder: (BuildContext context) {
                return SuccessMessageDialog(
                  content: "Your review sent successfully",
                  onButtonPressed: () {
                    Navigator.of(context).pop();
                    // Add any additional action here
                  },
                );
              });
        });
      }

      else{
        print('Response Body: ${response.body}');
        // if the server return an error response
        final Map<String, dynamic> errorData = json.decode(response.body);
        errorMessage = errorData['error'] ?? 'Unknown error occurred';
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
                  },
                );
              });
        });
      }
    }
    catch (e) {
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
                },
              );
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    color: Colors.white,
    ),
    child: SingleChildScrollView(
    scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 3.0),
                  child: Text("Leave a Review and Rate", style: TextStyle(color: HexColor("#212529"), fontSize: 12.0),),
                ),

                Expanded(
                    child: SizedBox()
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text("Rate:", style: TextStyle(color: HexColor("#212529"), fontSize: 12.0),),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 5.0, top: 3.0),
                  child: RatingBar.builder(
                    initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context,_) => Icon(Icons.star, color: HexColor("#FFC107"),),
                      onRatingUpdate: (rating){
                        setState(() {
                          ratingValue = rating as int; // Get the selected rating value
                        });
                      },
                    itemSize: 15.0,
                    unratedColor: Colors.grey[300],
                  ),
                ),
              ],
            ),

            Form(
              key: _formKey,
              onChanged: _validateFormField,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a comment';
                    }
                    else{
                      return null; // Return null if the input is valid
                    }
                  },
                  controller: commentController,
                  keyboardType:TextInputType.text,
                  decoration: InputDecoration(

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: HexColor("#B5B3B3"), width: 2.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: HexColor("#B5B3B3"), width: 1.0),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
                    counterText: '',
                  ),
                  maxLines: 2,
                  maxLength: 100,
                  style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: ElevatedButton(onPressed: _isButtonEnabled
                    ? () {
                  // Action to be taken on button press
                  postComment();

                }
                    : null,
                  child: Text("Comment", style: TextStyle(fontSize: 14.0),),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: HexColor("#212529"), padding: EdgeInsets.all(10.0),
                    minimumSize: Size(MediaQuery.of(context).size.width, 40.0),
                    // fixedSize: Size(300.0, 50.0),
                    textStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0)),
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                child: Text("Customer Feedback", style: TextStyle(color: HexColor("#A1A0A0"), fontSize: 12.0, fontWeight: FontWeight.bold),),
              ),
            ),

      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                color: HexColor("#C3BDBD"),
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(1,1),
              ),
            ],
        ),
        child:  Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
              child: Text("Service Provider Rating & Reviews", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0),),
            ),

            Expanded(
                child: SizedBox()
            ),
            
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.black, size: 17.0,),
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
}
