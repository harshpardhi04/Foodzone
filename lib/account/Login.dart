import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzone/Dashboard/dashboard.dart';
import 'package:foodzone/account/Signup.dart';
import 'package:foodzone/widgets/inputText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget{
  TextEditingController _username=TextEditingController();
  TextEditingController _pin=TextEditingController();
  late String? username;
  late String? pin;

  Future<void> getData(context) async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    username=await pref.getString("name");
    pin=await pref.getString("pin");
    if(username==_username.text && pin==_pin.text)
      {
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=>Dashboard()));
      }else{
      Fluttertoast.showToast(msg: "Please enter correct details !");
    }
  }

  @override
  Widget build(BuildContext context) {
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: Icon(Icons.arrow_back_ios,size: 20,color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height:height-50 ,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text("Login",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),),
                  SizedBox(height: 20,),
                  Text("Welcome back ! 😍\n I am happy to see you again ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey[700]
                    ),)
                ],
              ),
              Column(
                children: [
                  inputText(text: "Username",
                      input: TextInputType.name,
                      controller:_username),
                  inputText(text: "Password",
                      input: TextInputType.visiblePassword,
                      controller:_pin),

                ],
              ),
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
                    await getData(context);
                  },
                  child: Text("Login",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not have an account?"),
                  GestureDetector(
                    onTap: (){Navigator.push(context,
                        MaterialPageRoute(builder: (context)=>Signup()));},
                    child: Text(" Signup",style: TextStyle(fontWeight:
                    FontWeight.w600,fontSize: 17,color: Colors.blueAccent),),
                  )
                ],
              )

            ],
          ),

        ),
      ),
    );
  }
}