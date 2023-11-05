import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzone/widgets/dashboard_layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget{

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String? name;
  Future<void> getData()async {
     SharedPreferences pref = await SharedPreferences.getInstance();
     name=await pref.getString("restaurant_name");
     setState(() {
     });
  }
  @override
  void initState() {
    Timer(Duration(seconds: 1),(){
      getData();
      setState(() {
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
     return Scaffold(
       resizeToAvoidBottomInset: true,
       backgroundColor: Colors.white,
       appBar: AppBar(
         shadowColor: Colors.grey,
         title: Text("Dashboard, $name",style:
         TextStyle(fontSize: 22,color: Colors.black)),
         elevation: 0,
         backgroundColor: Colors.white,
         leading: IconButton(
           onPressed: (){},
           icon: Image(image: AssetImage("Assets/images/dash_logo.png"),)
         ),
       ),
       body: SafeArea(
         child: Container(
            width: width,
           height: height,
           margin: EdgeInsets.only(left: 5,right: 5),
           color: Colors.white,
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               Container(
                 width: width,
                 height: 100,
                 margin: EdgeInsets.only(top:10),
                 decoration: BoxDecoration(
                   image: DecorationImage(image:
                     AssetImage("Assets/images/dasboard_containerbg.jpg"),
                     fit: BoxFit.cover,
                   ),
                   color: Colors.deepOrangeAccent,
                   borderRadius: BorderRadius.circular(10)
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Text("Restaurant POS",
                         style: TextStyle(fontSize: 20,
                         fontWeight: FontWeight.bold,
                         color: Colors.white),),
                         SizedBox(height: 5,),
                         Text("Proud to be made in Gondia",
                           style: TextStyle(fontSize: 15,
                               fontWeight: FontWeight.bold,
                               color: Colors.white),),
                       ],
                     ),
                     SizedBox(width: 10,),
                     Container(
                       height: 100,
                       width: width/3,
                       child: Image(
                         image: AssetImage("Assets/images/food.png"),
                       )

                     )

                   ],
                 ),

               ),
               SizedBox(height: 20,),
               DashBoard_layout(),
               Container(
                 margin: EdgeInsets.only(bottom: 40),
                 child: Text("Designed and Developed by\n 👍 Harsh Pardhi",
                   textAlign: TextAlign.center,
                   style: TextStyle(fontWeight: FontWeight.bold),),
               )
                 ],
               )
           ),
         ),
       );
  }
}