
import 'dart:typed_data';

import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FinalPage extends  StatefulWidget{
  late  Map<String, int> itemQuantity;
  FinalPage({required this.itemQuantity});
  @override
  State<FinalPage> createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage> {
  late Box _cartBox;
  late Map<String, String> cartItems;
  late Map<String, String> data;
  List<String> mybill=[];
  int bill=0;
  Future<void> getMenu() async {
    data = _cartBox.get("totalprice") ?? {};
    cartItems.addAll(data);
    setState(() {
    });
  }
  Future<void> getBill() async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    int? bill2= pref.getInt("totalbillprice");
    bill=bill2!;
    print(bill);
    setState(() {
    });
  }
  Future<void> storebill(String billprice) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // Retrieve the existing list of bills or create an empty list if it doesn't exist
    List<String> existingBills = pref.getStringList("salesbill") ?? [];

    // Add the new bill to the list
    existingBills.add(billprice);

    // Store the updated list in shared preferences
    pref.setStringList("salesbill", existingBills);

    // Update the local list for display
    mybill = existingBills;

    setState(() {});
 }
  @override
  void initState() {
    _cartBox = Hive.box("totalprice");
    cartItems = Map();
    getMenu();
    getBill();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Preview", style:
        TextStyle(fontSize: 22, color: Colors.black)),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 25, color: Colors.black,),
        ),
      ),
      body: FutureBuilder(
        future: Hive.openBox("totalprice"),
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DataTable(
                  columns: [
                    DataColumn(label: Text("Dish Name")),
                    DataColumn(label: Text("Price")),
                    DataColumn(label: Text("Quantity")),
                  ],
                  rows: cartItems.entries.map((entry) {
                    final dishName = entry.key;
                    final price = entry.value;
                    final quantity = widget.itemQuantity[dishName] ?? 0;

                    return DataRow(
                      cells: [
                        DataCell(Text(dishName)),
                        DataCell(Text(price)),
                        DataCell(Text(quantity.toString())),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
      bottomSheet: Container(
        height: 300,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Total Bill: Rs. $bill",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)
                ),
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 60,
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                child: TextButton(
                  onPressed: () async {
                    await storebill(bill.toString());
                    PermissionStatus permissionStatus = await Permission.bluetooth
                        .request();
                    if (permissionStatus.isGranted) {
                      await createPDF();
                    }
                  },
                  child: Text(
                      "Print", style: TextStyle(fontSize: 22, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createPDF() async {
    final font=await PdfGoogleFonts.robotoLight();
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          mainAxisAlignment: pw.MainAxisAlignment.center,
          children: [
            pw.Text("Freinds Cafe",style: pw.TextStyle(font: font, fontSize: 40,fontBold:pw.Font.courierBold())),
            pw.SizedBox(height: 5),
            pw.Center(child: pw.Text("Goregaon, Gondia-441601",style: pw.TextStyle(font: font, fontSize: 25)),),
            pw.SizedBox(height: 10),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
              children: [
                pw.Text("Sr no.", style: pw.TextStyle(font: font, fontSize: 20)),
                pw.Text("Dish Name", style: pw.TextStyle(font: font, fontSize: 20)),
                pw.Text("Price", style: pw.TextStyle(font: font, fontSize: 20)),
              ],
            ),
            for (final item in cartItems.entries)
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                children: [
                  pw.Text(cartItems.keys.toList().indexOf(item.key).toString(), style: pw.TextStyle(font: font, fontSize: 18)),
                  pw.Text(item.key, style: pw.TextStyle(font: font, fontSize: 18)),
                  pw.Text(item.value, style: pw.TextStyle(font: font, fontSize: 18)),
                ],
              ),
            pw.SizedBox(height: 10),
            pw.Center(child: pw.Text("Total Price: $bill" ,style: pw.TextStyle(fontSize: 20)),
           ),
            pw.SizedBox(height: 10),
            pw.Center(child: pw.Text("Thanks ! Visit again" ,style: pw.TextStyle(fontSize: 20)),
            ),
          ],
        );
      },
    ));
    await Printing.layoutPdf(onLayout: (format) async{
      return pdf.save();
    });
  }
}