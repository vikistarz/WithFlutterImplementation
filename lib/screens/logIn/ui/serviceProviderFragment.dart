import 'dart:convert';

import 'package:cross_platform_application/screens/serviceProviderDashBoard/serviceProviderDashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../database/appPrefHelper.dart';
import '../../../database/saveValues.dart';
import '../../../dialogs/errorMessageDialog.dart';
import '../../../dialogs/successMessageDialog.dart';
import '../../choiceScreen/choiceScreenPage.dart';
import '../../forgetPassword/passwordRecovery.dart';
import 'package:http/http.dart' as http;

class ServiceProviderFragment extends StatefulWidget {
  const ServiceProviderFragment({super.key});

  @override
  State<ServiceProviderFragment> createState() => _ServiceProviderFragmentState();
}

class _ServiceProviderFragmentState extends State<ServiceProviderFragment> {

  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;
  bool isLoadingVisible = true;
  bool passwordVisible =  false;
  String token = "";
  String errorMessage = "";
  int serviceProviderId = 0;



  // Function to validate the form and update button state
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

  final String apiUrl = "https://server.handiwork.com.ng/api/auth/login/skill-provider";

  TextEditingController emailAddressPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void dispose() {
    emailAddressPhoneController.dispose();
    passwordController.dispose();
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

  Future<void> makePostRequest() async {
    loading();

    try {
      final response = await http.post(Uri.parse(apiUrl),
        headers:<String, String>{
          "Content-type": "application/json"
        },
        body: jsonEncode(<String, dynamic>{
          "emailOrPhone": emailAddressPhoneController.text,
          "password": passwordController.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        isNotLoading();
        // successful post request, handle the response here
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        setState(() {
          token = responseData['token'];
          serviceProviderId = responseData['skillProvider']['id'];
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return SuccessMessageDialog(
                  content: "Service Provider Sign up Successful",
                  onButtonPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ServiceProviderDashboardPage();
                    }));
                    // Add any additional action here
                    saveUserDetails();
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
            isScrollControlled: true,
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
            isScrollControlled: true,
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

  void saveUserDetails() async {

    SaveValues mySaveValues = SaveValues();
    await mySaveValues.saveInt(AppPreferenceHelper.SERVICE_PROVIDER_ID, serviceProviderId);

  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
          children: [
            Container(
              margin: EdgeInsets.all(0.0),
              height: 250.0,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("images/customer_design.png",), fit: BoxFit.cover),
              ),
            ),
            Column(
              children: [
                Form(
                  key: _formKey,
                  onChanged: _validateFormField,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email or Phone number';
                            }
                            if (value.length < 11) {
                              return 'Please enter a valid email or phone.';
                            }
                            // if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            //     return 'Please enter a valid email';
                            //         }
                            else{
                              return null; // Return null if the input is valid
                            }
                          },
                          controller: emailAddressPhoneController,
                          keyboardType:TextInputType.text,
                          decoration: InputDecoration(
                            filled: true, // Set this to true to enable the background color
                            fillColor: Colors.white, // Set the desired background color
                            hintText: "Email Address or Phone Number",
                            hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.normal),
                            prefixIcon: Icon(Icons.person_outline_sharp,color: HexColor("#C3BDBD")),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: HexColor("#212529"), width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: HexColor("#212529"), width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            counterText: '',
                          ),
                        ),
                      ),




                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            if (value.length < 6) {
                              return 'must be at least 6 characters long';
                            }
                            // if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            //     return 'Please enter a valid email';
                            //         }
                            else{
                              return null; // Return null if the input is valid
                            }
                          },
                          controller: passwordController,
                          obscureText: passwordVisible,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            // labelText: "Last name",
                            filled: true, // Set this to true to enable the background color
                            fillColor: Colors.white, // Set the desired background color
                            hintText: "Password",
                            hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.normal),
                            prefixIcon: Icon(Icons.lock_open,color: HexColor("#C3BDBD")),
                            suffixIcon: IconButton(icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey,),
                              onPressed: (){
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                },
                                );
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: HexColor("#212529"), width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: HexColor("#212529"), width: 1.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            counterText: '',
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return PasswordRecoveryPage();
                    }));
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      margin: EdgeInsets.only(top: 20.0, right: 18.0),
                      child: Text("Forgot Password?",style: TextStyle(color: HexColor("#5E60CE"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                    ),
                  ),
                ),

                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0, bottom: 10.0),
                      child: Center(
                        child: ElevatedButton(onPressed: _isButtonEnabled
                            ? () {
                          // Action to be taken on button press
                          // loading();
                          makePostRequest();
                        }
                            : null, // Disable button if form is invalid() {
                          child: Text("Log in", style: TextStyle(fontSize: 18.0),),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white, backgroundColor: HexColor("#5E60CE"), padding: EdgeInsets.all(10.0),
                            minimumSize: Size(MediaQuery.of(context).size.width, 50.0),
                            // fixedSize: Size(300.0, 50.0),
                            textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
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

                    Visibility(
                      visible: !isLoadingVisible,
                      child: Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0, bottom: 10.0),
                        decoration: BoxDecoration(
                          color: HexColor("#A7A8DC"),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            SpinKitFadingCircle(
                              color: HexColor("#F5F6F6"),
                              size: 20.0,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text("Loading",style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize:12.0,),),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ],
                ),

                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:15.0,),),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return ChoiceScreenPage();
                              }));
                            },
                            child: Text("Sign Up",style: TextStyle(color: HexColor("#5E60CE"), fontWeight: FontWeight.normal, fontSize:15.0,),)),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 80.0,
                )
              ],
            )
          ]
      ),
    );
  }
}
