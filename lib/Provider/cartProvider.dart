


import 'package:flutter/cupertino.dart';

class Cart extends ChangeNotifier {
  final List<CartProduct>_list=[];
  List<CartProduct>get getItems{
    return _list;
  }
  double get tolalprice{
    var total=0.0;
    for (var item in _list){
      total=total+(item.price*item.qty);
    }return total;
  }
  int? get Count{
    return _list.length;
  }
  void addItem(
  int id,
  String name,
  double price,
  int qty,
  String imageUrl,
      ){
    final product=CartProduct(
        id: id,
        name: name,
        price: price,
        qty: qty,
        imageUrl: imageUrl);
    _list.add(product);
    notifyListeners();
  }
void increment (CartProduct product){
    product.increase();
    notifyListeners();
}
  void reduceByone (CartProduct product){
    product.decrease();
    notifyListeners();
  }
  void removeItem (CartProduct product){
    _list.remove(product);
    notifyListeners();
  }
  void ClearCart (){
    _list.clear();
    notifyListeners();
  }
}

  class CartProduct{
  int id;
  String name;
  double price;
  int qty=1;
  String imageUrl;
  CartProduct({required this.id,
    required this.name,
    required this.price,
    required this.qty,
    required this.imageUrl,});
  factory CartProduct.fromJson(Map<String,dynamic>json)=>CartProduct(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      qty: json["qty"],
      imageUrl: json["imageUrl"]);
  Map<String,dynamic>toJson()=>
      {
        "id": id,
        "name": name,
        "price": price,
        "qty": qty,
        "image": imageUrl,

      };

  void increase(){
    qty++;
  }
  void decrease(){
    qty--;
  }}



