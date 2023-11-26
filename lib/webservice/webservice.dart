
import 'dart:convert';
import 'package:ecommerce/model/OfferProductModel.dart';
import 'package:ecommerce/model/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce/model/categoryModel.dart';


class Webservice {
  final imageurl="https://bootcamp.cyralearnings.com/products/";
  final mainurl="https://bootcamp.cyralearnings.com/";


  Future<List<CategoryModel>?>fetchCategory()async{
try{
final response=await http.get(Uri.parse(mainurl+"getcategories.php"));
if (response.statusCode==200){
  final parsed =json.decode(response.body).cast<Map<String,dynamic>>();

  return parsed 
  .map<CategoryModel>((json)=>CategoryModel.fromJson(json)).toList();
}else{
  throw Exception("Failed load Category");
}
}catch(e){
print(e.toString());
}
  }


 Future<List<OfferProductModel>?> fetchProducts()async{
try{
final response=await http.get(Uri.parse(mainurl+"view_offerproducts.php"));
if (response.statusCode==200){
  final parsed =json.decode(response.body).cast<Map<String,dynamic>>();

  return parsed 
  .map<OfferProductModel>((json)=>OfferProductModel.fromJson(json)).toList();
}else{
  throw Exception("Failed load Category");
}
}catch(e){
print(e.toString());
}
  }

   Future<List<OfferProductModel>?> fetchCatProducts(int catid)async{
    print("catid"+catid.toString());
try{
final response=await http.post(Uri.parse(mainurl+"get_category_products.php"),body: {"catid":catid.toString()});
print("response =="+response.body.toString());

if (response.statusCode==200){
  final parsed =json.decode(response.body).cast<Map<String,dynamic>>();

  return parsed 
  .map<OfferProductModel>((json)=>OfferProductModel.fromJson(json)).toList();
}else{
  throw Exception("Failed load Category");
}
}catch(e){
print(e.toString());
}
  }
  Future<UserModel>? fetchUser(String username)async{
    print("username"+username.toString());

      final response=await http.post(Uri.parse(mainurl+"get_user.php"),body: {"username":username});
      print("response =="+response.body.toString());

      if (response.statusCode==200){
        return UserModel.fromJson(jsonDecode(response.body));
      }else{
        throw Exception("Failed load Category");
      }

  }
}