import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzone/Dashboard/dashboard.dart';
import 'package:foodzone/account/Login.dart';
import 'package:foodzone/account/Signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckSignup extends StatefulWidget{
  @override
  State<CheckSignup> createState() => _CheckSignupState();
}

class _CheckSignupState extends State<CheckSignup> {
  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: [
                    Text("Welcome",
                      style:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      )
                      ,),
                    SizedBox(height: 20,),
                    Text("FoodZone is designed and developed with ❤️ by Harsh Pardhi 😊",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15
                      ),)

                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height/3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Assets/images/welcome.png")
                      )
                  ),
                ),
                Column(
                  children:<Widget> [
                    Container(
                      width:width,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey,width: 2)
                      ),
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child: TextButton(
                        onPressed: () async{
                          SharedPreferences pref2=await SharedPreferences.getInstance();
                          pref2.setBool("KEYLOGIN", true);
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context)=>Login())
                          );
                        },
                        child: Text("Login",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.black,
                          ),),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width:width,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueAccent
                      ),
                      margin: EdgeInsets.only(left: 10,right: 10),
                      child: TextButton(
                        onPressed: () async{
                          SharedPreferences pref2=await SharedPreferences.getInstance();
                          pref2.setBool("KEYLOGIN", true);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context)=>Signup()));
                        },
                        child: Text("Signup",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: Colors.white,
                          ),),
                      ),
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

