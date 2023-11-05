import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzone/widgets/inputText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Edit extends StatefulWidget{
  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  Future<void> setData(key,value) async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString(key,value );
  }

  Future<void> checkData(context) async{
    String name=_username.text;
    String restaurant_name=_restaurantname.text;
    print(restaurant_name);
    if(name.isNotEmpty  && restaurant_name.isNotEmpty)
    {
      setData("name", name);
      setData("restaurant_name", restaurant_name);
      Fluttertoast.showToast(msg: "Data saved succesfully! Thank you");
    }
    else{
      print(name);
      Fluttertoast.showToast(msg: "Please fill all details");
    }
  }

  TextEditingController _username=TextEditingController();

  TextEditingController _restaurantname=TextEditingController();

  TextEditingController _mobilenumber=TextEditingController();

  TextEditingController _address=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Settings",style:
        TextStyle(fontSize: 22,color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
            setState(() {

            });

          },
          icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.black,),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(top:15,left: 15,right: 15),
          child: Column(
            children: [
              inputText(text: "Restaurant name",
                  controller: _restaurantname,
                  input: TextInputType.name),
              inputText(text: "Your name",
                  controller: _username,
                  input: TextInputType.name),
              inputText(text: "Mobile number",
                  controller: _mobilenumber,
                  input: TextInputType.name),
              inputText(text: "Address",
                  controller: _address,
                  input: TextInputType.name),
              SizedBox(height: 20,),
              Container(
                width:MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blueAccent
                ),
                margin: EdgeInsets.only(left: 10,right: 10),
                child: TextButton(
                  onPressed: () async{
                    checkData(context);
                  },
                  child: Text("Save & Exit",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}