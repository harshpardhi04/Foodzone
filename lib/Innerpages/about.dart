import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About FoodZone",style:
        TextStyle(fontSize: 22,color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.black,),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("I am Harsh Pardhi ! (❁´◡`❁)",
              style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 15),),
              SizedBox(height: 5,),
              Text("from Gondia-441601"),
              SizedBox(height: 15,),
              Divider(color: Colors.blue,thickness: 2,),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: Image(
                      image: AssetImage("Assets/images/food.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 200,
                    child: Center(
                      child: Text(
                        "Hello! I am harsh pardhi"
                            " CEO of Glix technologies, gondia."
                            " We are an amazing team of great passionate"
                            " developers. With love I deliever these"
                            "beautiful APP to you. In case of any difficulties"
                            "you can contact me. ",
                        style: TextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 50,),
              Container(
                height: 40,
                width:200,
                child: Center(
                  child: Card(
                    margin: EdgeInsets.only(left: 10,right: 5),
                    child: Center(child: Text("📞 Contact: +919529667349")),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                height: 50,
                width:300,
                child: Card(
                  child: Center(child: Text("📧 Email: harshpardhi499@gmail.com",textAlign: TextAlign.center,)),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                height: 40,
                width:300,
                child: Card(
                  child: Center(child: Text("🌏 Website: www.glixtechnologies.com",textAlign: TextAlign.center,)),
                ),
              ),
              SizedBox(height: 20,),
              Text(
                  "🚫 Notice\n ----------------------\n The copyright and proprietry sales authorship "
                  "is managed and distributed by 😑 harsh pardhi (Glix technologies) "
                  "Please do not share these app to anyone if they are not registered"
                  " person. Otherwise 🚔 legal action will taken on you and other person.",textAlign: TextAlign.center,)

            ],
          ),
        ),
      ),
    );
  }
}