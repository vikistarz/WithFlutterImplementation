import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
class CustomerEmailAddressEditDialog extends StatefulWidget {
  const CustomerEmailAddressEditDialog({super.key});

  @override
  State<CustomerEmailAddressEditDialog> createState() => _CustomerEmailAddressEditDialogState();
}

class _CustomerEmailAddressEditDialogState extends State<CustomerEmailAddressEditDialog> {

  final emailAddressController = TextEditingController();

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
        height: MediaQuery.of(context).size.height * 0.68,
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
              children: [

                new GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 70.0,
                    height: 30.0,
                    margin:EdgeInsets.only(left: 20.0),
                    child: Text("Cancel", style: TextStyle(color: HexColor("#2945DD"), fontSize: 15.0, fontWeight: FontWeight.normal), ),
                  ),
                ),

                Expanded(child: SizedBox(),),

                Container(
                    height: 30.0,
                    child: Text("Edit Profile", style: TextStyle(color: HexColor("#212529"), fontSize: 15.0, fontWeight: FontWeight.bold),)),

                Expanded(child: SizedBox(),),

                new GestureDetector(
                  onTap: (){
                    Navigator.pop(context, emailAddressController.text);
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
                  padding: const EdgeInsets.only(top: 40.0, left: 16.0, right: 16.0),
                  child: Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: HexColor("#F6F6F6"),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0,),
                      child: TextFormField(
                        controller: emailAddressController,
                        keyboardType:TextInputType.emailAddress,
                        maxLength: 35,
                        decoration: InputDecoration(
                            counterText: '',
                            hintStyle: TextStyle(color: HexColor("#C3BDBD"), fontSize: 14.0, fontWeight: FontWeight.bold),
                            border: InputBorder.none
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
        ),
      );
  }
}
