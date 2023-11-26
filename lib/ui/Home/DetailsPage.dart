import 'package:ecommerce/Provider/cartProvider.dart';
import 'package:ecommerce/ui/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class DetailsPage extends StatefulWidget {
  String name,image,description;
  num id,price;
   DetailsPage({required this.id,required this.name,required this.price,required this.image,required this.description,super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
       body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width*0.8,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Image(image: NetworkImage(widget.image)),
                ),
                Positioned(
                  left: 15,
                  top: 20,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    child: IconButton(icon:Icon(Icons.arrow_back_ios_new,color: Colors.black,) ,
                    onPressed: (){
                      // Navigator.push(context, MaterialPageRoute(builder:(ctx)=>Home()));
                      Navigator.pop(context);
                    },
                  ),),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: (20)),
              width: double.infinity,
              decoration: BoxDecoration(color:Color.fromARGB(255, 230, 227, 227),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40),
              ) ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 2, 2, 1000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: (10)),
                      child: Text(widget.name,style: TextStyle(color: Colors.grey,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),),
                    ),
                     Text("Rs.${widget.price}",style: TextStyle(color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),),
                      SizedBox(
                        height: 20,
                      ),
                       Text(widget.description,
                       textScaleFactor:1.1,
                     style: TextStyle(color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w400),),
                       SizedBox(
                        height: 10,
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
       ),
                 bottomSheet: Padding(padding: EdgeInsets.all(10),child: 
         
              InkWell(
                onTap: (){
                   var existingItemcart=context.read<Cart>().getItems.firstWhereOrNull((element)=>element.id== widget.id);
                   if(existingItemcart !=null){
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 3),
                         behavior: SnackBarBehavior.floating,
                         padding: EdgeInsets.all(15),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(Radius.circular(10)),
                         ),
                         content: Text("this item already in cart",style: TextStyle(fontSize: 18,
                             fontFamily: "muli",color: Colors.white),)));

                   }else{
                     context.read<Cart>().addItem(widget.id.toInt(), widget.name, widget.price.toDouble(), 1, widget.image);
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(duration: Duration(seconds: 3),
                         behavior: SnackBarBehavior.floating,
                         padding: EdgeInsets.all(15),
                         shape: RoundedRectangleBorder(
                           borderRadius: BorderRadius.all(Radius.circular(10)),
                         ),
                         content: Text("Add to cart!!",style: TextStyle(fontSize: 18,
                             fontFamily: "muli",color: Colors.white),)));
                   }


                  },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black
                  ),
                  child: Center(child: Text("Add to Cart",style: TextStyle(fontSize: 20,color: Colors.white),)),
                ),
              )
        
          ),
      ),
    );
  }
}