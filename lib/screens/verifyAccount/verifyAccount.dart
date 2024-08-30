
import 'dart:io';
import'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';


class VerifyAccountPage extends StatefulWidget {
  const VerifyAccountPage({super.key});

  @override
  State<VerifyAccountPage> createState() => _VerifyAccountPageState();
}

class _VerifyAccountPageState extends State<VerifyAccountPage> {

  bool isImageVisible = true;
  bool isPdfVisible = true;

  void image(){
    isImageVisible = false;
    isPdfVisible =  true;
  }

  void pdf(){
    isImageVisible = true;
    isPdfVisible =  false;
  }

  File? _image, _filePath;

  Future<void> getPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _filePath = File(result.files.single.path!);
      });
    }
  }



  Future getImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if( image == null) return;

    final imageTemporary = File(image.path);

    setState(() {
      this._image = imageTemporary;
    });
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
            width: 50.0,
            height: 40.0,
            child: Image(image: AssetImage("images/arrow_back.png"),),
          ),
        ),
      ),
    body: SingleChildScrollView(
    scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top:50.0),
              child: Text("Verify Account", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: HexColor("#5E60CE"),),),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top:14.0),
              child: Text("CAC Document or A picture of you on a job or", style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: HexColor("#787878"),),),
            ),
          ),

          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top:0.0),
              child: Text("Take a selfie with our field staff", style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: HexColor("#787878"),),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Center(
              child: ElevatedButton(onPressed: () {
                showImageOptions(context);
              },
                child: Text("Upload", style: TextStyle(fontSize: 14.0),),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white, padding: EdgeInsets.all(10.0),
                  minimumSize: Size(195.0, 45.0),
                  textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0)),
                  ),
                  side: BorderSide(color: Colors.black, width: 1.5),
                  // alignment: Alignment.topCenter
                ),
              ),
            ),
          ),

        Visibility(
          visible: !isImageVisible,
          child: Align(
            alignment: Alignment.center,
            child:  _image == null
                ? Text('')
                : Container(
              height: 200.0,
              width: 300.0,
              margin: EdgeInsets.only(top: 30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                border: Border.all(color: HexColor("#DEE1E7"), width: 2.0),
                image: DecorationImage(
                  image: FileImage(_image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
                ),
        ),


          Visibility(
            visible: !isPdfVisible,
            child: Align(
              alignment: Alignment.center,
              child:  _filePath != null
                  ? Container(
                height: 200.0,
                width: 300.0,
                margin: EdgeInsets.only(top: 30.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  border: Border.all(color: HexColor("#DEE1E7"), width: 2.0),
                ),
                child: PDFView(
                  filePath: _filePath!.path
                ),
              )
                  : Text(''),
            ),
          ),
        ],
       ),
      ),
    );
  }
  void showImageOptions(BuildContext context){
    showModalBottomSheet(context: context, builder: (builder){
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 320.0,
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
                    padding: const EdgeInsets.only(top: 40.0, right: 20.0),
                    child: Image(image: AssetImage("images/cancel_circle.png"),width: 25.0, height: 25.0,)
                ),
              ),
            ),

            Container(
              height: 190.0,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: HexColor("#DEE1E7"),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              child: Column(
                children: [

                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    getImage(ImageSource.gallery);
                    image();
                     },
                    child: Container(
                      height: 90.0,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 30.0),
                            child: Text("Choose Photo", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black,),),
                          ),

                          Expanded(
                            child: SizedBox(),
                          ),

                          Padding(
                              padding: const EdgeInsets.only(top: 25.0, right: 30.0, bottom: 20.0),
                              child: Image(image: AssetImage("images/camera.png"),width: 35.0, height: 35.0,)
                          ),
                        ],
                      ),
                    ),
                  ),


                  Container(
                    height: 2.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      getPdfFile();
                      pdf();
                    },
                    child: Container(
                      height: 90.0,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 30.0),
                            child: Text("Select CAC document", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black,),),
                          ),

                          Expanded(
                            child: SizedBox(),
                          ),

                          Padding(
                              padding: const EdgeInsets.only(top: 25.0, right: 30.0, bottom: 20.0),
                              child: Image(image: AssetImage("images/choose_image.png"),width: 35.0, height: 35.0,)
                          ),
                        ],
                      ),
                    ),
                  ),

                ]
               ),
              ),
          ],
        ),
      );
    });
  }
}
