import 'dart:convert';
import 'dart:io';
import 'package:cross_platform_application/webService/apiConstant.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import '../../../database/appPrefHelper.dart';
import '../../../database/saveValues.dart';
import '../../../dialogs/errorMessageDialog.dart';
import '../../../dialogs/successMessageDialog.dart';
import '../../logIn/ui/logIn.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
// import'package:path/path.dart';
import 'package:async/async.dart';




class ServiceProviderUploadImagePage extends StatefulWidget {
  ServiceProviderUploadImagePage({Key? key, required this.firstName, required this.lastName,
    required this.email, required this.phone1, required this.phone2, required this.stateOfResidence,
    required this.city, required this.serviceType, required this.officeAddress, required this.subCategory,
    required this.openingHour, required this.password, required this.referralCode}) : super(key: key);

  String firstName, lastName, email, phone1, phone2, stateOfResidence,
      city, serviceType, officeAddress, subCategory, openingHour,password, referralCode;

  @override
  State<ServiceProviderUploadImagePage> createState() => _ServiceProviderUploadImagePageState();
}

class _ServiceProviderUploadImagePageState extends State<ServiceProviderUploadImagePage> {

  Dio dio = new Dio();

  bool uploadButtonVisible = false;
  bool isLoadingVisible = true;
  String? token;
  String? errorMessage;
  int serviceProviderWalletId = 0;


  void showUploadButton() {
    setState(() {
      uploadButtonVisible = true;
    });
  }

  void loading() {
    setState(() {
      isLoadingVisible = false;
    });
  }

  void isNotLoading() {
    setState(() {
      isLoadingVisible = true;
    });
  }

  void showButton() {
    uploadButtonVisible = true;
  }


  final String apiUrl = "https://server.handiwork.com.ng/api/skill-providers/create";


