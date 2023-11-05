import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class custom_alert extends StatelessWidget{
  late final controller;
  VoidCallback onPressed;
  late final price;
  late String text;
  late String text1;
  late String text2;
  custom_alert({ required this.text1,
    required this.text2,
    required this.onPressed,
    required this.price,
    required this.controller,
    required this.text});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: (){
      showDialog(context: context, builder: (context)
      {
        return AlertDialog(
           title: Center(child: Text(text)),
           content: Column(
             mainAxisSize: MainAxisSize.min,
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(text1),
               Container(
                 child: TextField(
                   controller: controller,
                   decoration: InputDecoration(
                     focusedBorder:OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10),
                     borderSide: BorderSide(
                       width: 2,
                         color: Colors.orange
                     )
                 ),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10),
                       borderSide: BorderSide(
                         color: Colors.grey
                       )
                     ),
                   ),
                 ),
               ),
               SizedBox(height: 10,),
               Text(text2),
               Container(
                 child: TextField(
                   keyboardType: TextInputType.number,
                   controller: price,
                   decoration: InputDecoration(
                       focusedBorder:OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                           borderSide: BorderSide(
                             width: 2,
                               color: Colors.orange
                           )
                       ),
                       enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(10),
                           borderSide: BorderSide(
                               color: Colors.grey
                           )
                       )
                   ),
                 ),
               ),
             ],
           ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed:onPressed, child: Text("Add")),
                TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Cancel")),

              ],
            )
          ],
        );
      });
    },
      child: Icon(Icons.add),
      backgroundColor: Colors.orange,
    );
  }
}