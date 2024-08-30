
import 'dart:convert';

import 'package:cross_platform_application/screens/choiceScreen/choiceScreenPage.dart';
import 'package:cross_platform_application/screens/customerDashBoard/customerDashboard.dart';
import 'package:cross_platform_application/screens/logIn/model/loginRequestModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../database/appPrefHelper.dart';
import '../../../database/saveValues.dart';
import '../../forgetPassword/passwordRecovery.dart';
import '../viewModel/customerLogInViewModel.dart';
import 'package:http/http.dart' as http;

class CustomerFragment extends StatefulWidget {
  const CustomerFragment({super.key});

  @override
  State<CustomerFragment> createState() => _CustomerFragmentState();
}

class _CustomerFragmentState extends State<CustomerFragment> {

  final _formKey = GlobalKey<FormState>();
  var _emailPhone, _password;
  bool _isButtonEnabled = false;
  bool isLoadingVisible = true;
  bool passwordVisible =  false;
  String? token, errorMessage;



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


  TextEditingController emailAddressPhoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // final CustomerLoginViewModel myCustomerViewModel = CustomerLoginViewModel();


  void saveUserDetails() async {

    SaveValues mySaveValues = SaveValues();

    await mySaveValues.saveString(AppPreferenceHelper.EMAIL_ADDRESS, emailAddressPhoneController.text);

  }

  void loading(){
    setState(() {
      isLoadingVisible = false;
    });
  }

  Future<void> makePostRequest(String emailOrPhone, String password) async {
    final url = Uri.parse('https://server.handiwork.com.ng/api/auth/login/customer'); // Replace with your API URL

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer your_token_here', // Add this if your API requires authentication
        },
        body: json.encode({
          'emailOrPhone': emailOrPhone,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Successfully received a response
        final Map<String, dynamic> responseData = json.decode(response.body);
        token = responseData['token'];
        print('Response data: $token');
        // Handle the response data, e.g., save to SharedPreferences, navigate, etc.
      } else {
        // Handle error response
        print('Failed to login: ${response.statusCode}');
        final Map<String, dynamic> errorData = json.decode(response.body);
        errorMessage = errorData['error'] ?? 'Unknown error occurred';
        print('Error message: $errorMessage');
      }
    } catch (error) {
      // Handle network or other errors
      print('An error occurred: $error');
    }
  }

  void _login() async {
    final emailOrPhone = emailAddressPhoneController.text;
    final password = passwordController.text;

    await makePostRequest(emailOrPhone, password);
    // Handle navigation or other actions after the request
    if (token != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login successful')),
      );
    }
    else if(errorMessage != null){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(' $errorMessage')),
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Sorry no internet Connection")),
      );
    }
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
                      keyboardType:TextInputType.emailAddress,
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
                           // saveUserDetails();
                           loading();
                           _login();
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
