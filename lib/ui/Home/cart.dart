import 'package:ecommerce/Provider/cartProvider.dart';
import 'package:ecommerce/ui/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartProduct> Cartlist = [];
  @override
  Widget build(BuildContext context) {
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
          "Cart",
          style: TextStyle(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontSize: 25,
              fontWeight: FontWeight.bold),
        ),
        actions: [ context.watch<Cart>().getItems.isEmpty?SizedBox():
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () {
              context.read<Cart>().ClearCart();
            },
          )
        ],
      ),
      body: context.watch<Cart>().getItems.isEmpty?Center(
        child: Text("Empty cart"),
      ):
      Consumer<Cart>(builder: (context, cart, child) {
        Cartlist = cart.getItems;
        return ListView.builder(
            itemCount: cart.Count,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SizedBox(
                      height: 100,
                      child: Row(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 100,
                            child: Padding(
                              padding: EdgeInsets.only(left: 9),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            Cartlist[index].imageUrl),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                          ),
                          Flexible(
                              child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    Cartlist[index].name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        Cartlist[index].price.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red),
                                      ),
                                      Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  cart.getItems[index].qty==1?cart.removeItem(cart.getItems[index]):
                                                      cart.reduceByone(cart.getItems[index]);
                                                },
                                                icon: Icon(
                                                  Icons.minimize_rounded,
                                                  size: 18,
                                                )),
                                            Text(
                                             cart.getItems[index].qty.toString(),
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  cart.increment(cart.getItems[index]);
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  size: 18,
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                        ],
                      )),
                ),
              );
            });
      }),
      bottomSheet: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Tolel: " + context.watch<Cart>().tolalprice.toString(),
              style: TextStyle(
                  color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            InkWell(onTap: (){
      context.read<Cart>().getItems.isEmpty?
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          content: Text("cart  is empty",style: TextStyle(fontSize: 18,
              fontFamily: "muli",color: Colors.white),))):
      Navigator.push(context, MaterialPageRoute(builder:(ctx)=>Home()));

  },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 2.2,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.black),
                child: Center(
                    child: Text(
                  "Order Now",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
