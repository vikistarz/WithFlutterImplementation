import'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
class CustomerWalletPage extends StatefulWidget {
  const CustomerWalletPage({super.key});

  @override
  State<CustomerWalletPage> createState() => _CustomerWalletPageState();
}

class _CustomerWalletPageState extends State<CustomerWalletPage> {
  Future<void> _refresh() async {
    // Simulate a network request or any async task
    await Future.delayed(Duration(seconds: 2));

    // Add a new item to the list after refreshing
    setState(() {
      // items.add("Item ${items.length + 1}");
    });
  }

  List<String> customerName = ["Nkechi Blessing", "Nkechi Blessing", "Nkechi Blessing", "Nkechi Blessing", "Nkechi Blessing"];
  List<String> user = ["Customer", "Customer", "Customer", "Customer", "Customer"];
  List<String> productPrice = ["₦45,000", "₦50,000", "₦30,000", "₦25,000", "₦45,000"];




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
      ),
      body:  RefreshIndicator(
    onRefresh: _refresh,
    color: Colors.white,
    backgroundColor: Colors.grey,
    displacement: 40.0,
    strokeWidth: 3.0,
    child: SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
    children: [
      Container(
        height: 230.0,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 16.0, right: 16.0),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/wallet_dashboard.png",),fit: BoxFit.cover,),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.only(top:20, left: 20.0),
              child: Text("Hi",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:14.0,),),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 20.0),
              child: Text("Emiewo Victor",style: TextStyle(color: HexColor("#BEBEBE"), fontWeight: FontWeight.normal, fontSize:14.0,),),
            ),

            Padding(
              padding: const EdgeInsets.only(top:20, left: 20.0),
              child: Text("Total Balance",style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize:14.0,),),
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0.0, left: 20.0),
                  child: Text("₦",style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize:14.0,),),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 6.0, left: 5.0),
                  child: Text("300,000",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:24.0,),),
                ),
              ],
            ),

            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0.0, left: 20.0),
                  child: Text("08108731106",style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize:14.0,),),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 10.0),
                  child: new GestureDetector(
                    onTap: (){

                    },
                      child: Image(image: AssetImage("images/copy_icon.png"), width: 20.0, height: 20.0,)),
                ),

                Expanded(
                    child: SizedBox(),
                ),

                new GestureDetector(
                  onTap: () {

                  },
                  child: Container(
                    height: 37.0,
                    width: 110.0,
                    margin: EdgeInsets.only(right: 20.0),
                    decoration: BoxDecoration(
                      color: HexColor("#45479F"),
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      border: Border.all(color: Colors.white, width: 1.0),
                    ),
                   child: Row(
                     children: [

                       Expanded(
                         child: SizedBox(),
                       ),

                       Image(image: AssetImage("images/transfer_icon.png"), width: 24.0, height: 24.0,),

                       Padding(
                         padding: const EdgeInsets.only(top: 0.0, left: 0.0),
                         child: Text("Transfer",style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize:14.0,),),
                       ),

                       Expanded(
                         child: SizedBox(),
                       ),
                     ],
                   ),
                  ),
                ),
              ],
            ),
          ],
        ),
       ),

       SizedBox(
         height: 50.0,
       ),

      Row(
       children: [
         Expanded(
           child: Container(
             height: 50.0,
             margin: EdgeInsets.only(left: 25.0),
             decoration: BoxDecoration(
               color: HexColor("#212529"),
               borderRadius: BorderRadius.all(Radius.circular(25.0)),
             ),
             child: Row(
               children: [

                 Expanded(
                   child: SizedBox(),
                 ),

                 Image(image: AssetImage("images/transfer_icon.png"), width: 27.0, height: 27.0,),

                 Padding(
                   padding: const EdgeInsets.only(top: 0.0, left: 5.0),
                   child: Text("Withdraw",style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize:14.0,),),
                 ),

                 Expanded(
                   child: SizedBox(),
                 ),

               ],
             ),
           ),
         ),

         SizedBox(
           width: 20.0,
         ),

         Expanded(
           child: new GestureDetector(
             onTap: () {

             },
             child: Container(
               height: 50.0,
               margin: EdgeInsets.only(right: 25.0),
               decoration: BoxDecoration(
                 color: HexColor("#0066FF"),
                 borderRadius: BorderRadius.all(Radius.circular(25.0)),
               ),
               child: Row(
               children: [

                 Expanded(
                   child: SizedBox(),
                 ),

                 Image(image: AssetImage("images/add_money.png"), width: 27.0, height: 27.0,),

                 Padding(
                   padding: const EdgeInsets.only(top: 0.0, left: 5.0),
                   child: Text("Add money",style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize:14.0,),),
                 ),

                 Expanded(
                   child: SizedBox(),
                 ),
             ],
               ),
             ),
           ),
         ),
       ],
      ),

      Container(
        height: 350.0,
        margin: EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0, bottom: 50.0),
        decoration: BoxDecoration(
          color: HexColor("#F2F2F2"),
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
         ),
        child: Column(
          children: [
            Row(
           children: [
             Padding(
               padding: const EdgeInsets.only(top: 20.0, left: 20.0),
               child: Text("Transactions",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize:13.0,),),
             ),

             Expanded(
               child: SizedBox(),
             ),

             Padding(
               padding: const EdgeInsets.only(top: 20.0, right: 20.0),
               child: Text("View all",style: TextStyle(color: HexColor("#5E60CE"), fontWeight: FontWeight.bold, fontSize:13.0,),),
             ),
           ],
            ),

            Container(
              height: 270.0,
              margin: EdgeInsets.only(top: 15.0, bottom: 10.0),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: customerName.length,
                  itemBuilder: (context, index){
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: HexColor("#A1A0A0"),
                        child: Text(customerName[index][0], style: TextStyle(color: HexColor("#5E60CE")),),

                      ),
                      title: Text(customerName[index], style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold),),
                      subtitle: Text(user[index], style: TextStyle(color: HexColor("#5E60CE"), fontSize: 10.0, fontWeight: FontWeight.bold),),
                      trailing: Text(productPrice[index] ,style: TextStyle(color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.bold),),
                    );
                  },
                ),
              ),


          ],
        ),
      )
     ],
    ),
    ),
      ),
    );
  }
}
