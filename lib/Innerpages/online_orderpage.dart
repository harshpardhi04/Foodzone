import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Onlineorders extends StatelessWidget{
  final controller=WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse('http://freindscafe.shamiragift.com/'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Online Order",style:
        TextStyle(fontSize: 22,color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: Icon(Icons.arrow_back_ios,size: 25,color: Colors.black,),
        ),
      ),
      body:WebViewWidget(
        controller: controller,

      )

    );
  }
}