  File? _image;
  Map<String, dynamic>? responseData;

  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source, imageQuality: 100);

    if (image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      _image = imageTemporary;
    });
  }




  Future<void> makePostRequest() async {
    loading();

    final String apiUrl = ApiConstant.serviceProviderLogInApi;
    try{

    if(_image == null) return;

      final uri = Uri.parse(apiUrl);
      var request = http.MultipartRequest('POST', uri);

      request.fields['firstName'] = widget.firstName.toString();
      request.fields['lastName'] = widget.lastName.toString();
      request.fields['email'] = widget.email.toString();
      request.fields['password'] = widget.password.toString();
      request.fields['phone'] = widget.phone1.toString();
      request.fields['secondPhone'] = widget.phone2.toString();
      request.fields['stateOfResidence'] = widget.stateOfResidence.toString();
      request.fields['city'] = widget.city.toString();
      request.fields['street'] = widget.officeAddress.toString();
      request.fields['serviceType'] = widget.serviceType.toString();
      request.fields['subCategory'] = widget.subCategory.toString();
      request.fields['openingHour'] = widget.openingHour.toString();
      request.fields['referralCode'] = widget.referralCode.toString();

      File _file = File(_image!.path);


    request.files.add(await http.MultipartFile.fromPath('image', _file.path,
        contentType: MediaType('image', "png")));

    print("request: " + request.toString());
    var response = await request.send();
    print(response.statusCode);



      if(response.statusCode == 201){
        isNotLoading();
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        print('Response Body: ${responseString}');
        var jsonResponse = json.decode(responseString);
        final Map<String, dynamic> data = jsonResponse;
        token = data['skillProvider']['token'];
        serviceProviderWalletId = data['wallet']['id'];
        print(serviceProviderWalletId);

        setState(() {
          showModalBottomSheet(
              isDismissible: false,
              enableDrag: false,
              context: context,
              builder: (BuildContext context) {
                return SuccessMessageDialog(
                  content: 'Service Provider Sign up Successful',
                  onButtonPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return LogInPage();
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
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        print('Response Body: ${responseString}');
        var jsonResponse = json.decode(responseString);
        final Map<String, dynamic> errorData = jsonResponse;
        errorMessage = errorData['error'] ?? 'Unknown error occurred';
        print(errorMessage);
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
                    isNotLoading();
                  },
                );
              });
        });
        }
    }
    catch(e){
      print('Exception during image upload: $e');
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


  void saveUserDetails() async {

    SaveValues mySaveValues = SaveValues();

    await mySaveValues.saveInt(AppPreferenceHelper.SERVICE_PROVIDER_WALLET_ID, serviceProviderWalletId!);

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
        title: Text("Upload Photo", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: HexColor("#212529"),),),
        centerTitle: true,
      ),
      body: Stack(
        children: [

          Container(
            margin: EdgeInsets.only(top: 100),
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: HexColor("#F6F6F6"),
              borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0) )
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 50),
            child: Row(
              children: [
                Expanded(child: SizedBox()),

                Stack(
                  children: [
                    Container(
                      width: 120.0,
                      height: 120.0,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 60.0,
                        child:  CircleAvatar(
                        backgroundColor: HexColor("#E4DFDF"),
                        radius: 55.0,
                        backgroundImage: _image == null ? null : FileImage(
                          File(_image!.path)
                        ),

                       child: _image == null ? Image(image: AssetImage("images/profile_white.png"),
                       ) : null,
                      ),
                    ),
                    ),

                    InkWell(
                      onTap: () {
                      showImageOptions(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 75, left: 95.0),
                        height: 35.0,
                        width: 35.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(17.0)),
                          color: HexColor("#5E60CE"),
                        ),
                        child: Icon(Icons.camera_alt_sharp, size: 25.0, color: Colors.white,)
                      ),
                    )
                  ],
                ),

                Expanded(child: SizedBox()),
              ],
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 210),
             child: Align(
               alignment: Alignment.topCenter,
               child: Column(
                 children: [
                   Text("Please upload your profile picture to personalize your account and", style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: HexColor("#626262"),),),
                   Text("help others recognize you. Choose an image that reflects your", style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: HexColor("#626262"),),),
                   Text("personality or interests.", style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: HexColor("#626262"),),),

                   Padding(
                     padding: const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
                     child: Center(
                       child: ElevatedButton(onPressed: () {
                         showImageOptions(context);
                       },
                         child: Text("Add Photo", style: TextStyle(fontSize: 14.0),),
                         style: ElevatedButton.styleFrom(
                           foregroundColor: Colors.white, backgroundColor: HexColor("#5E60CE"), padding: EdgeInsets.all(10.0),
                           minimumSize: Size(200.0, 40.0),
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

                   Stack(
                     children: [

                       Visibility(
                         visible: uploadButtonVisible,
                         child: Padding(
                           padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
                           child: Center(
                             child: ElevatedButton(onPressed: () async {
                              // registerServiceProvider();
                               makePostRequest();
                               // registerEmployeeFace();
                             },
                               child: Text("Upload to Sign up", style: TextStyle(fontSize: 14.0),),
                               style: ElevatedButton.styleFrom(
                                 foregroundColor: Colors.white, backgroundColor: HexColor("#5E60CE"), padding: EdgeInsets.all(10.0),
                                 minimumSize: Size(200.0, 40.0),
                                 // fixedSize: Size(300.0, 50.0),
                                 textStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                                 elevation: 2,
                                 shape: RoundedRectangleBorder(
                                   borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                   // borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),
                                   //     topRight: Radius.circular(15.0),
                                   //     bottomRight: Radius.circular(15.0),
                                   //     bottomLeft: Radius.circular(15.0)),
                                 ),
                                 // side: BorderSide(color: Colors.black, width: 2),
                                 // alignment: Alignment.topCenter
                               ),
                             ),
                           ),
                         ),
                       ),

                       Visibility(
                         visible: !isLoadingVisible,
                         child: Center(
                           child: Container(
                             height: 40.0,
                             width: 200.0,
                             margin: EdgeInsets.only(top: 24.0, left: 16.0, right: 16.0),
                             decoration: BoxDecoration(
                               color: HexColor("#A7A8DC"),
                               borderRadius: BorderRadius.all(Radius.circular(15.0)),
                             ),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [

                                 SpinKitFadingCircle(
                                   color: HexColor("#F5F6F6"),
                                   size: 16.0,
                                 ),

                                 Padding(
                                   padding: const EdgeInsets.only(left: 10.0),
                                   child: Text("Loading",style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize:11.0,),),
                                 ),
                               ],
                             ),
                           ),
                         ),
                       ),

                     ],
                   ),

                 ]
               ),
             ),
          ),

        ],
      ),
    );
  }

  void showImageOptions(BuildContext context){
    showModalBottomSheet(context: context, builder: (builder){
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 250.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                    padding: const EdgeInsets.only(top: 30.0, right: 40.0),
                    child: Image(image: AssetImage("images/remove_icon.png"),width: 20.0, height: 20.0,)
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(top: 30.0, left: 16.0, right: 16.0),
            //   child: Center(
            //     child: ElevatedButton(onPressed: () {
            //       getImage(ImageSource.camera);
            //       Navigator.pop(context);
            //       setState(() {
            //         showUploadButton();
            //       });
            //
            //     },
            //       child: Text("Take a Picture", style: TextStyle(fontSize: 14.0),),
            //       style: ElevatedButton.styleFrom(
            //         foregroundColor: Colors.white, backgroundColor: HexColor("#5E60CE"), padding: EdgeInsets.all(10.0),
            //         minimumSize: Size(200.0, 40.0),
            //         // fixedSize: Size(300.0, 50.0),
            //         textStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
            //         elevation: 2,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),
            //               topRight: Radius.circular(15.0),
            //               bottomRight: Radius.circular(15.0),
            //               bottomLeft: Radius.circular(15.0)),
            //         ),
            //         // side: BorderSide(color: Colors.black, width: 2),
            //         // alignment: Alignment.topCenter
            //       ),
            //     ),
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0, bottom: 20.0),
              child: Center(
                child: ElevatedButton(onPressed: () {
                  getImage(ImageSource.gallery);
                   Navigator.pop(context);
                   setState(() {
                     showUploadButton();
                   });
                },
                  child: Text("Upload a Picture", style: TextStyle(fontSize: 14.0),),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: HexColor("#5E60CE"), padding: EdgeInsets.all(10.0),
                    minimumSize: Size(200.0, 40.0),
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
      );
    });
  }
}


