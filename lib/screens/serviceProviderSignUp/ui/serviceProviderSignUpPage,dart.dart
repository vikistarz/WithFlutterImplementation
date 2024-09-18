import 'package:cross_platform_application/screens/choiceScreen/choiceScreenPage.dart';
import 'package:cross_platform_application/screens/serviceProviderSignUp/dialogs/startTimeEndTime.dart';
import 'package:cross_platform_application/screens/serviceProviderSignUp/ui/serviceProviderUploadImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../logIn/ui/logIn.dart';
import '../dialogs/cityDialog.dart';
import '../dialogs/serviceTypeDialog.dart';
import '../dialogs/stateOfResidenceDialog.dart';
import '../dialogs/subCategoryDialog.dart';



class ServiceProviderSignUpPage extends StatefulWidget {
  const ServiceProviderSignUpPage({super.key});

  @override
  State<ServiceProviderSignUpPage> createState() => _ServiceProviderSignUpPageState();
}

class _ServiceProviderSignUpPageState extends State<ServiceProviderSignUpPage> {

  final _formKey = GlobalKey<FormState>();
  bool passwordVisible =  false;
  bool confirmPasswordVisible =  false;
  bool _isButtonEnabled = false;
  bool isLoadingVisible = true;
  bool cityVisible = false;
  bool officeAddressVisible = false;
  bool subCategoryVisible = false;
  String token = "";
  String errorMessage = "";
  int customerWalletId = 0;

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


  TextEditingController statesController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController serviceTypeController = TextEditingController();
  TextEditingController subcategoryController = TextEditingController();
  TextEditingController openingHourController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController mobile1Controller = TextEditingController();
  TextEditingController mobile2Controller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController officeAddressController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();


