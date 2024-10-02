
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CategoryPage extends StatelessWidget {
   CategoryPage({super.key});

  List<String> product = ["Bed", "Chair", "table", "Bed", "Chair", "table", "Bed", "Chair", "table", "Bed", "Chair", "table"];
  List<String> productDetails = ["King size Bed", " big Sofa Chair", "Dinning Table", "King size Bed", " big Sofa Chair", "Dinning Table", "King size Bed", " big Sofa Chair", "Dinning Table", " big Sofa Chair", "Dinning Table", " big Sofa Chair"];
  List<int> productPrice = [45000, 25000, 150000, 45000, 25000, 150000, 45000, 25000, 150000, 45000, 25000, 150000];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60.0,
        // leading: IconButton(
        //   icon: Icon(Icons.menu, size: 25.0,), onPressed: (){}, color: Colors.black,
        // ) ,
        title: Text("Categories", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.black),),
        actions: [
         IconButton(onPressed: (){}, icon: Icon(Icons.home, color: Colors.grey,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.person,  color: Colors.grey,)),
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications,  color: Colors.grey,))
        ],
        backgroundColor: Colors.white,
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
                      new GestureDetector(
                        onTap: (){

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: Colors.red,
        child: Icon(Icons.add, color: Colors.white,),
        elevation: 10.0,
        shape: CircleBorder(
        ),
        mini: false,

      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5.0,
        shape: CircularNotchedRectangle(),
        color: Colors.black,
        height: 67.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
          new GestureDetector(
             onTap: (){

             },
             child: Padding(
                 padding: EdgeInsets.only(left: 0.0, bottom: 3.0),
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   Icon(Icons.home, color: Colors.white, size: 25.0,),
                   Text("Home", style: TextStyle(color: Colors.white, fontSize: 10.0),)
                 ],
               ),
             ),
           ),

            Padding(
              padding: EdgeInsets.only(right: 20.0, bottom: 3.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shop, color: Colors.white, size: 25.0,),
                  Text("Shop", style: TextStyle(color: Colors.white, fontSize: 10.0),)
                ],
              ),
            ),


            Padding(
              padding: EdgeInsets.only(left: 20.0, bottom: 3.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite, color: Colors.white, size: 25.0,),
                  Text("Fav", style: TextStyle(color: Colors.white, fontSize: 10.0),)
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(right: 0.0, bottom: 3.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.settings, color: Colors.white, size: 25.0,),
                  Text("Setting", style: TextStyle(color: Colors.white, fontSize: 10.0),)
                ],
              ),
            ),
          ],
        ),
      ),
      body:  Container(
        margin: EdgeInsets.only(bottom: 35.0, top: 25.0),
        child: Scrollbar(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: product.length,
            itemBuilder: (context, index){
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: HexColor("#A1A0A0"),
                  child: Text(product[index][0], style: TextStyle(color: HexColor("#5E60CE")),),
                ),
                title: Text(product[index]),
                subtitle: Text(productDetails[index]),
                trailing: Text(productPrice[index].toString()),
                onTap:(){},
              );
            },
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   scrollDirection: Axis.vertical,
      //   child: Column(
      //     children: [
      //       Container(
      //         height: 500.0,
      //         width: 300.0,
      //         margin: EdgeInsets.only(top: 25.0, bottom: 25.0, right: 20.0, left: 20.0),
      //         decoration: BoxDecoration(
      //             color: Colors.orange,
      //           shape: BoxShape.rectangle
      //         ),
      //         child: Column(
      //           children: [
      //             Container(
      //               margin: EdgeInsets.only(top: 25.0, right: 200.0, left: 16.0),
      //                 child: Text("Hello Victor", style: TextStyle(color: Colors.blue),  ),
      //             ),
      //             Container(
      //                 margin: EdgeInsets.only(top: 25.0),
      //                 child: Text("Hello Kenvin", style: TextStyle(color: Colors.white),  )
      //             ),
      //             Container(
      //                 margin: EdgeInsets.only(top: 25.0),
      //                 child: Text("Hello Marvelous", style: TextStyle(color: Colors.black),  )
      //             )
      //           ],
      //         ),
      //       ),
      //       Center(
      //         child: Container(
      //           height: 400.0,
      //           width: 150.0,
      //           decoration: BoxDecoration(
      //               color: Colors.red,
      //               shape: BoxShape.circle
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // )
    );
  }
}
