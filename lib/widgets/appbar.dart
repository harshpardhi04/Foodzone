import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget{
  late String name;

  MyAppBar({required this.name});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(name,style:
      TextStyle(fontSize: 22,color: Colors.black)),
      elevation: 0,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: (){},
        icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.black,),
      ),
    );
  }
}