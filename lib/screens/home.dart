import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.menu), onPressed: (){}, color: Colors.white, iconSize: 25.0,),
        title: Text("Home Page"),
          backgroundColor: Colors.blueAccent,
          actions:[
            IconButton(icon: Icon(Icons.shopping_cart), onPressed: (){}, color: Colors.white, iconSize: 25.0,),
            IconButton(icon: Icon(Icons.search), onPressed: (){}, color: Colors.white, iconSize: 25.0,),
            IconButton(icon: Icon(Icons.menu_book), onPressed: (){}, color: Colors.white, iconSize: 25.0,),
          ],
          elevation: 2,
        titleSpacing: 20.0,
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white),

      ),
      body: Center(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ElevatedButton.icon(
            icon: Icon(Icons.add),
            label: Text("Sign up"),
            // child: Text("Sign up"),
            onPressed: null,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.yellow, padding: EdgeInsets.all(10.0),
              fixedSize: Size(300.0, 50.0),
              textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
              elevation: 12,
              side: BorderSide(color: Colors.black, width: 2),
              // alignment: Alignment.topCenter
            ),
            // style: TextStyle(fontSize: 20.0, fontWeight:FontWeight.bold, backgroundColor: Colors.red, color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
