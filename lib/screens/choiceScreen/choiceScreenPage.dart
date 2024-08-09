import 'package:cross_platform_application/screens/CustomerSignUp/customerSignUpPage.dart';
import 'package:cross_platform_application/screens/serviceProviderSignUp/serviceProviderSignUpPage,dart.dart';
import'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
class ChoiceScreenPage extends StatelessWidget {
  const ChoiceScreenPage({super.key});

  // String _data = "No data";
  //
  // void _showCustomDialog(BuildContext context) {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (context) => CustomDialog(),
  //   );
  // }

  // Future<void> _showCustomDialog() async {
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 0.0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
               Align(
                 alignment: Alignment.topRight,
                 child: Container(
                   width: 280.0,
                     height: 150.0,
                     margin: EdgeInsets.only(left: 0.0),
                     decoration: BoxDecoration(
                       image: DecorationImage(image: AssetImage("images/half_choice_top_layout.png"), fit: BoxFit.cover),
                       borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.0))
                     ),
                   child: SizedBox(
                     child: Image(image: AssetImage("images/handiwork_white_logo.png"))),
                   ),
                  ),

           Container(
             margin: EdgeInsets.only(top: 100.0),
             child: Center(
               child: Column(
                 children: [
                   Text("Join our online community", style: TextStyle(color: Colors.black, fontSize: 20.0),),
                   Text("of Service Providers", style: TextStyle(color: Colors.black, fontSize: 20.0),),
                   Text("and Customers ", style: TextStyle(color: Colors.black, fontSize: 20.0),),
                 ]
               ),
             ),
           ),

            Padding(
              padding: const EdgeInsets.only(top: 100.0, left: 16.0, right: 16.0),
              child: Center(
                child: ElevatedButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ServiceProviderSignUpPage();
                    }));
                },
                  child: Text("Service Providers", style: TextStyle(fontSize: 18.0),),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: HexColor("#5E60CE"), padding: EdgeInsets.all(10.0),
                    minimumSize: Size(400.0, 60.0),
                    // fixedSize: Size(300.0, 50.0),
                    textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0)),
                    ),
                    // side: BorderSide(color: Colors.black, width: 2),
                    // alignment: Alignment.topCenter
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0, bottom: 70.0),
              child: Center(
                child: ElevatedButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return CustomerSignUpPage();
                    }));
                },
                  child: Text("Customers", style: TextStyle(fontSize: 18.0),),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: HexColor("#212529"), padding: EdgeInsets.all(10.0),
                    minimumSize: Size(400.0, 60.0),
                    // fixedSize: Size(300.0, 50.0),
                    textStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                          bottomLeft: Radius.circular(15.0)),
                    ),
                    // side: BorderSide(color: Colors.black, width: 2),
                    // alignment: Alignment.topCenter
                  ),
                ),
              ),
            ),
         ]
      ),
    ),
    );
  }
}

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Custom Bottom Sheet',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.link),
                title: Text('Get link'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit name'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete collection'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.link),
                title: Text('Get link'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text('Edit name'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Delete collection'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
