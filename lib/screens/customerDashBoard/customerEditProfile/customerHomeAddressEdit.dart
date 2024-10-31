import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import '../../../database/appPrefHelper.dart';
import '../../../database/saveValues.dart';
import '../../../dialogs/errorMessageDialog.dart';
import '../../../dialogs/successMessageDialog.dart';
import '../../../webService/apiConstant.dart';
class CustomerHomeAddressEditDialog extends StatefulWidget {
  const CustomerHomeAddressEditDialog({super.key});

  @override
  State<CustomerHomeAddressEditDialog> createState() => _CustomerHomeAddressEditDialogState();
}

class _CustomerHomeAddressEditDialogState extends State<CustomerHomeAddressEditDialog> {


  final _formKey = GlobalKey<FormState>();
  bool isContinueVisible = true;
  bool isLoadingVisible = true;
  bool passwordVisible =  false;
  String? homeAddress;
  String errorMessage = "";
  int? customerId;

  final homeAddressController = TextEditingController();


  @override
  void initState() {
    super.initState();
    getSavedValue();
  }

  void getSavedValue() async {
    SaveValues mySaveValues = SaveValues();
    customerId = await mySaveValues.getInt(AppPreferenceHelper.CUSTOMER_ID);
    homeAddress = await mySaveValues.getString(AppPreferenceHelper.HOME_ADDRESS);

    setState(() {
      homeAddressController.text = homeAddress!;
      // fetchUserData(customerId!);
    });
  }

  // Function to validate the form and update button state
  void _validateFormField() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        // _isSaveButtonVisible = true;
      });
    } else {
      setState(() {
        // _isSaveButtonVisible = false;
      });
    }
  }

  @override
  void dispose() {
    homeAddressController.dispose();
    super.dispose();
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

  Future<void> updateCustomerHomeAddress(int id) async {
    loading();

    final String apiUrl = ApiConstant.baseUri + 'customers/updateCustomerRecord/$id';

    try {
      final response = await http.patch(Uri.parse(apiUrl),
        headers:<String, String>{
          "Content-type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          "address" :  homeAddressController.text
        }),
      );

      print("request: " + response.toString());
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        isNotLoading();
        print('Response Body: ${response.body}');
        // successful post request, handle the response here
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        setState(() {

          showModalBottomSheet(
              isDismissible: false,
              enableDrag: false,
              context: context,
              builder: (context) {
                return SuccessMessageDialog(
                  content: "Home address updated successfully",
                  onButtonPressed: () {
                    Navigator.of(context).pop();

                    setState(() {
                      isContinueVisible = !isContinueVisible;
                    });

                  },
                );
              });
        });
      }

      else{
        isNotLoading();
        // if the server return an error response
        final Map<String, dynamic> errorData = json.decode(response.body);
        errorMessage = errorData['error'] ?? 'Unknown error occurred';

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
      }
    }
    catch (e) {
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



  @override
  Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.68,
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
              children: [

                new GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 70.0,
                    height: 30.0,
                    margin:EdgeInsets.only(left: 20.0),
                    child: Text("Cancel", style: TextStyle(color: HexColor("#2945DD"), fontSize: 15.0, fontWeight: FontWeight.normal), ),
                  ),
                ),

                Expanded(child: SizedBox(),),

                Container(
                    height: 30.0,
                    child: Text("Edit Profile", style: TextStyle(color: HexColor("#212529"), fontSize: 15.0, fontWeight: FontWeight.bold),)),

                Expanded(child: SizedBox(),),

                Visibility(
                  visible: !isLoadingVisible,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: SpinKitFadingCircle(
                      color: HexColor("#212529"),
                      size: 25.0,
                    ),
                  ),
                ),

                new GestureDetector(
                  onTap: (){

                    updateCustomerHomeAddress(customerId!);
                  },
                  child: Container(
                      width: 70.0,
                      height: 30.0,
                      margin: EdgeInsets.only(right: 20.0),
                    child: Align(
                      alignment: Alignment.topRight,
                        child: Text("Save", style: TextStyle(color: HexColor("#2945DD"), fontSize: 15.0, fontWeight: FontWeight.normal), )),
                  ),
                ),

              ],
                  ),
                ),

                Form(
                  key: _formKey,
                  onChanged: _validateFormField,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Home Address';
                        }
                        else{
                          return null; // Return null if the input is valid
                        }
                      },
                      controller: homeAddressController,
                      keyboardType:TextInputType.text,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: HexColor("#F6F6F6"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 16.0) ,
                        counterText: '',
                      ),
                      style: TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.normal),
                    ),
                  ),
                ),

                Visibility(
                  visible: !isContinueVisible,
                  child: new GestureDetector(
                    onTap: () {
                      Navigator.pop(context, homeAddressController.text);
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 50.0),
                      height: 30.0,
                      child: Text("Continue", style: TextStyle(color: HexColor("#2945DD"), fontSize: 25.0, fontWeight: FontWeight.bold),),
                    ),
                  ),
                ),

              ],
            ),
        ),
      );
  }
}
