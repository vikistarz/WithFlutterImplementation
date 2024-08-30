import'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../database/appPrefHelper.dart';
import '../../database/saveValues.dart';
import '../../dialogs/logOutDialog.dart';
import '../support/support.dart';
import 'fragment/customerAccountFragment.dart';
import 'fragment/customerAnnouncementFragment.dart';
import 'fragment/customerHomeFragment.dart';

class CustomerDashboardPage extends StatefulWidget {
  const CustomerDashboardPage({super.key});

  @override
  State<CustomerDashboardPage> createState() => _CustomerDashboardPageState();
}

class _CustomerDashboardPageState extends State<CustomerDashboardPage> {

  int pageIndex = 0;

  final pages = [
   const CustomerHomeFragment(),
    const CustomerAnnouncementFragment(),
    const CustomerAccountFragment(),
  ];



    @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 60.0,
      ),
      drawer: SafeArea(
       child:Drawer(
        backgroundColor: Colors.white,
        shape: LinearBorder.start(),
    child: ListView(
     children: [
       Container(
         height: 160.0,
         decoration: BoxDecoration(
           color: HexColor("#D9D9D9"),
         ),
         child: DrawerHeader(
           child: Center(
             child: Container(
               margin: EdgeInsets.only(top:50.0, bottom:50.0, left: 70.0, right: 70.0),
               width: 170.0,
               // height: 30.0,
                 decoration: BoxDecoration(
                   // image: DecorationImage(image: AssetImage("images/handiwork_header.png",),),
                 ),
               child: Image(image: AssetImage("images/handiwork_header.png",),),
             ),
           ),
         ),
       ),
       Padding(
         padding: const EdgeInsets.only(left: 20.0, right: 5.0, top:40.0 ),
         child: Text("Emiewo Victor", style: TextStyle(color: HexColor("#212529"), fontSize: 13.0, fontWeight: FontWeight.bold), ),
       ),

       Padding(
         padding: const EdgeInsets.only(left: 20.0, right: 5.0, top:5.0 ),
         child: Text("Emiewovictor@gmail.com", style: TextStyle(color: HexColor("#212529"), fontSize: 13.0, fontWeight: FontWeight.bold),),
       ),
       Container(
         height: 1.0,
         margin: EdgeInsets.only(top: 25, left: 20.0),
         decoration: BoxDecoration(
           color: HexColor("#D4D4D4")
         ),
       ),

       InkWell(
         onTap: (){

         },
         child: Container(
           width: 150.0,
           margin: EdgeInsets.only(top: 15, left: 20.0, bottom: 5.0),
           child: Text("Change Password", style: TextStyle(color: HexColor("#212529"), fontSize: 13.0, fontWeight: FontWeight.bold),),
         ),
       ),

       Container(
         height: 1.0,
         margin: EdgeInsets.only(top: 10, left: 20.0),
         decoration: BoxDecoration(
             color: HexColor("#D4D4D4")
         ),
       ),

         InkWell(
           onTap: (){
           Navigator.push(context, MaterialPageRoute(builder: (context){
             return SupportPage();
           }));
           },
           child: Container(
             width: 150.0,
             margin: EdgeInsets.only(top: 15, left: 20.0, bottom: 5.0),
             child: Text("Support", style: TextStyle(color: HexColor("#212529"), fontSize: 13.0, fontWeight: FontWeight.bold),),
       ),
    ),

       Container(
         height: 1.0,
         margin: EdgeInsets.only(top: 10, left: 20.0),
         decoration: BoxDecoration(
             color: HexColor("#D4D4D4")
         ),
       ),

       InkWell(
         onTap: (){
         _openLogOutDialog();
         },
         child: Row(
           children: [
             Container(
               margin: EdgeInsets.only(top: 25, left: 20.0, bottom: 5.0),
               width: 20.0,
               height: 20.0,
               decoration: BoxDecoration(
                 image: DecorationImage(image: AssetImage("images/logout_square.png",),),
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(top: 25, left: 10.0, bottom: 5.0),
               child: Text("Log Out", style: TextStyle(color: HexColor("#212529"), fontSize: 13.0, fontWeight: FontWeight.bold,)),
             ),
           ],
         ),
       ),

       InkWell(
         onTap: (){

         },
         child: Row(
           children: [
             Container(
               margin: EdgeInsets.only(top: 25, left: 20.0, bottom: 5.0),
               width: 20.0,
               height: 20.0,
               decoration: BoxDecoration(
                 image: DecorationImage(image: AssetImage("images/wallet.png",),),
               ),
             ),
             Padding(
               padding: const EdgeInsets.only(top: 25, left: 10.0, bottom: 5.0),
               child: Text("Wallet", style: TextStyle(color: HexColor("#212529"), fontSize: 13.0, fontWeight: FontWeight.bold,)),
             ),
           ],
         ),
       ),
     ],
    ),
      ),
      ),
      body: pages[pageIndex],

      bottomNavigationBar: Container(
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0), topRight: Radius.circular(5.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            InkWell(
              onTap: (){
                setState(() {
                  pageIndex = 0;
                });
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: IconButton(onPressed: null,
                          icon: pageIndex == 0 ? Icon(Icons.home_outlined, size: 25.0, color: HexColor("#5E60CE"),) :
                          Icon(Icons.home_outlined, size: 25.0, color: HexColor("#212529"),), enableFeedback: false,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 38.0, left: 10.0),
                        child: new Text("Home", style: pageIndex == 0 ? TextStyle(color: HexColor("#5E60CE"), fontSize: 10.0) : TextStyle(color: HexColor("#212529"), fontSize: 10.0,),),
                      )
                    ],
                  ),

                ],
              ),
            ),

            InkWell(
              onTap: (){
                setState(() {
                  pageIndex = 1;
                });
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 2.0 ),
                        child: IconButton(onPressed: null,
                          icon: pageIndex == 1 ? Icon(Icons.announcement_outlined, size: 25.0, color: HexColor("#5E60CE"),) :
                          Icon(Icons.announcement_outlined, size: 25.0, color: HexColor("#212529"),), enableFeedback: false,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 38.0, ),
                        child: new Text("Announcement", style: pageIndex == 1 ? TextStyle(color: HexColor("#5E60CE"), fontSize: 10.0) : TextStyle(color: HexColor("#212529"), fontSize: 10.0),),
                      )
                    ],
                  )
                ],
              ),
            ),

            InkWell(
              onTap: (){
                setState(() {
                  pageIndex = 2;
                });
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: IconButton(onPressed: null,
                          icon: pageIndex == 2 ?  Icon(Icons.person_outline, size: 25.0, color: HexColor("#5E60CE"),) :
                          Icon(Icons.person_outline, size: 25.0, color: HexColor("#212529"),), enableFeedback: true,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 38.0,left: 5.0),
                        child: new Text("Account", style: pageIndex == 2 ? TextStyle(color: HexColor("#5E60CE"), fontSize: 10.0) : TextStyle(color: HexColor("#212529"), fontSize: 10.0),),
                      )
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  // open log out dialog
  void _openLogOutDialog(){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context, builder: (ctx) => LogOutDialog());
  }

}
