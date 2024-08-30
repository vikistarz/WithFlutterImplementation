import 'package:cross_platform_application/screens/serviceProviderDashBoard/serviceProviderProfile.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../dialogs/logOutDialog.dart';
class ServiceProviderAccountFragment extends StatefulWidget {
  const ServiceProviderAccountFragment({super.key});

  @override
  State<ServiceProviderAccountFragment> createState() => _ServiceProviderAccountFragmentState();
}

class _ServiceProviderAccountFragmentState extends State<ServiceProviderAccountFragment> {

  void _openLogOutDialog(){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context, builder: (ctx) => LogOutDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#f4f4f4"),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:15.0, left: 20.0),
              child: Text("Profile",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.bold, fontSize:16.0,),),
            ),
      Container(
        height: 230.0,
        margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          border: Border.all(color: HexColor("#212529"), width: 1.0),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 65.0,
                margin: EdgeInsets.only(top: 30.0, right: 20.0, left: 20.0),
                decoration: BoxDecoration(
                    color: HexColor("#5E60CE"),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor("#C3BDBD"),
                        blurRadius: 0.0,
                        spreadRadius: 0,
                        offset: Offset(0,0),
                      )
                    ]
                ),
                child:  Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text("Emiewo Victor",style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize:15.0,),),
                      ),
                      Text("Baking",style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize:13.0,),),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom:25.0, left: 45.0),
                child: CircleAvatar(
                  backgroundColor:Colors.white,
                  radius: 30.0,
                  child:  CircleAvatar(
                    backgroundColor: HexColor("#E4DFDF"),
                    backgroundImage: AssetImage("images/profile_white.png"),
                    radius: 29.0,
                  ),
                ),
              ),
            ),

            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return ServiceProviderProfilePage();
                }));
              },
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 40.0,
                  width: 150.0,
                  margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0, bottom: 45.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child:SizedBox(

                          ),
                      ),
                      Text("View Profile",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                      Container(
                          width: 25.0,
                          height: 25.0,
                          margin: EdgeInsets.only(left: 5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(13.0),),
                            border: Border.all(color: HexColor("#5E60CE"), width: 1.0),
                          ),
                          child:    Icon(Icons.person_outline,color: HexColor("#5E60CE"),size: 20.0,)
                      ),
                      Expanded(
                          child:SizedBox(

                          )
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20.0, bottom: 15.0),
                    child: Image(image: AssetImage("images/location_image.png"), width: 15.0, height: 15.0,),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 5.0, right: 20.0, bottom: 15.0),
                    child:Text("5, Tunji Tope Hill, abule Egba, Lagos",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.bold, fontSize:11.0,),),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),

            InkWell(
              onTap: (){

              },
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    height: 55.0,
                    margin: EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        boxShadow: [
                          BoxShadow(
                            color: HexColor("#C3BDBD"),
                            blurRadius: 1.0,
                            spreadRadius: 1,
                            offset: Offset(1,1),
                          )
                        ]
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20.0),
                            child: Image(image: AssetImage("images/wallet.png"), width: 20.0, height: 20.0,),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 10.0, right: 20.0),
                            child:Text("Wallet",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                          ),
                        ],
                      ),
                    )
                ),
              ),
            ),

            InkWell(
              onTap: (){

              },
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    height: 55.0,
                    margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        boxShadow: [
                          BoxShadow(
                            color: HexColor("#C3BDBD"),
                            blurRadius: 1.0,
                            spreadRadius: 1,
                            offset: Offset(1,1),
                          )
                        ]
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20.0),
                            child: Image(image: AssetImage("images/add_bank_account.png"), width: 20.0, height: 20.0,),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 10.0, right: 20.0),
                            child:Text("Add Bank Account",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                          ),

                        ],
                      ),
                    )
                ),
              ),
            ),


            new GestureDetector(
              onTap: (){
                   _openLogOutDialog();
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                    height: 55.0,
                    margin: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0, bottom: 50.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        boxShadow: [
                          BoxShadow(
                            color: HexColor("#C3BDBD"),
                            blurRadius: 1.0,
                            spreadRadius: 1,
                            offset: Offset(1,1),
                          )
                        ]
                    ),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 20.0),
                            child: Image(image: AssetImage("images/logout_square.png"), width: 20.0, height: 20.0,),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(top: 20, left: 10.0, right: 20.0),
                            child:Text("Log Out",style: TextStyle(color: HexColor("#212529"), fontWeight: FontWeight.normal, fontSize:14.0,),),
                          ),

                        ],
                      ),
                    )
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
