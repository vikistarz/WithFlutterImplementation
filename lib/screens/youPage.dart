import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';

class YouPage extends StatefulWidget {
  const YouPage({super.key});

  @override
  State<YouPage> createState() => _YouPageState();
}

class _YouPageState extends State<YouPage> {

  List <String> items = ["Radio", "Television", "Laptop", "Battery", "Telephone", "Fan", "Box", "Desktop" ];

  List <String> searchItems = [];

  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      searchItems = items;
      isVisible = true;
    });
  }

  void filter(String searchText){
    List<String> results = [];
    if(searchText.isEmpty){
      results = items;
      Visibility(
          visible:  isVisible,
          child: Text("No Result")
      );
    }
    else{
      results = items.where((element) => element.toLowerCase().contains(searchText.toLowerCase())).toList();
    }
    setState(() {
      searchItems = results;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Container(
              height: 50.0,
              margin: EdgeInsets.only(left: 16.0, right: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0)),
                border: Border.all(color: Colors.grey, width: 1.0),
              ),
              child: TextFormField(
                onChanged: (value){
                filter(value);
              },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey,),
                  hintText: "Search",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 16.0),
            child: new Expanded(
              child: ListView.builder(itemCount: searchItems.length,
              shrinkWrap: true,
              itemBuilder: (context, index){
                final name = searchItems[index];
                return Text(name, style: TextStyle(color: Colors.black, fontSize: 18.0),);
              },),
            ),
          ),
          Text("No result"),
        ],
          ),
        ),
    );
  }
}
