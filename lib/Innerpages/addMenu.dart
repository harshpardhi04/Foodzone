import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/customAlert.dart';

class addmenu extends StatefulWidget {
  @override
  State<addmenu> createState() => _addmenuState();
}

class _addmenuState extends State<addmenu> {
  TextEditingController _menuname = TextEditingController();
  TextEditingController _price = TextEditingController();
  late Map<String, String> addmenu;

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
    addmenu = Map();
    getMenu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          "Add Dishes",
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 25, color: Colors.black),
        ),
      ),
      body: ListView.builder(
        itemCount: addmenu.keys.length,
        itemBuilder: (context, index) {
          return Dismissible(
            background: Container(
              color: Colors.red,
              child: Center(child: Icon(Icons.delete),),
            ),
            key: Key(addmenu.keys.elementAt(index).toString()),
            onDismissed: (direction) async {
              String name = addmenu.keys.elementAt(index).toString();
              String price = addmenu.values.elementAt(index).toString();
              addmenu.remove(name);
              addmenu.remove(price);
              await saveMenuToSharedPreferences(addmenu);
              setState(() {
                print(addmenu);
              });
            },
            child: Card(
              shadowColor: Colors.grey,
              elevation: 5.0,
              child: ListTile(
                title: Text(
                  addmenu.keys.elementAt(index).toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                subtitle: Text(
                  "Rs." + addmenu.values.elementAt(index).toString(),
                  style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                ),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  child: Image(
                    fit: BoxFit.cover,
                    image: AssetImage("Assets/images/menu.png"),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: custom_alert(
        controller: _menuname,
        text: 'Add Menu',
        price: _price,
        onPressed: () async {
          if (_menuname.text != "" && _price.text != "") {
            addmenu[_menuname.text] = _price.text;
            await saveMenuToSharedPreferences(addmenu);
            _menuname.clear();
            _price.clear();
            Navigator.pop(context);
            FocusScope.of(context).unfocus();
            Fluttertoast.showToast(msg: 'Menu added successfully');
          } else {
            Fluttertoast.showToast(msg: "Please fill all details");
          }
        },
        text1: "Dish Name",
        text2: "Price",
      ),
    );
  }

  Future<void> saveMenuToSharedPreferences(Map<String, String> menuData) async {
    final prefs = await SharedPreferences.getInstance();
    final encodedData = json.encode(menuData);
    await prefs.setString("foodZone", encodedData);
  }
}
