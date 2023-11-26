import 'package:ecommerce/Provider/cartProvider.dart';
import 'package:ecommerce/ui/Home/cart.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
class DrawerWidgets extends StatefulWidget {
  const DrawerWidgets({super.key});

  @override
  State<DrawerWidgets> createState() => _DrawerWidgetsState();
}

class _DrawerWidgetsState extends State<DrawerWidgets> {
  @override
  Widget build(BuildContext context) {
    return Drawer(backgroundColor:Colors.white ,
      child: SafeArea(
        child:ListView(
          padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 50,
          ),
          Align(alignment: Alignment.center,
            child: Text("E commerce",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
            SizedBox(
            height: 20,
          ), 
          Divider(),
           SizedBox(
            height: 10,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home",style: TextStyle(fontSize: 15),),
             trailing: Icon(Icons.arrow_forward_ios,size: 15,),
          ),
           InkWell(onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>CartPage()));
           },
             child: ListTile(
              leading: badges.Badge(
                badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
                showBadge: context.read<Cart>().getItems.isEmpty?false:true,
                  badgeContent: Text(context.watch<Cart>().getItems.length.toString(),style: TextStyle(fontSize: 10,fontWeight: FontWeight.w600,color: Colors.white),),
                  child: Icon(Icons.shopping_cart)),
              title: Text("Cart",style: TextStyle(fontSize: 15),),
               trailing: Icon(Icons.arrow_forward_ios,size: 15,),
                     ),
           ), ListTile(
            leading: Icon(Icons.shopping_bag),
            title: Text("Order details",style: TextStyle(fontSize: 15),),
             trailing: Icon(Icons.arrow_forward_ios,size: 15,),
          ), ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text("Logout",style: TextStyle(fontSize: 15),),
             trailing: Icon(Icons.arrow_forward_ios,size: 15,),
          ),
        ],
      )),
    );
  }
}