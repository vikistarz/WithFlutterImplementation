import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:text_marquee/text_marquee.dart';
import '../scheduleAppointment/scheduleAppointment.dart';
import 'fragments/aboutFragment.dart';
import 'fragments/photoFragment.dart';
import 'fragments/reviewFragment.dart';


class ServiceProviderDetailsPage extends StatefulWidget {
  ServiceProviderDetailsPage({Key? key, required this.firstName, required this.lastName,
    required this.email, required this.phone, required this.id, required this.stateOfResidence,
    required this.city, required this.serviceType, required this.officeAddress, required this.subCategory,
    required this.openingHour, required this.verified, required this.imagePath, required this.skills,
    required this.about}) : super(key: key);

  String firstName, lastName, email, phone, stateOfResidence, about, skills,
      city, serviceType, officeAddress, subCategory, openingHour,verified, imagePath;

    int id;

  @override
  State<ServiceProviderDetailsPage> createState() => _ServiceProviderDetailsPageState();
}

class _ServiceProviderDetailsPageState extends State<ServiceProviderDetailsPage> {

  bool isVisible =  true;
  bool isPhotoVisible = true;
  bool isReviewVisible = true;

 void photo(){
   isPhotoVisible = false;
    isVisible =  false;
    isReviewVisible =  true;
 }

  void review(){
    isPhotoVisible = true;
    isVisible =  false;
    isReviewVisible =  false;
  }

