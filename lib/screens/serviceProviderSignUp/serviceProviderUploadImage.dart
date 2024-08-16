import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../logIn/logIn.dart';

class ServiceProviderUploadImagePage extends StatefulWidget {
  const ServiceProviderUploadImagePage({super.key});

  @override
  State<ServiceProviderUploadImagePage> createState() => _ServiceProviderUploadImagePageState();
}

class _ServiceProviderUploadImagePageState extends State<ServiceProviderUploadImagePage> {

  bool uploadButtonVisible = false;


     File? _image;

     Future getImage(ImageSource source) async {
       final image = await ImagePicker().pickImage(source: source);
       
       if( image == null) return;
         
         final imageTemporary = File(image.path);

         setState(() {
           this._image = imageTemporary;
         });
     }

     void showButton(){
       uploadButtonVisible = true;
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

                    // _image != null?
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

                   Visibility(
                     visible: uploadButtonVisible,
                     child: Padding(
                       padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
                       child: Center(
                         child: ElevatedButton(onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context){
                             return LogInPage();
                           }));
                         },
                           child: Text("Upload to Sign up", style: TextStyle(fontSize: 14.0),),
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

            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 16.0, right: 16.0),
              child: Center(
                child: ElevatedButton(onPressed: () {
                  Navigator.pop(context);
                  getImage(ImageSource.camera);
                  showButton();
                },
                  child: Text("Take a Picture", style: TextStyle(fontSize: 14.0),),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: HexColor("#5E60CE"), padding: EdgeInsets.all(10.0),
                    minimumSize: Size(200.0, 35.0),
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
              padding: const EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
              child: Center(
                child: ElevatedButton(onPressed: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                  showButton();
                },
                  child: Text("Upload a Picture", style: TextStyle(fontSize: 14.0),),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: HexColor("#5E60CE"), padding: EdgeInsets.all(10.0),
                    minimumSize: Size(200.0, 35.0),
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


