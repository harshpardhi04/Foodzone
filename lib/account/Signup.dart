import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodzone/Dashboard/dashboard.dart';
import 'package:foodzone/widgets/inputText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatelessWidget{

  TextEditingController _username=TextEditingController();
  TextEditingController _restaurantname=TextEditingController();
  TextEditingController _email=TextEditingController();
  TextEditingController _pin=TextEditingController();

  Future<void> setData(key,value) async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setString(key,value );
  }
  Future<void> checkData(context) async{
    String name=_username.text;
    String restaurant_name=_restaurantname.text;
    String email=_email.text;
    String pin=_pin.text;
    print(name);
    if(name.isNotEmpty && email.isNotEmpty && pin.isNotEmpty && restaurant_name.isNotEmpty)
      {
        setData("name", name);
        setData("restaurant_name", restaurant_name);
        setData("pin",pin);
        Fluttertoast.showToast(msg: "Data saved succesfully! Thank you");
        _username.clear();
        _restaurantname.clear();
        _email.clear();
        _pin.clear();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=>Dashboard()));
      }
    else{
      print(name);
      Fluttertoast.showToast(msg: "Please fill all details");
      _username.clear();
      _restaurantname.clear();
      _email.clear();
      _pin.clear();
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
                  Text("Sign up",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),),
                  SizedBox(height: 20,),
                  Text("Create an account, It's free",
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
                 inputText(text: "Restaurant Name",
                     input: TextInputType.name,
                     controller:_restaurantname),
                 inputText(text: "Email",
                     input: TextInputType.emailAddress,
                     controller:_email),
                 inputText(text: "Password",
                     input: TextInputType.number,
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
                    checkData(context);
                    },
                  child: Text("Register",
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
                  Text("Already have an account?"),
                  Text(" Login",style: TextStyle(fontWeight:
                  FontWeight.w600,fontSize: 17,color: Colors.blueAccent),)
                ],
              )

            ],
          ),

        ),
      ),
    );
  }
}