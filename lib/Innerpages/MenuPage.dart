import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzone/Innerpages/finalpage.dart';
import 'package:hive/hive.dart';
import 'package:quantity_input/quantity_input.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MenuPage extends  StatefulWidget{
  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  late Box _cartBox;
  late Map<String,String> addmenu;
  late Map<String,String> cartItems;
  late Map<String,String> data;
  Map<String, int> itemQuantity = {};
  int bill=0;
  Future<void> getMenu() async {
    final prefs = await SharedPreferences.getInstance();
    final menuData = prefs.getString("foodZone");
    if (menuData != null) {
      final decodedData = json.decode(menuData);
      print(decodedData);
      addmenu.addAll(Map<String, String>.from(decodedData));
    }
    setState(() {});
  }

  @override
  void initState() {
    _cartBox=Hive.box("totalprice");
    addmenu = Map();
    cartItems=Map();
    getMenu();
    super.initState();
  }

  void addMenu(String dishname,String price) async{
    cartItems.putIfAbsent(dishname, () => price);
    await _cartBox.put("totalprice",cartItems);
    setState(() {
    });
  }
  void removeMenu(String dishname){
    final cartItemindex=_cartBox.values.singleWhere((element) => element.containsKey(dishname));
    if (cartItemindex != -1) {
    }
    setState(() {});
  }
  void quantAdd(String dishname, int price) {
    if (!cartItems.containsKey(dishname)) {
      cartItems[dishname] = price.toString();
    }
     _cartBox.put("totalprice", cartItems);
    if (itemQuantity.containsKey(dishname)) {
      itemQuantity[dishname] = itemQuantity[dishname]! + 1;
    } else {
      itemQuantity[dishname] = 1;
    }
    int totalPrice = price * itemQuantity[dishname]!;
    setState(() {
      bill = totalPrice;
    });
  }
  void quantRemove(String dishname, int price) {
    if (itemQuantity.containsKey(dishname) && itemQuantity[dishname]! > 0) {
      itemQuantity[dishname] = itemQuantity[dishname]! - 1;
    }
    int totalPrice = price * itemQuantity[dishname]!;
    setState(() {
      bill = totalPrice;
    });
  }
  Future<void> storebill(int billprice) async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setInt("totalbillprice", billprice);
  }

  int calculateTotalBill() {
    int totalBill = 0;
    itemQuantity.forEach((dishName, quantity) {
      if (addmenu.containsKey(dishName)) {
        totalBill += quantity * int.parse(addmenu[dishName]!);
        bill=totalBill;
      }
    });
    return totalBill;

  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Menu",style:
         TextStyle(fontSize: 22,color: Colors.black)),
         elevation: 0,
         backgroundColor: Colors.white,
         leading: IconButton(
           onPressed: ()async{
             Navigator.pop(context);
             },
           icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.black,),
         ),
       ),
        body: FutureBuilder(
           future: Hive.openBox("foodZone"),
           builder: (context,snapshot){
             return ListView.builder(
               itemCount: addmenu.keys.length,
               itemBuilder: (context,index){
                 var dishName = addmenu.keys.elementAt(index);
                 var price = addmenu.values.elementAt(index);
                 return ListTile(
                   trailing:Container(
                     width: 150,
                     height: 40,
                     padding: EdgeInsets.only(right: 10),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         IconButton(
                           onPressed: (){
                           if (addmenu.containsKey(dishName)) {
                             quantRemove(dishName, int.parse(price));
                             calculateTotalBill();
                           }
                           },
                           icon: Icon(Icons.remove_circle),
                         ),
                         SizedBox(width: 2,),
                         Text(itemQuantity[dishName]?.toString() ?? '0'),
                         SizedBox(width: 2,),
                         IconButton(
                           onPressed: (){
                             if (addmenu.containsKey(dishName)) {
                               quantAdd(dishName, int.parse(price));
                               calculateTotalBill();
                             }
                           },
                           icon: Icon(Icons.add_circle),
                         ),
                       ],
                     ),
                   ),

                   title: Text(addmenu.keys.elementAt(index).toString()),
                   subtitle: Text("Rs." +addmenu.values.elementAt(index).toString()),
                   leading: CircleAvatar(
                     child: Icon(Icons.food_bank_outlined),
                   ),
                 );
               },
             );
           }),
       bottomSheet: Container(
         height: 200,
         child: Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children:<Widget> [
               Center(
                 child: Text("Total price: Rs.$bill",
                   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
               ),
               SizedBox(height: 20),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Container(
                     width: 100,
                     height: 40,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Colors.blue,
                     ),
                     child: TextButton(onPressed: ()async{
                            await storebill(bill);
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>FinalPage(itemQuantity: itemQuantity,))
                            );
                     },
                         child: Text("Print",style: TextStyle(color: Colors.white),)),
                   ),
                   SizedBox(width: 50,),
                   Container(
                     width: 100,
                     height: 40,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Colors.blue,
                     ),
                     child: TextButton(onPressed: (){},
                         child: Text("Remove",style: TextStyle(color: Colors.white),)),
                   ),
                 ],
               )
             ],
           ),
         ),
       )
     );
  }
}