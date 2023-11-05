import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzone/Models/MenuModel.dart';
import 'package:foodzone/widgets/customAlert.dart';
import 'package:shared_preferences/shared_preferences.dart';

class addTable extends StatefulWidget{
  @override
  State<addTable> createState() => _addTableState();
}

class _addTableState extends State<addTable> {
  TextEditingController _tableNumberController = TextEditingController();
  TextEditingController _seatingCapacityController = TextEditingController();
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
        print(mytable);
    });

  }
  @override
  void initState() {
    getTable();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Add Tables",style:
        TextStyle(fontSize: 22,color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.black,),
        ),
      ),

      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: tableNumbers.length,
        itemBuilder: (context, index) {
          return InkWell(
            onLongPress:() async{
              SharedPreferences pref=await SharedPreferences.getInstance();
              pref.clear();
              tableNumbers.remove(tableNumbers[index]);
              setState(() {

              });
            },
            child: Container(
              margin: EdgeInsets.all(8.0),
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.deepOrangeAccent.shade100,width: 2)
              ),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  Icon(Icons.table_chart_sharp,size: 25,),
                  SizedBox(height: 10,),
                  Center(child:  Text("Table no."+tableNumbers[index]),),
                ],
              ),
            ),
          );
        },
      ),


      floatingActionButton: custom_alert(
        controller:_tableNumberController,
        text: 'Add Tables',
        price:_seatingCapacityController,
        onPressed: () async{
          String number=_tableNumberController.text;
          if(number!="")
            {
              tableNumbers.add(number);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setStringList("addTables1", tableNumbers);
              setState(() {
              });
              _tableNumberController.clear();
              _seatingCapacityController.clear();
              Navigator.pop(context);
            }
          else{
            Fluttertoast.showToast(msg: "Please add table number");
          }
        },
        text1: "Table number",
        text2: "Seating capacity",
      ),

    );
  }
}