import 'package:ecommerce/ui/Home/DetailsPage.dart';
import 'package:ecommerce/webservice/webservice.dart';
import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class CategoryPage extends StatefulWidget {
  String catname;
  int catid;

  CategoryPage({required this.catname, required this.catid, super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade100,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.catname,
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: FutureBuilder(
          future: Webservice().fetchCatProducts(widget.catid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StaggeredGridView.countBuilder(
                itemCount: snapshot.data!.length,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                staggeredTileBuilder: (context) => StaggeredTile.fit(1),
                crossAxisCount: 2,
                itemBuilder: (ctx, index) {
                  final product=snapshot.data![index];
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => DetailsPage(price: product.price,id:product.id,name:product.productname ,image:Webservice().imageurl+product.image  ,description:product.description  ,)));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(children: [
                          ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Container(
                                constraints: BoxConstraints(
                                  minHeight: 100,
                                  maxHeight: 250,
                                ),
                                child: Image(
                                  image: NetworkImage(Webservice().imageurl +
                                      snapshot.data![index].image),
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    snapshot.data![index].productname,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Rs.${snapshot.data![index].price}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ]),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
