import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Sales extends StatefulWidget{
  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  late List<String> salesbill;
  Future<List<String>> getBill() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? sales = preferences.getStringList("salesbill");
    salesbill = sales ?? [];
    return salesbill;
  }

@override
  void initState() {
   getBill();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Sales",style:
         TextStyle(fontSize: 22,color: Colors.black)),
         elevation: 0,
         backgroundColor: Colors.white,
         leading: IconButton(
           onPressed: (){Navigator.pop(context);},
           icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.black,),
         ),
       ),

       body: SafeArea(
         child: Container(
           width: MediaQuery.of(context).size.width,
           height: MediaQuery.of(context).size.height,
           margin: EdgeInsets.only(left: 5, right: 5),
           child: FutureBuilder(
             future: getBill(),
             builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return Center(child: CircularProgressIndicator());
               } else if (snapshot.hasError) {
                 return Center(child: Text("Error: ${snapshot.error}"));
               } else if (!snapshot.hasData || salesbill.isEmpty) {
                 return Center(child: Text("Sorry, there is no data"));
               } else {
                 return ListView.builder(
                   itemCount: salesbill.length,
                   itemBuilder: (context, index) {
                     return ListTile(
                       title: Text("Rs." +salesbill[index].toString()),
                       subtitle: Text("nov-dec 2023"),
                       leading: Icon(Icons.offline_pin,color: Colors.green,),
                     );
                   },
                 );
               }
             },
           ),
         ),
       ),
     );
  }
}