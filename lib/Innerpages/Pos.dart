import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzone/Innerpages/MenuPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pos extends StatefulWidget{
  @override
  State<Pos> createState() => _PosState();
}

class _PosState extends State<Pos> {
  List<String> tableNumbers = [];
  List<String>? mytable;
  Future<void> getTable()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    mytable=await prefs.getStringList("addTables1");
    if(mytable!=null)
    {
      for(var table in mytable!)
      {
        tableNumbers.add(table);
      }
    }
    setState(() {
    });

  }
  @override
  void initState(){
    getTable();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Store",style:
          TextStyle(fontSize: 22,color: Colors.black)),
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: (){Navigator.pop(context);},
            icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.black,),
          ),
        ),
        body:GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
         mainAxisSpacing: 10.0,
        ),
        itemCount: tableNumbers.length,
         itemBuilder: (context, index) {
        return GestureDetector(
        onTap:() async{
        Navigator.push(context,
        MaterialPageRoute(builder: (context)=>MenuPage()));
         },
        child: Container(
        margin: EdgeInsets.all(8.0),
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border:Border.all(color: Colors.orangeAccent,width: 2)
    ),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Icon(Icons.table_chart_sharp,size: 25,),
        SizedBox(height: 5,),
         Center(child:  Text("Table no."+tableNumbers[index]),),
        ],
       ),
       ),
    );
    },
    ));


  }
}