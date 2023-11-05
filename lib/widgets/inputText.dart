
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class inputText extends StatelessWidget {
  late final text;
  late final controller;
  late final input;
  inputText({required this.text, required this.controller,required this.input});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Colors.black87
          ),

        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: controller,
          keyboardType: input,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0,
                  horizontal: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.grey
                ),

              ),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)
              )
          ),
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}