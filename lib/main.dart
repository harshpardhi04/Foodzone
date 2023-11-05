import 'dart:async';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodzone/account/Login.dart';
import 'package:foodzone/account/checksignup.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory doc=await getApplicationDocumentsDirectory();
  Hive.init(doc.path);
  await Hive.openBox("foodZone");
  await Hive.openBox("totalprice");
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.blue,
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.accent,
      )
    ),
    debugShowCheckedModeBanner: false,
    home: Splash(),
  ));
}
class Splash extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<Splash> {

  void wheretogo() async{
    SharedPreferences pref2=await SharedPreferences.getInstance();
    var isLogin=pref2.getBool("KEYLOGIN");
    Timer(Duration(seconds: 2),(){
      if(isLogin!=null)
        {
          if(isLogin)
            {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>Login()));
            }
          else{
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=>CheckSignup()));
          }
        }
      else{
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=>CheckSignup()));
      }
    });
  }

  @override
  void initState() {
    wheretogo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height ,
          color: Colors.blueAccent,
          child:Center(
            child: Text("FoodZone",style:
              TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),),
          ),
        ),
    );
  }
}

