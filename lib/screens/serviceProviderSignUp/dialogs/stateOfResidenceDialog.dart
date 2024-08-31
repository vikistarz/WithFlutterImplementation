import'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class StateOfResidenceDialog extends StatefulWidget {
  const StateOfResidenceDialog({super.key});

  @override
  State<StateOfResidenceDialog> createState() => _StateOfResidenceDialogState();
}

class _StateOfResidenceDialogState extends State<StateOfResidenceDialog> {

  // static List<StateModel> main_state_list = [
  //
  // ];

  void filterList(String value){

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: HexColor("#212529"),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0, left: 20.0),
            child: IconButton(
              onPressed: (){
              Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back_ios, size: 25.0, color: Colors.white,),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
            height: 50.0,
            child: TextFormField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(Icons.search, color: HexColor("#C3BDBD"), size: 20.0,),
                hintText: "Search Here",
                hintStyle: TextStyle(fontSize: 13.0, color: HexColor("#C3BDBD")),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),

          Expanded(child: ListView(),
          ),

        ],
      ),
    );
  }
}
