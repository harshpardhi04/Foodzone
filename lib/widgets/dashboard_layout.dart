import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzone/Innerpages/Pos.dart';
import 'package:foodzone/Innerpages/TodosList.dart';
import 'package:foodzone/Innerpages/Waiters.dart';
import 'package:foodzone/Innerpages/about.dart';
import 'package:foodzone/Innerpages/addMenu.dart';
import 'package:foodzone/Innerpages/addTable.dart';
import 'package:foodzone/Innerpages/edit.dart';
import 'package:foodzone/Innerpages/online_orderpage.dart';

import '../Innerpages/Sales.dart';

class DashBoard_layout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: GridView.count(crossAxisCount: 3,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>Pos()));
            },
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.orangeAccent.shade700,width: 2),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.store,
                    size: 50,
                    color: Colors.deepOrangeAccent,
                  ),
                  SizedBox(height: 2,),
                  Text("POS",style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>addTable()));},
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green,width: 2),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.table_chart_rounded,
                    size: 50,
                    color: Colors.green.shade700,
                  ),
                  SizedBox(height: 2,),
                  Text("Tables",style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>addmenu()));
            },
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.redAccent,width: 2),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.emoji_food_beverage_outlined,
                    size: 50,
                    color: Colors.red,
                  ),
                  SizedBox(height: 2,),
                  Text("Menu",style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){Navigator.push(context,
                MaterialPageRoute(builder: (context)=>Sales()));},
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.red,width: 2),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.attach_money,
                    size: 50,
                    color: Colors.deepOrange.shade700,
                  ),
                  SizedBox(height: 2,),
                  Text("Sales",style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>About()));},
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.yellow.shade700,width: 2),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.app_registration,
                    size: 50,
                    color: Colors.yellow.shade700,
                  ),
                  SizedBox(height: 2,),
                  Text("About",style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>Waiters()));},
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.pink,width: 2),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.pink,
                  ),
                  SizedBox(height: 2,),
                  Text("Waiters",style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){Navigator.push(context,
                MaterialPageRoute(builder: (context)=>Onlineorders()));},
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orangeAccent,width: 2),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.web_outlined,
                    size: 50,
                    color: Colors.orange,
                  ),
                  SizedBox(height: 2,),
                  Text("Online",style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap:(){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>Edit()));
            },
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue,width: 2),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.storefront,
                    size: 50,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 2,),
                  Text("Edit",style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>TodosList()));
            },
            child: Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.indigo,width: 2),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.black12
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.note_alt_sharp,
                    size: 50,
                    color: Colors.indigo,
                  ),
                  SizedBox(height: 2,),
                  Text("Note",style: TextStyle(fontWeight: FontWeight.bold),)
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}