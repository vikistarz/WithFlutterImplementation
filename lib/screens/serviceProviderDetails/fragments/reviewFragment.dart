import'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hexcolor/hexcolor.dart';
class ReviewFragment extends StatefulWidget {
  const ReviewFragment({super.key});

  @override
  State<ReviewFragment> createState() => _ReviewFragmentState();
}

class _ReviewFragmentState extends State<ReviewFragment> {

  final commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
    color: Colors.white,
    ),
    child: SingleChildScrollView(
    scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 3.0),
                  child: Text("Leave a Review and Rate", style: TextStyle(color: HexColor("#212529"), fontSize: 12.0),),
                ),

                Expanded(
                    child: SizedBox()
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Text("Rate:", style: TextStyle(color: HexColor("#212529"), fontSize: 12.0),),
                ),

                Padding(
                  padding: const EdgeInsets.only(right: 5.0, top: 3.0),
                  child: RatingBar.builder(
                    initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context,_) => Icon(Icons.star, color: HexColor("#FFC107"),),
                      onRatingUpdate: (rating){

                      },
                    itemSize: 15.0,
                    unratedColor: Colors.grey[300],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Container(
                height: 80.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  border: Border.all(color: HexColor("#B5B3B3"), width: 2.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0, right: 5, top: 5.0),
                  child: TextFormField(
                    controller: commentController,
                    maxLines: null,
                    minLines: 2,
                    keyboardType:TextInputType.multiline,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 12.0, fontWeight: FontWeight.normal),
                        border: InputBorder.none
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: ElevatedButton(onPressed: () {

                },
                  child: Text("Comment", style: TextStyle(fontSize: 14.0),),
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
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                child: Text("Customer Feedback", style: TextStyle(color: HexColor("#A1A0A0"), fontSize: 12.0, fontWeight: FontWeight.bold),),
              ),
            ),

      Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 10.0, right: 5.0, left: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                color: HexColor("#C3BDBD"),
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(1,1),
              ),
            ],
        ),
        child:  Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
              child: Text("Service Provider Rating & Reviews", style: TextStyle(color: HexColor("#212529"), fontSize: 14.0),),
            ),

            Expanded(
                child: SizedBox()
            ),
            
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(Icons.arrow_forward_ios_outlined, color: Colors.black, size: 17.0,),
            )
          ],
        ),
      ),
          ],
        ),
      ),
    ),
    );
  }
}
