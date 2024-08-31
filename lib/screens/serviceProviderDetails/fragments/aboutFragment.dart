import'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
class AboutFragment extends StatelessWidget {
  const AboutFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(color: HexColor("#212529"), width: 0.30),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(right: 30.0, top: 20.0),
                height: 25.0,
                width: 40.0,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("images/pink_background.png",), fit: BoxFit.cover),
                ),
                child: Center(child: Text("Bio", style: TextStyle(color: HexColor("#212529"),fontSize: 10.0, fontWeight: FontWeight.normal),)),
              ),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 35.0, right: 35.0),
                child: Text("hfhfh fkjfkfkkf nhfjfjf jfkfk fjfjfCustomer Ratings dhdjhfdj dbdfh", style: TextStyle(color: HexColor("#212529"),fontSize: 14.0, fontWeight: FontWeight.normal),),
              ),
            ),

            Container(
              margin: EdgeInsets.only(right: 35.0, top: 15.0, left: 35.0),
              width: MediaQuery.of(context).size.width,
              height: 0.60,
              color: HexColor("#212529"),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 35.0, right: 35.0),
                child: Text("Skills", style: TextStyle(color: HexColor("#5E60CE"),fontSize: 11.0, fontWeight: FontWeight.bold),),
              ),
            ),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 35.0, right: 35.0, bottom: 25.0),
                child: Text("Customer Ratings dhfdhfhf hgdhhdh hdfjfj hfhfh hfhjfhj hfhfh dhdfhfdh fnjfj", style: TextStyle(color: HexColor("#212529"),fontSize: 14.0, fontWeight: FontWeight.normal),),
              ),
            ),
          ]
        ),
      )
    );
  }
}
