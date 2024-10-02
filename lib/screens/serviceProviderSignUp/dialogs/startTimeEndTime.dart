import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
class StartTimeEndTimeDialog extends StatefulWidget {
  const StartTimeEndTimeDialog({super.key});

  @override
  State<StartTimeEndTimeDialog> createState() => _StartTimeEndTimeDialogState();
}

class _StartTimeEndTimeDialogState extends State<StartTimeEndTimeDialog> {

  _StartTimeEndTimeDialogState(){
    selectedStartTimeValue = _jobStartTime[1];
    selectedEndTimeValue = _jobEndTime[1];
  }

  final _jobStartTime = ["7am", "8am", "9am", "10am", "11am", "12pm"];
  final _jobEndTime = ["2pm", "3pm", "4pm", "5pm", "6pm", "7pm"];

  String? selectedStartTimeValue = "";
  String? selectedEndTimeValue = "";


  @override
  Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: 320.0,
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
              children: [

                new GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16.0, right: 16.0),
                    width: 20.0,
                    height: 20.0,
                    child: Image(image: AssetImage("images/arrow_back.png"),),
                  ),
                ),


                Expanded(child: SizedBox(),),

                new GestureDetector(
                  onTap: (){
                     Navigator.pop(context, selectedStartTimeValue! +" " + "-" + " "+ selectedEndTimeValue! );
                  },
                  child: Container(
                      width: 70.0,
                      height: 30.0,
                      margin: EdgeInsets.only(right: 20.0),
                    child: Align(
                      alignment: Alignment.topRight,
                        child: Text("Save", style: TextStyle(color: HexColor("#2945DD"), fontSize: 15.0, fontWeight: FontWeight.normal), )),
                  ),
                ),

              ],
                  ),
                ),


                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text("Select Your Available Job Time", style: TextStyle(color: Colors.grey, fontSize: 16.0, fontWeight: FontWeight.bold),),
                    ),


                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [

                      Expanded(child: SizedBox()),

                      Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text("Start Time:", style: TextStyle(color: HexColor("#212529"), fontSize: 15.0, fontWeight: FontWeight.bold),)),

                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        width: 150.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(color: HexColor("#212529"), width: 1.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 10.0),
                          child: DropdownButtonFormField( value: selectedStartTimeValue,
                            items: _jobStartTime.map((e){
                              return DropdownMenuItem(child: Text(e), value: e,);
                            }
                            ).toList(),
                            onChanged: (value){
                              setState(() {
                                selectedStartTimeValue = value.toString();
                              });
                            },
                            dropdownColor: Colors.white,
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                          ),
                        ),
                      ),

                      Expanded(child: SizedBox()),

                    ],
                  ),
                ),


                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    children: [

                      Expanded(child: SizedBox()),

                      Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text("End Time:", style: TextStyle(color: HexColor("#212529"), fontSize: 15.0, fontWeight: FontWeight.bold),)),

                      Container(
                        margin: EdgeInsets.only(left: 20.0),
                        width: 150.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          border: Border.all(color: HexColor("#212529"), width: 1.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 10.0),
                          child: DropdownButtonFormField( value: selectedEndTimeValue,
                            items: _jobEndTime.map((e){
                              return DropdownMenuItem(child: Text(e), value: e,);
                            }
                            ).toList(),
                            onChanged: (value){
                              setState(() {
                                selectedEndTimeValue = value.toString();
                              });
                            },
                            dropdownColor: Colors.white,
                            decoration: InputDecoration(
                                border: InputBorder.none
                            ),
                          ),
                        ),
                      ),

                      Expanded(child: SizedBox()),

                    ],
                  ),
                ),


              ],
            ),
        ),
      );
  }
}
