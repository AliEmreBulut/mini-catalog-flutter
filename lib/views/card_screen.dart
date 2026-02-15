import 'package:flutter/material.dart';
import 'package:mini_catalog/models/product_model.dart';

import 'checkout_screen.dart';

class CardScreen extends StatefulWidget {
  final List<Data> products;
  final Set<int> cardIds;
  const CardScreen({super.key, required this.products, required this.cardIds});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    final cartProducts = widget.products.where((product) => widget.cardIds.contains(product.id)).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Cart",style: TextStyle(color: Colors.black),),
        leadingWidth: 20,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(child:

      Column(
        children: [
          cartProducts.isEmpty ?

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.shopping_cart_outlined,size: 64,
                  color: Colors.grey,),
                SizedBox(height: 4),
                Text("Your cart is empty.",style: TextStyle(color: Colors.grey),)
              ],
            ),

          )
              : Expanded(
            child: ListView.builder(
                itemCount: cartProducts.length,
                itemBuilder: (context,index){
                  final item = cartProducts[index];

                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius: 3,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(item.image!,width: 70, height: 70,fit: BoxFit.cover,)),

                          SizedBox(width: 12,),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.name!,
                                  style:
                                  TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                Text(item.tagline!,
                                  style: TextStyle(color: Colors.grey,fontSize: 13),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,),
                                SizedBox(height: 4),
                                Text(item.price!
                                  ,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue.shade800),),
                              ],
                            ),
                          ),


                          IconButton(onPressed: (){
                            setState(() {
                              widget.cardIds.remove(item.id);
                            });
                          }, icon: Icon(Icons.remove_circle_outline,color: Colors.red,))
                        ],
                      ),
                    ),
                  );
                }),
          ),

          SizedBox(height: 20,),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                if (cartProducts.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Cart is empty!"))
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CheckoutScreen(
                      products: widget.products,
                      cartIds: widget.cardIds,
                    ),
                  ),
                ).then((_) {
                  setState(() {});
                });
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  minimumSize: Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  )
              ),
              child: Text("Checkout", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      )
      ),
    );
  }
}