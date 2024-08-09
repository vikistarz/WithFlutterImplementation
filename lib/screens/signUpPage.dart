import 'package:cross_platform_application/screens/detailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


enum GenderTypeEnum { Male, Female}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  _SignUpPageState(){
    selectedValue = _ageGrade[1];
  }

  final _formKey = GlobalKey<FormState>();
var isLoading = false;

void submit(){
  final isValid = _formKey.currentState?.validate();
  if(!isValid!){
    return;
  }
  _formKey.currentState?.save();
}

  var _firstName, _password;
  bool passwordVisible =  false;
  bool isChecked = false;

  GenderTypeEnum? _genderTypeEnum;

  final _firstNameController = TextEditingController();
  final _passwordController = TextEditingController();

 final _ageGrade = ["Child", "Teenager", "Adult"];
 String? selectedValue = "";

  @override
  void initState() {
  super.initState();
    passwordVisible = true;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  } // void _updateText(){
  //   setState((){
  // _firstName = _firstNameController.text;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Container(
                child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
                child: TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      value  = _firstName;
                      return 'Field cannot be empty';
                    }
                    else{
                      return null;
                    }
                  },
                  controller: _firstNameController,
                  keyboardType:TextInputType.name,
                  decoration: InputDecoration(
                      hintText: "First name",
                      prefixIcon: Icon(Icons.person),
                      border: InputBorder.none
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
                child: TextFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      value  = _firstName;
                      return 'Field cannot be empty';
                    }
                    else{
                      return null;
                    }
                  },
                  controller: _passwordController,
                  obscureText: passwordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    // labelText: "Last name",
                      hintText: "password",
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                        onPressed: (){
                          setState(() {
                            passwordVisible = !passwordVisible;
                          },
                          );
                        },
                      ),

                      border: InputBorder.none
                  ),
                ),
              ),
          ],
        )

        ),
            ),



                Padding(
                  padding: const EdgeInsets.only(left: 13.0, right: 13.0, top: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100
                    ),
                    child: Row(

                      children: [

                        // CheckboxListTile(
                        //   title: Text("i agree to all the terms of contract"),
                        //     checkColor: Colors.black,
                        //     activeColor: Colors.grey,
                        //     value: isChecked, onChanged: (value){
                        //    setState(() {
                        //      isChecked = value!;
                        //    });
                        // },
                        // controlAffinity: ListTileControlAffinity.leading,)
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Checkbox(
                                           checkColor: Colors.black,
                                           activeColor: Colors.grey,
                              value: isChecked, onChanged: (value){
                            setState(() {
                              isChecked = value!;
                            });
                          }),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: const Text("I agree to the terms and conditions", style: TextStyle(color: Colors.black, fontSize: 13.0),),
                        )
                      ],
                    ),
                  ),
                ),

                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 13.0, top: 20.0),
                        child: RadioListTile(
                          title: Text(GenderTypeEnum.Male.name),
                            tileColor: Colors.grey.shade200,
                            value: GenderTypeEnum.Male,
                            dense: true,
                            groupValue: _genderTypeEnum,
                            onChanged: (value){
                              setState(() {
                                _genderTypeEnum = value;
                              });
                            }
                            ),
                      ),
                    ),

                SizedBox(width: 15.0,),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 13.0, top: 20.0),
                        child: RadioListTile(
                            title: Text(GenderTypeEnum.Female.name),
                            tileColor: Colors.grey.shade200,
                            dense: true,
                            value: GenderTypeEnum.Female,
                            groupValue: _genderTypeEnum,
                            onChanged: (value){
                              setState(() {
                                _genderTypeEnum = value;
                              });
                            }),
                      ),
                    ),

                  ],
                ),


                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DropdownButtonFormField( value: selectedValue,
                    items: _ageGrade.map((e){
                      return DropdownMenuItem(child: Text(e), value: e,);
                    }
                    ).toList(),
                    onChanged: (value){
                      setState(() {
                        selectedValue = value.toString();
                      });
                    },
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                        labelText: "Age arragement",
                        prefixIcon: Icon(Icons.family_restroom),
                        border: UnderlineInputBorder(),
                    ),
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
                  child: Center(
                    child: OutlinedButton(onPressed: () {

                      // submit();
                      if(_formKey.currentState!.validate()){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return DetailPage(firstName: _firstNameController.text, password: _passwordController.text);
                        })
                        );
                      }
                      // else{
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //         SnackBar(content: Text('Processing Data')),
                      //       );
                      // }
                    },
                    child: Text("Sign Up".toUpperCase()),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.blue, padding: EdgeInsets.all(10.0),
                        minimumSize: Size(400.0, 50.0),
                        // fixedSize: Size(300.0, 50.0),
                        textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
                        elevation: 12,

                        // side: BorderSide(color: Colors.black, width: 2),
                        // alignment: Alignment.topCenter
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100.0,
                )
              ],
            ),
        ),
    );
  }

}