  @override
  void dispose() {
    statesController.dispose();
    cityController.dispose();
    serviceTypeController.dispose();
    subcategoryController.dispose();
    openingHourController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    emailAddressController.dispose();
    mobile1Controller.dispose();
    mobile2Controller.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    officeAddressController.dispose();
    referralCodeController.dispose();

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

  void updateStateTextValue(){
    setState(() {
      statesController.text = states == null ? "" : "$states";
    });
  }

  void updateCityTextValue(){
    setState(() {
      cityController.text = city == null ? "" : "$city";
    });
  }

  void updateServiceTypeTextValue(){
    setState(() {
      serviceTypeController.text = serviceType == null ? "" : "$serviceType";
    });
  }

  void updateSubCategoryTextValue(){
    setState(() {
      subcategoryController.text = subCategory == null ? "" : "$subCategory";
    });
  }

  void updateOpeningHourTextValue(){
    setState(() {
      openingHourController.text = openingHour == null ? "" : "$openingHour";
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50.0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 25.0, color: HexColor("#212529"),), onPressed: (){
          Navigator.pop(context);
        }, color: HexColor("#212529")
        ) ,
        title: Text("Get Started as a Service Provider", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: HexColor("#212529"),),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
    Form(
    key: _formKey,
    onChanged: _validateFormField,
    child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
        child: TextFormField(
          validator: (value) {
            final regex = RegExp(r'^[a-zA-Z]+$');
            if (value == null || value.isEmpty) {
              return 'Please enter Last name';
            }
            if (value.length < 2) {
              return 'Please enter a valid name with at least two alphabetic characters.';
            }
            if (!regex.hasMatch(value)) {
              return 'Please enter only letters';
            }
            else{
              return null; // Return null if the input is valid
            }
          },
          controller: firstNameController,
          keyboardType:TextInputType.name,
          decoration: InputDecoration(
            hintText: "First name",
            hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.normal),
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
          style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
        child: TextFormField(
          validator: (value) {
            final regex = RegExp(r'^[a-zA-Z]+$');
            if (value == null || value.isEmpty) {
              return 'Please enter Last name';
            }
            if (value.length < 2) {
              return 'Please enter a valid name with at least two alphabetic characters.';
            }
            if (!regex.hasMatch(value)) {
              return 'Please enter only letters';
            }
            else{
              return null; // Return null if the input is valid
            }
          },
          controller: lastNameController,
          keyboardType:TextInputType.name,
          decoration: InputDecoration(
            hintText: "Last name",
            hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.normal),
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
          style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),
        ),
      ),


      Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
        child: TextFormField(
          validator: (value) {
            final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
            if (value == null || value.isEmpty) {
              return 'Please enter email address';
            }
            if (value.length < 11) {
              return 'Please enter a valid email address.';
            }
            if (!regex.hasMatch(value)) {
              return 'Please enter a valid email address.';
            }
            else{
              return null; // Return null if the input is valid
            }
          },
          controller: emailAddressController,
          keyboardType:TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Email Address",
            hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.normal),
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
          style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
        child: TextFormField(
          validator: (value) {
            final regex = RegExp(r'^[+-]?\d+(\.\d+)?$');
            if (value == null || value.isEmpty) {
              return 'Please enter phone Number';
            }
            if (value.length < 11) {
              return 'Please enter a valid Phone Number';
            }
            if (!regex.hasMatch(value)) {
              return 'Please enter a valid Phone Number';
            }
            else{
              return null; // Return null if the input is valid
            }
          },
          controller: mobile1Controller,
          keyboardType:TextInputType.phone,
          maxLength: 11,
          decoration: InputDecoration(
            hintText: "Mobile",
            hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.normal),
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
          style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
        child: TextFormField(
          // validator: (value) {
          //   final regex = RegExp(r'^[+-]?\d+(\.\d+)?$');
          //   if (value == null || value.isEmpty) {
          //     return 'Please enter phone Number';
          //   }
          //   if (value.length < 11) {
          //     return 'Please enter a valid Phone Number';
          //   }
          //   if (!regex.hasMatch(value)) {
          //     return 'Please enter a valid Phone Number';
          //   }
          //   else{
          //     return null; // Return null if the input is valid
          //   }
          // },
          controller: mobile2Controller,
          keyboardType:TextInputType.phone,
          maxLength: 11,
          decoration: InputDecoration(
            hintText: "Mobile 2 (Optional)",
            hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.normal),
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
          style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),
        ),
      ),



            new GestureDetector(
              onTap: (){
                setState(() {

                  cityVisible = !cityVisible;
                  officeAddressVisible = !officeAddressVisible;

                });

                _openStateOfResidenceDialog();
              },
              child:  Padding(
                padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select State of residence';
                    }
                    else{
                      return null; // Return null if the input is valid
                    }
                  },
                               controller: statesController,
                               decoration: InputDecoration(
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(5.0),),
                                 suffixIcon: Icon(Icons.keyboard_arrow_down, size: 25.0, color: HexColor("#C3BDBD")),
                                 hintText: "State of Residence",
                                 hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.normal),
                                 disabledBorder: OutlineInputBorder(
                                   borderSide: BorderSide(color: HexColor("#212529"), width: 1.0),
                                   borderRadius: BorderRadius.circular(5.0),
                                 ),
                                ),
                               style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),
                                enabled: false,
                             ),
                           ),
                         ),


      Visibility(
        visible: cityVisible,
        child: new GestureDetector(
          onTap: (){
            setState(() {
              officeAddressVisible = !officeAddressVisible;
            });
            _openCityDialog();
          },
          child:  Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select City';
                }
                else{
                  return null; // Return null if the input is valid
                }
              },
              controller: cityController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),),
                suffixIcon: Icon(Icons.keyboard_arrow_down, size: 25.0, color: HexColor("#C3BDBD")),
                hintText: "City",
                hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.normal),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor("#212529"), width: 1.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),
              enabled: false,
            ),
          ),
        ),
      ),


      Visibility(
        visible: officeAddressVisible,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter Office Address';
              }
              else{
                return null; // Return null if the input is valid
              }
            },
            controller: officeAddressController,
            keyboardType:TextInputType.text,
            decoration: InputDecoration(
              hintText: "Office number and Street name",
              hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.normal),
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
            style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),
          ),
        ),
      ),

      new GestureDetector(
        onTap: (){
          setState(() {
            subCategoryVisible = !subCategoryVisible;
          });
          _openServiceTypeDialog();
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select Service Type';
              }
              else{
                return null; // Return null if the input is valid
              }
            },
            controller: serviceTypeController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),),
              suffixIcon: Icon(Icons.keyboard_arrow_down, size: 25.0, color: HexColor("#C3BDBD")),
              hintText: "Service Type",
              hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.normal),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor("#212529"), width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),
            enabled: false,
          ),
        ),
      ),

      Visibility(
        visible: subCategoryVisible,
        child: new GestureDetector(
          onTap: (){
            _openSubCategoryDialog();
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please select Sub-category';
                }
                else{
                  return null; // Return null if the input is valid
                }
              },
              controller: subcategoryController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),),
                suffixIcon: Icon(Icons.keyboard_arrow_down, size: 25.0, color: HexColor("#C3BDBD")),
                hintText: "Sub-category",
                hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.normal),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: HexColor("#212529"), width: 1.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),
              enabled: false,
            ),
          ),
        ),
      ),

      new GestureDetector(
        onTap: (){
          _openingHourDialog();
        },
        child:  Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
          child: TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select Opening hours';
              }
              else{
                return null; // Return null if the input is valid
              }
            },
            controller: openingHourController,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),),
              suffixIcon: Icon(Icons.keyboard_arrow_down, size: 25.0, color: HexColor("#C3BDBD")),
              counterText: '',
              hintText: "Opening Hour",
              hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.normal),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor("#212529"), width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),
            enabled: false,
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
            hintText: "New Password",
            hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.normal),
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
          style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),
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
            if (value != passwordController.text) {
              return 'Passwords do not match';
            }
            else{
              return null; // Return null if the input is valid
            }
          },
          controller: confirmPasswordController,
          obscureText: confirmPasswordVisible,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            // labelText: "Last name",
            hintText: "Confirm Password",
            hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.normal),
            suffixIcon: IconButton(icon: Icon(confirmPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey,),
              onPressed: (){
                setState(() {
                  confirmPasswordVisible = !confirmPasswordVisible;
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
          style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
        child: TextFormField(
          // validator: (value) {
          //   final regex = RegExp(r'^[a-zA-Z]+$');
          //   if (value == null || value.isEmpty) {
          //     return 'Please enter Last name';
          //   }
          //   if (value.length < 2) {
          //     return 'Please enter a valid name with at least two alphabetic characters.';
          //   }
          //   if (!regex.hasMatch(value)) {
          //     return 'Please enter only letters';
          //   }
          //   else{
          //     return null; // Return null if the input is valid
          //   }
          // },
          controller: referralCodeController,
          keyboardType:TextInputType.text,
          decoration: InputDecoration(
            hintText: "Referral_code (Optional)",
            hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.normal),
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
          style: TextStyle(color: HexColor("#212529"), fontSize: 14.0, fontWeight: FontWeight.normal),
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
              // Navigator.push(context, MaterialPageRoute(builder: (context){
                // return ServiceProviderUploadImagePage(firstName: firstNameController.text, lastName: lastNameController.text,
                //     email: emailAddressController.text, phone1: mobile1Controller.text, phone2: mobile2Controller.text,
                //     stateOfResidence: statesController.text, city: cityController.text, serviceType: serviceTypeController.text,
                //     officeAddress: officeAddressController.text, subCategory: subcategoryController.text,
                //     openingHour: openingHourController.text, password: passwordController.text, referralCode: referralCodeController.text,);

              // }));
                // makePostRequest();
                // _customerSignUp();
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



      Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text("already have an account?", style: TextStyle(color: HexColor("#212529"), fontSize: 15.0),),
                  ),
                  InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return LogInPage();
                        }));
                      },
                      child: Text("Sign in", style: TextStyle(color: HexColor("#5E60CE"), fontSize: 15.0),),
                  ),
                ],
              ),
            ),
            ]
            ),
           ),
          ],
        ),
      ),
    );
  }

  //         state of residence

  String? states;

  Future<void> _openStateOfResidenceDialog() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand fully
      builder: (BuildContext context) {
        return StateOfResidenceDialog();
      },
    );

    // Handle the result from the bottom sheet
    if (result != null) {
      setState(() {
        states = result;
        updateStateTextValue();
        cityVisible = true;
        cityController.text = "";
      });
    }
    else {
      setState(() {
        cityVisible = false;
      });
    }
  }

  String? city;

  Future<void> _openCityDialog() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand fully
      builder: (BuildContext context) {
        return CityDialog();
      },
    );

    // Handle the result from the bottom sheet
    if (result != null) {
      setState(() {
        city = result;
        updateCityTextValue();
        officeAddressVisible = true;
      });
    }
    else{
      setState(() {
        officeAddressVisible = false;
      });
    }
  }

  String? serviceType;

  Future<void> _openServiceTypeDialog() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand fully
      builder: (BuildContext context) {
        return ServiceTypeDialog();
      },
    );

    // Handle the result from the bottom sheet
    if (result != null) {
      setState(() {
        serviceType = result;
        updateServiceTypeTextValue();
        subCategoryVisible = true;
        subcategoryController.text = "";
      });
    }
    else{
      setState(() {
        subCategoryVisible = false;
      });
    }
  }

  String? subCategory;

  Future<void> _openSubCategoryDialog() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand fully
      builder: (BuildContext context) {
        return SubCategoryDialog();
      },
    );

    // Handle the result from the bottom sheet
    if (result != null) {
      setState(() {
        subCategory = result;
        updateSubCategoryTextValue();
      });
    }
  }


    // opening hour
  String? openingHour;

  Future<void>  _openingHourDialog() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true, // Allows the bottom sheet to expand fully
      builder: (BuildContext context) {
        return StartTimeEndTimeDialog();
      },
    );

    // Handle the result from the bottom sheet
    if (result != null) {
      setState(() {
        openingHour = result;
        updateOpeningHourTextValue();
      });
    }
  }

}

