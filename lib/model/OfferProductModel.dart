import 'dart:convert';

class OfferProductModel {
    int id;
    int catid;
    String productname;
    double price;
    String image;
    String description;

    OfferProductModel({
        required this.id,
        required this.catid,
        required this.productname,
        required this.price,
        required this.image,
        required this.description,
    });

    factory OfferProductModel.fromJson(Map<String, dynamic> json) => OfferProductModel(
        id: json["id"],
        catid: json["catid"],
        productname: json["productname"],
        price: json["price"]?.toDouble(),
        image: json["image"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "catid": catid,
        "productname": productname,
        "price": price,
        "image": image,
        "description": description,
    };
}
