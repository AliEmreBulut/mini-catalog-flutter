import 'package:flutter/material.dart';


class ProductDetailScreen extends StatefulWidget {
  final product;
  final Set<int> cartIds;
  final Set<int> favoriteIds;

  const ProductDetailScreen({super.key, required this.product,
    required this.cartIds, required this.favoriteIds});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final isFavorite = widget.favoriteIds.contains(widget.product.id);
    final isInCart = widget.cartIds.contains(widget.product.id);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Back",style: TextStyle(
            color: Colors.black
        ),),
        leadingWidth: 20,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                if (isFavorite) {
                  widget.favoriteIds.remove(widget.product.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Removed from favorites"),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red.shade600,
                        margin: EdgeInsets.only(
                          bottom: 70,
                          left: 20,
                          right: 20,
                        ),
                      )
                  );
                } else {
                  widget.favoriteIds.add(widget.product.id!);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Added to favorites"),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.pink.shade600,
                        margin: EdgeInsets.only(
                          bottom: 70,
                          left: 20,
                          right: 20,
                        ),
                      )
                  );
                }
              });
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.black,
            ),
          ),
        ],
      ),

      body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.product.id,
                  child: Image.network(widget.product.image ?? "",height: 350,width: double.infinity,
                    fit: BoxFit.cover,),
                ),

                SizedBox(height: 2),

                Padding(padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:   CrossAxisAlignment.start,
                    children: [
                      Text(widget.product.name ?? "",style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold),),

                      SizedBox(height: 2),

                      Text(widget.product.tagline ?? "",style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey,
                      ),
                      ),


                      SizedBox(height: 10),
                      Text("Description",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),

                      SizedBox(height: 2,),

                      Text(widget.product.description),

                      SizedBox(height: 10,),

                      Text(widget.product.price ?? "", style: TextStyle(fontSize: 28,fontWeight: FontWeight.bold,color: Colors.blue.shade800),),

                      SizedBox(height: 14),

                      ElevatedButton(onPressed: (){
                        if (isInCart) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Already in cart"),
                                behavior: SnackBarBehavior.floating,
                                backgroundColor: Colors.orange.shade600,
                                margin: EdgeInsets.only(
                                  bottom: 70,
                                  left: 20,
                                  right: 20,
                                ),
                              )
                          );
                          return;
                        }

                        setState(() {
                          widget.cartIds.add(widget.product.id!);
                        });

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Added to cart"),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green.shade600,
                          margin: EdgeInsets.only(
                            bottom: 70,
                            left: 20,
                            right: 20,
                          ),


                        )


                        );




                      },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isInCart ? Colors.grey : Colors.black,
                            minimumSize: Size(double.infinity,45),
                          ),
                          child: Text(isInCart ? "Already in Cart" : "Add to Cart",style: TextStyle(color: Colors.white),))

                    ],
                  ),)
              ],
            ),
          )),
    );
  }
}