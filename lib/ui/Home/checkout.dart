import 'dart:convert';

import 'package:ecommerce/Provider/cartProvider.dart';
import 'package:ecommerce/ui/Home/Home.dart';
import 'package:ecommerce/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CheckOut extends StatefulWidget {
  List<CartProduct> cart;
  CheckOut({super.key, required this.cart});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUsername();
  }

  int selectedvalue = 1;
  String? paymentmethord = "cash on delivery";
  String? username;
  String? name, address, phone;
  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      var username = prefs.getString("userName");
    });
    print("is loginusername${username.toString()} ");
  }

  orderPlace(
    List<CartProduct> cart,
    String amount,
    String Paymentmethord,
    String date,
    String name,
    String address,
    String phone,
  ) async {
    String jsondata = jsonEncode(cart);
    print("jsondata${jsondata}");
    final vm = Provider.of<Cart>(context, listen: false);
    final response =
        await http.post(Uri.parse(Webservice().mainurl + "order.jps"), body: {
      "username": username,
      "amount": amount,
      "paymentmethord": paymentmethord,
      "date": date,
      "quantity": vm.Count.toString(),
      "cart": jsondata,
      "name": name,
      "address": address,
      "phone": phone,
    });
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body.contains("Success")) {
        vm.ClearCart();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
            padding: EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            content: Text(
              "YOUR ORDER SUCCESSFULLY COMPLETED",
              style: TextStyle(
                  fontSize: 18, fontFamily: "muli", color: Colors.white),
            )));
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => Home()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<Cart>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.grey.shade100,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          "CheckOut",
          style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: Webservice().fetchUser(username.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String name = snapshot.data!.name;
                      String phone = snapshot.data!.phone;
                      String address = snapshot.data!.address;
                    }
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "name",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  name.toString(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Phone",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  phone.toString(),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Address",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Text(
                                      address.toString(),
                                      maxLines: 6,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            RadioListTile(
                title: Text("cash on delivery"),
                subtitle: Text("pay cash at home"),
                activeColor: Colors.red,
                value: 1,
                groupValue: selectedvalue,
                onChanged: (int? value) {
                  setState(() {
                    selectedvalue = value!;
                    paymentmethord = "cash on delivery";
                  });
                }),
            RadioListTile(
                title: Text("Pay Now"),
                subtitle: Text("online Payment"),
                activeColor: Colors.red,
                value: 2,
                groupValue: selectedvalue,
                onChanged: (int? value) {
                  setState(() {
                    selectedvalue = value!;
                    paymentmethord = "online payment";
                  });
                }),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            String datetime = DateTime.now().toString();
            orderPlace(widget.cart, vm.tolalprice.toString(), paymentmethord!,
                datetime, name!, address!, phone!);
            print( orderPlace(widget.cart, vm.tolalprice.toString(), paymentmethord!,
                datetime, name!, address!, phone!));
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
            ),
            child: Center(
                child: Text(
              "Chheckout",
              style: TextStyle(fontSize: 20, color: Colors.white),
            )),
          ),
        ),
      ),
    );
  }
}
