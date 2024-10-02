import'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
class ScheduleAppointmentPage extends StatefulWidget {
  const ScheduleAppointmentPage({super.key});

  @override
  State<ScheduleAppointmentPage> createState() => _ScheduleAppointmentPageState();
}

class _ScheduleAppointmentPageState extends State<ScheduleAppointmentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 50.0,
        backgroundColor: Colors.white,
        leading:  new GestureDetector(
          onTap: (){
            Navigator.pop(context);
          },
          child: Container(
            margin: EdgeInsets.only(left: 16.0, right: 20.0),
            width: 16.0,
            height: 18.0,
            child: Image(image: AssetImage("images/arrow_back.png"),),
          ),
        ),
        title: Text("Schedule Appointment", style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: HexColor("#212529"),),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 20.0),
              child: Text("Set an appointment date", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: HexColor("#212529"),),),
            ),

          ],
        ),
      ),
    );
  }
}
