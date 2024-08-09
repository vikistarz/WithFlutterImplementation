import 'package:cross_platform_application/screens/portfolioPage.dart';
import 'package:cross_platform_application/screens/shortsPage.dart';
import 'package:cross_platform_application/screens/signUpPage.dart';
import 'package:cross_platform_application/screens/subscriptionPage.dart';
import 'package:cross_platform_application/screens/youPage.dart';
import'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NewHomePage extends StatefulWidget {
  const NewHomePage({super.key});

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {

   int pageIndex = 0;

   final pages = [
     const YouPage(),
     const ShortsPage(),
     const SubscriptionPage(),
     const PortfolioPage(),
   ];

   bool pressed = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        toolbarHeight: 60.0,
        actions: [
          Icon(Icons.ac_unit_outlined)
        ],
      ),
      drawer: Drawer(
        backgroundColor: HexColor("#212529"),
        shape: LinearBorder.start(),
        child: ListView(
          children: [
            Container(
              height: 148.0,
              child: DrawerHeader(
                padding: EdgeInsets.zero,
                child: Container(

                  padding: EdgeInsets.only(top: 0.0),
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    color: HexColor("#212529"),
                    border: Border(
                        bottom: BorderSide(
                          // width: 2, color: Colors.grey, style: BorderStyle.solid
                        )
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 20.0 ),
                            child: Image(image: AssetImage("images/img.png"), width: 30.0, height: 30.0,),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 5.0, top:20.0 ),
                            child: Text("Football", style: TextStyle(color: Colors.white, fontSize: 20.0),),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.0),
                        decoration: BoxDecoration(
                          color: HexColor("#5E60CE"),
                          border: Border(
                              bottom: BorderSide(
                                  width: 2, color: Colors.grey, style: BorderStyle.solid
                              )
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return SignUpPage();
                        })
                        );
                        },
                        child: Container(
                          height: 50.0,
                          margin: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                                Radius.circular(23.0)
                            ),
                            color: HexColor("#F4E1E1"),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(left: 25.0),
                                  child:   Icon(Icons.all_inbox, size: 20.0, color: Colors.purpleAccent,)
                              ),
                              Padding(
                                  padding:  EdgeInsets.only(left: 25.0),
                                  child:   Text("All Inbox", style: TextStyle(fontSize: 16.0,color: Colors.purpleAccent),)
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 110.0, right: 16.0),
                                  child:   Text("99+", style: TextStyle(fontSize: 12.0,color: Colors.purpleAccent),)
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            ListTile(leading: Icon(Icons.radio, size: 15.0, color: Colors.grey,), title: Text("Primary", style: TextStyle(color: Colors.grey, fontSize: 16.0),), onTap: (){}, trailing: Text("99+", style: TextStyle(color: Colors.grey, fontSize: 12.0),),),
            ListTile(leading: Icon(Icons.people, size: 15.0,color: Colors.grey), title: Text("Social", style: TextStyle(color: Colors.grey, fontSize: 16.0),), onTap: (){}, trailing: Container(
              width: 55.0,
              height: 20.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(13.0)
                ),
                color: Colors.blueAccent,
              ),
              child: Row(
                children: [
                  Padding(
                      padding:  EdgeInsets.only(left: 6.0, right: 6.0),
                      child:   Text("30 new", style: TextStyle(fontSize: 12.0,color: Colors.black54),)
                  ),
                ],
              ),
            )
            ),
            ListTile(leading: Icon(Icons.label_important_outline, size: 15.0,color: Colors.grey), title: Text("Promotions", style: TextStyle(color: Colors.grey, fontSize: 16.0),), onTap: (){}, trailing: Text("99+", style: TextStyle(color: Colors.grey, fontSize: 12.0),),),
            ListTile(leading: Icon(Icons.notification_important_outlined, size: 15.0,color: Colors.grey), title: Text("Updates", style: TextStyle(color: Colors.grey, fontSize: 16.0),), onTap: (){}, trailing: Text("99+", style: TextStyle(color: Colors.grey, fontSize: 12.0),),),
          ],
        ),
      ),
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: 80.0,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(2.0), topRight: Radius.circular(2.0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            new GestureDetector(
              onTap: (){
                setState(() {
                  pageIndex = 0;
                });
              },
              child: Column(
                children: [
                  IconButton(onPressed: () {},
                    icon: pageIndex == 0 ? const Icon(Icons.home_outlined, size: 25.0, color: Colors.pink,) :
                    const Icon(Icons.home_outlined, size: 25.0, color: Colors.white,), enableFeedback: false,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: new Text("Home", style: pageIndex == 0 ? TextStyle(color: Colors.pink) : TextStyle(color: Colors.white),),
                  )
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
                  IconButton(onPressed: () {},
                            icon: pageIndex == 1 ? const Icon(Icons.table_view_outlined, size: 25.0, color: Colors.pink,) :
                            const Icon(Icons.table_view_outlined, size: 25.0, color: Colors.white,), enableFeedback: false,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: new Text("Short", style: pageIndex == 1 ? TextStyle(color: Colors.pink) : TextStyle(color: Colors.white),),
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
                  IconButton(onPressed: () {},
                         icon: pageIndex == 2 ? const Icon(Icons.subscriptions_outlined, size: 25.0, color: Colors.pink,) :
                         const Icon(Icons.subscriptions_outlined, size: 25.0, color: Colors.white,), enableFeedback: true,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: new Text("Subscription", style: pageIndex == 2 ? TextStyle(color: Colors.pink) : TextStyle(color: Colors.white),),
                  )
                ],
              ),
            ),

            InkWell(
              onTap: (){
                setState(() {
                  pageIndex = 3;
                });
              },
              child: Column(
                children: [
                  IconButton(onPressed: () {},
                          icon: pageIndex == 3 ? const Icon(Icons.cases_outlined, size: 25.0, color: Colors.pink,) :
                          const Icon(Icons.cases_outlined, size: 25.0, color: Colors.white,),),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: new Text("Portfolio", style: pageIndex == 3 ? TextStyle(color: Colors.pink) : TextStyle(color: Colors.white),),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
