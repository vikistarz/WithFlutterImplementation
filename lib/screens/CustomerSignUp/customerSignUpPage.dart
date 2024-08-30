import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../database/appPrefHelper.dart';
import '../../database/saveValues.dart';
import '../logIn/ui/logIn.dart';
class CustomerSignUpPage extends StatefulWidget {
  const CustomerSignUpPage({super.key});

  @override
  State<CustomerSignUpPage> createState() => _CustomerSignUpPageState();
}

class _CustomerSignUpPageState extends State<CustomerSignUpPage> {

  var firstName, lastName, emailAddress, homeAddress, password, confirmPassword;
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible =  false;
  bool confirmPasswordVisible =  false;
  bool _isButtonEnabled = false;
  bool isLoadingVisible = true;

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

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController homeAddressController = TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   passwordVisible = true;
  //   confirmPasswordVisible =  true;
  //   // saveGetUserDetails();
  // }

  void loading(){
    setState(() {
      isLoadingVisible = false;
    });
  }


  // void saveGetUserDetails() async {
  //
  //   SaveValues mySaveValues = SaveValues();
  //   await mySaveValues.saveString(AppPreferenceHelper.FIRST_NAME, firstNameController.text);
  //   await mySaveValues.saveString(AppPreferenceHelper.LAST_NAME, lastNameController.text);
  //   await mySaveValues.saveString(AppPreferenceHelper.EMAIL_ADDRESS, emailAddressController.text);
  //
  //   String? firstNameValue = await mySaveValues.getString(AppPreferenceHelper.FIRST_NAME);
  //   String? lastNameValue = await mySaveValues.getString(AppPreferenceHelper.LAST_NAME);
  //   String? emailValue = await mySaveValues.getString(AppPreferenceHelper.EMAIL_ADDRESS);
  //
  //   setState(() {
  //     firstName = firstNameValue;
  //     lastNameController.text = lastNameValue!;
  //     emailAddressController.text = emailValue!;
  //   });
  //
  // }

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
        title: Text("Get Started as a Customer", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: HexColor("#212529"),),),
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
                  value  = firstName;
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
                  value  = lastName;
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
                  value  = emailAddress;
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
                  value  = emailAddress;
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
              controller: phoneController,
              keyboardType:TextInputType.phone,
              maxLength: 11,
              decoration: InputDecoration(
                hintText: "Phone",
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
                if (value == null || value.isEmpty) {
                  value = homeAddress;
                  return 'Please enter Home Address';
                }
                else{
                  return null; // Return null if the input is valid
                }
              },
              controller: homeAddressController,
              keyboardType:TextInputType.text,
              decoration: InputDecoration(
                  hintText: "Home Address",
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
                if (value == null || value.isEmpty) {
                  value  = password;
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
                  value  = confirmPassword;
                  return 'Please enter password';
                }
                if (value.length < 6) {
                  return 'must be at least 6 characters long';
                }
                if (value != passwordController.text) {
                  return 'Passwords do not match';
                }
                // if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                //     return 'Please enter a valid email';
                //         }
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
       ]
      ),
    ),

            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
              child: Center(
                child: ElevatedButton(onPressed: _isButtonEnabled
                    ? () {

                  }
                     : null, // Disable button if form is invalid() {
                  child: Text("Continue", style: TextStyle(fontSize: 18.0),),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: HexColor("#5E60CE"), padding: EdgeInsets.all(10.0),
                    minimumSize: Size(MediaQuery.of(context).size.width, 50.0),
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
            )
          ],
        ),
      ),
    );
  }
}
