import 'package:cross_platform_application/dialogs/stateOfResidenceDialog.dart';
import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';
class CustomerHomeFragment extends StatelessWidget {
  const CustomerHomeFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                child: Text("How can we be of help today?",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.bold, fontSize:20.0,),),
              ),
            ),

            new GestureDetector(
              onTap: (){

              },
              child: Container(
                height: 40.0,
                margin: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: HexColor("#212529"), width: 1.0),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Icon(Icons.search, color: HexColor("#212529"), size: 20.0,),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("Search Category",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:11.0,),),
                    ),

                    Expanded(
                        child:SizedBox(

                        ),
                    ),

                       Container(
                       height: 27.0,
                       width: 27.0,
                       margin: EdgeInsets.only(right: 20.0),
                       decoration: BoxDecoration(
                         color: HexColor("#5E60CE"),
                         borderRadius: BorderRadius.all(Radius.circular(14.0)),
                       ),
                         child: Icon(Icons.search, color: Colors.white, size: 13.0,),
                     ),
                  ]
                ),
              ),
            ),
              Padding(
               padding: const EdgeInsets.only(top:25, left: 20.0),
               child: Text("Browse by Category",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.bold, fontSize:11.0,),),
             ),

            // first box
            Row(
              children: [
                Expanded(
                  child:new GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      height: 105.0,
                      margin: EdgeInsets.only(top: 10.0, left: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                      ),
                       child: Center(
                         child: Column(
                           children: [
                             Container(
                               margin: EdgeInsets.only(top: 10.0),
                               height: 60.0,
                               width: 60.0,
                               decoration: BoxDecoration(
                                 image: DecorationImage(image: AssetImage("images/fashion.png",),),
                               ),
                             ),
                             Padding(
                               padding: const EdgeInsets.only(top:0.0),
                               child: Text("Fashion",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                             ),
                           ],
                         ),
                       ),
                    ),
                  ),
                ),
               SizedBox(
                 width: 15.0,
               ),

                Expanded(
                  child:new GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      height: 105.0,
                      margin: EdgeInsets.only(top: 10.0, right: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage("images/automobile.png",),),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:0.0),
                              child: Text("Automobile",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          SizedBox(
            height: 15.0,
          ),

          //   second box
            Row(
              children: [
                Expanded(
                  child:new GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      height: 105.0,
                      margin: EdgeInsets.only(top: 10.0, left: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage("images/beautician.png",),),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:0.0),
                              child: Text("Beautician",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 15.0,
                ),

                Expanded(
                  child:new GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      height: 105.0,
                      margin: EdgeInsets.only(top: 10.0, right: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage("images/catering.png",),),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:0.0),
                              child: Text("Catering",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              height: 15.0,
            ),

            //   third box

            Row(
              children: [
                Expanded(
                  child:new GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      height: 105.0,
                      margin: EdgeInsets.only(top: 10.0, left: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage("images/plumbing.png",),),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:0.0),
                              child: Text("Plumbing",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 15.0,
                ),

                Expanded(
                  child:new GestureDetector(
                    onTap: (){

                    },
                    child: Container(
                      height: 105.0,
                      margin: EdgeInsets.only(top: 10.0, right: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10.0),
                              height: 60.0,
                              width: 60.0,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage("images/cleaning.png",),),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:0.0),
                              child: Text("Cleaning/Laundry",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20.0, bottom: 10.0),
                child: ElevatedButton(onPressed: () {

                },
                  child: Text("View All", style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.normal),),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: HexColor("#212529"), padding: EdgeInsets.all(10.0),
                    minimumSize: Size(80.0, 40.0),
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

          ],
        ),
      ),
    );
  }
}