  void about(){
    isPhotoVisible = true;
    isVisible =  true;
    isReviewVisible =  true;
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
            width: 16.0,
            height: 18.0,
            child: Image(image: AssetImage("images/arrow_back.png"),),
          ),
        ),
        title: Text("Service Provider Profile", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: HexColor("#212529"),),),
        centerTitle: true,
      ),
     body: SingleChildScrollView(
       scrollDirection: Axis.vertical,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
             children: [
               Container(
                 width: 70.0,
                 height: 70.0,

                 margin: EdgeInsets.only(left: 40.0, top: 30.0),
                 child: CircleAvatar(
                   backgroundColor: HexColor("#E4DFDF"),
                   radius: 40.0,
                   child:  CircleAvatar(
                     backgroundColor: HexColor("#E4DFDF"),
                     radius: 35.0,
                     backgroundImage:  NetworkImage("https://server.handiwork.com.ng/"+widget.imagePath),
                     ),
                     ) ,
                   ),



               Stack(
                 children: [

                   Padding(
                     padding: const EdgeInsets.only(top:12.0, bottom: 30.0, right: 3.0),
                     child: Image(image: AssetImage("images/verify_icon.png"),width: 24.0, height: 24.0,),
                   ),

                   // recomended
                   Container(
                    height: 18.0,
                     width: 80.0,
                     margin: EdgeInsets.only(top:20.0,left:25.0,bottom: 30.0),
                     decoration: BoxDecoration(
                       color: HexColor("#BFE4F9"),
                       borderRadius: BorderRadius.all(Radius.circular(5.0)),
                     ),
                     child: Center(child: Text("Recomended", style: TextStyle(color: HexColor("#353535"),fontSize: 8.0, fontWeight: FontWeight.bold),)),
                   ),

                   // not verified
                   Container(
                     height: 18.0,
                     width: 80.0,
                     margin: EdgeInsets.only(top:20.0,left:25.0,bottom: 30.0),
                     decoration: BoxDecoration(
                       color: HexColor("#F1B5B5"),
                       borderRadius: BorderRadius.all(Radius.circular(5.0)),
                     ),
                     child: Center(child: Text("Not Verified", style: TextStyle(color: HexColor("#353535"),fontSize: 8.0, fontWeight: FontWeight.bold),)),
                   ),

                   Row(
                     children: [
                       Container(
                         margin: EdgeInsets.only(top: 40.0, left: 5.0),
                       width: 90.0,
                         child:
                         TextMarquee(widget.firstName, spaceSize: 100, style: TextStyle(color: HexColor("#353535"),fontSize: 18.0, fontWeight: FontWeight.normal),),
                       ),

                       Container(
                         margin: EdgeInsets.only(top:40.0, left: 8.0),
                         width: 2.0,
                         height: 20.0,
                         color: Colors.black,
                       ),

                       Padding(
                         padding: const EdgeInsets.only(top: 40.0, left: 8.0, right: 8.0),
                         child: Text(widget.subCategory, style: TextStyle(color: HexColor("#5E60CE"),fontSize: 11.0, fontWeight: FontWeight.normal),),
                       ),
                     ],
                   ),

                   Padding(
                     padding: const EdgeInsets.only(left: 10.0, top: 65.0, right: 16.0),
                     child: Row(
                       children: [
                         Image(image: AssetImage("images/location_icon.png"),width: 11.0, height: 11.0,),
                         Text(widget.city, style: TextStyle(color: HexColor("#353535"),fontSize: 10.0, fontWeight: FontWeight.normal),),

                       ],
                     ),
                   )
                 ],
               ),
             ],
            ),

            Container(
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: 25.0, right: 20.0, left: 20.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  boxShadow: [
                    BoxShadow(
                      color: HexColor("#C3BDBD"),
                      blurRadius: 0.5,
                      spreadRadius: 0.5,
                      offset: Offset(0.5,0.5),
                    ),
                  ]
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                     Padding(
                       padding: const EdgeInsets.only(top: 10.0),
                       child: Text("Opening Hour", style: TextStyle(color: HexColor("#5E60CE"),fontSize: 13.0, fontWeight: FontWeight.normal),),
                     ),
                    
                     Padding(
                       padding: const EdgeInsets.only(top: 3.0),
                       child: Text(widget.openingHour, style: TextStyle(color: HexColor("#353535"),fontSize: 13.0, fontWeight: FontWeight.bold),),
                     ),
                      ],
                    ),
                  ),

                  Container(
                    width: 1.0,
                    height: 50.0,
                    color: HexColor("#888888"),
                  ),
                  
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                     padding: const EdgeInsets.only(top: 10.0),
                     child: Text("Customer Ratings", style: TextStyle(color: HexColor("#5E60CE"),fontSize: 13.0, fontWeight: FontWeight.normal),),
                        ),
                        Padding(
                     padding: const EdgeInsets.only(top: 3.0),
                     child: Text("4.0/5", style: TextStyle(color: HexColor("#FFC107"),fontSize: 13.0, fontWeight: FontWeight.bold),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
              child: Center(
                child: ElevatedButton(onPressed: () {
                  showImageOptions(context);
                },
                  child: Text("Book Service", style: TextStyle(fontSize: 14.0),),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: HexColor("#5E60CE"), padding: EdgeInsets.all(10.0),
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
                    // side: BorderSide(color: Colors.black, width: 2),
                    // alignment: Alignment.topCenter
                  ),
                ),
              ),
            ),

      Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          border: Border.all(color: HexColor("#212529"), width: 0.30),
        ),
        child: Row(
          children: [
            Container(
              height: 35.0,
              width: 70.0,
              margin: EdgeInsets.only(left: 20.0),
              child: Stack(
                children: [
                  new GestureDetector(
                    onTap: (){
                      setState(() {
                        about();
                      });
                    },
                    child: Center(
                      child: Text("About", style: TextStyle(color: HexColor("#212529"), fontSize: 11.0),),
                    ),
                  ),

                  Visibility(
                    visible: isVisible,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(),
                      child: Image(image: AssetImage("images/pink_background.png"),),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
                child: SizedBox()
            ),

            Container(
              height: 35.0,
              width: 70.0,
              child: Stack(
                children: [
                  new GestureDetector(
                    onTap: (){
                      setState(() {
                        photo();
                      });
                    },
                    child: Center(
                      child: Text("Photos", style: TextStyle(color: HexColor("#212529"), fontSize: 11.0),),
                    ),
                  ),

                  Visibility(
                    visible: !isPhotoVisible,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(),
                      child: Image(image: AssetImage("images/pink_background.png"),),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
                child: SizedBox()
            ),

            Container(
              height: 35.0,
              width: 70.0,
              margin: EdgeInsets.only(right: 20.0),
              child: Stack(
                children: [
                  new GestureDetector(
                    onTap: (){
                      setState(() {
                        review();
                      });
                    },
                    child: Center(
                      child: Text("Reviews", style: TextStyle(color: HexColor("#212529"), fontSize: 11.0),),
                    ),
                  ),

                  Visibility(
                    visible: !isReviewVisible,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(),
                      child: Image(image: AssetImage("images/pink_background.png"),),
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),

      SizedBox(
        height: 15.0,
      ),

      Container(
        margin: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 50.0),
        child: Stack(
          children: [
            Visibility(
              visible:  isVisible,
              child: AboutFragment(),
            ),

            Visibility(
              visible:  !isPhotoVisible,
              child: PhotoFragment(),
            ),

            Visibility(
              visible:  !isReviewVisible,
              child: ReviewFragment(),
            ),
          ],
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
        height: 200.0,
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
                    padding: const EdgeInsets.only(top: 30.0, right: 20.0),
                    child: Image(image: AssetImage("images/cancel_circle.png"),width: 20.0, height: 20.0,)
                ),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15.0, left: 30.0),
                      child: ElevatedButton(onPressed: () {
                        Navigator.pop(context);
                  
                      },
                        child: Text("Instant call", style: TextStyle(fontSize: 11.0),),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: HexColor("#5E60CE"), padding: EdgeInsets.all(10.0),
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
                          // side: BorderSide(color: Colors.black, width: 2),
                          // alignment: Alignment.topCenter
                        ),
                      ),
                    ),
                  ),


                Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 15.0, right: 30.0),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle button press
                    },
                    child: Image(image: AssetImage("images/whatsapp_white.png"),width: 18.0, height: 18.0,),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor("#212529"), padding: EdgeInsets.all(9.0),
                      minimumSize: Size(50.0, 40.0),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                            bottomLeft: Radius.circular(15.0)),
                      ),
                    ),
                  ),
                )


              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 30.0, right: 30.0, bottom: 25.0),
              child: Center(
                child: ElevatedButton(onPressed: () {
                 Navigator.push(context, MaterialPageRoute(builder: (context){
                   return ScheduleAppointmentPage();
                 }));

                },
                  child: Text("Schedule Appointment", style: TextStyle(fontSize: 11.0),),
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

