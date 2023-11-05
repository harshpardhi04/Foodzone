class menuModel {
  late String foodname;
  late int price;
  late int? id;

  menuModel({this.id,required this.foodname,required this.price});

  menuModel.fromMap(Map<String,dynamic> res){
    id=res['id'];
    foodname=res['foodname'];
    price=res['price'];
   }
    Map<String,Object?> toMap(){
     return{
       'id':id,
       'foodname':foodname,
       'price':price
     };
    }
}