import'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ItemsPage extends StatelessWidget {
  ItemsPage({super.key});

  List<String> product = ["Bed", "Chair", "table", "Bed", "Chair", "table", "Bed", "Chair", "table", "Bed", "Chair", "table"];
  List<String> productDetails = ["King size Bed", " big Sofa Chair", "Dinning Table", "King size Bed", " big Sofa Chair", "Dinning Table", "King size Bed", " big Sofa Chair", "Dinning Table", " big Sofa Chair", "Dinning Table", " big Sofa Chair"];
  List<int> productPrice = [45000, 25000, 150000, 45000, 25000, 150000, 45000, 25000, 150000, 45000, 25000, 150000];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Items"),
      ),
      body: Container(
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
                );
              },
                ),
        ),
      )
    );
  }
}
