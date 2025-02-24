import 'package:cross_platform_application/screens/logIn/ui/logIn.dart';
import'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class LogOutDialog extends StatelessWidget {
  const LogOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 225.0,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Image(image: AssetImage("images/log_out_icon.png"),width: 25.0, height: 25.0,),
              )
          ),

          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text("Are you sure you want to leave?", style: TextStyle(color: HexColor("#474747"),fontSize: 12.0, fontWeight: FontWeight.normal),),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Expanded(
                  child: SizedBox()
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20.0, right: 16.0, bottom: 50.0),
                child: Center(
                  child: ElevatedButton(onPressed: () {
                    Navigator.pop(context);

                  },
                    child: Text("No", style: TextStyle(fontSize: 14.0),),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: HexColor("#474747"), backgroundColor: HexColor("#D9D9D9"), padding: EdgeInsets.all(10.0),
                      minimumSize: Size(70.0, 40.0),
                      // fixedSize: Size(300.0, 50.0),
                      textStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0)),
                      ),
                       side: BorderSide(color: HexColor("#5E60CE"), width: 0.5),
                      // alignment: Alignment.topCenter
                    ),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 16.0,  bottom: 50.0),
                child: Center(
                  child: ElevatedButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return LogInPage();
                    }));

                  },
                    child: Text("Yes", style: TextStyle(fontSize: 14.0),),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: HexColor("#5E60CE"), padding: EdgeInsets.all(10.0),
                      minimumSize: Size(70.0, 40.0),
                      // fixedSize: Size(300.0, 50.0),
                      textStyle: TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0)),
                      ),
                      // side: BorderSide(color: Colors.black, width: 2),
                      // alignment: Alignment.topCenter
                    ),
                  ),
                ),
              ),

              Expanded(
                  child: SizedBox()
              ),
            ],
          ),

        ],
      ),
    );
  }
}
