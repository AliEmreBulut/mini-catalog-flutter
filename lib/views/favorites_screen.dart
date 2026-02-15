import 'package:flutter/material.dart';
import 'package:mini_catalog/models/product_model.dart';
import 'package:mini_catalog/views/product_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Data> products;
  final Set<int> favoriteIds;
  final Set<int> cartIds;
  const FavoritesScreen({super.key, required this.products, required this.favoriteIds, required this.cartIds});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final favoriteProducts = widget.products.where((product) => widget.favoriteIds.contains(product.id)).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Favorites",style: TextStyle(color: Colors.black),),
        leadingWidth: 20,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(child:

      favoriteProducts.isEmpty ?

      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border,size: 64,
              color: Colors.grey,),
            SizedBox(height: 8),
            Text("No favorites yet.",style: TextStyle(color: Colors.grey,fontSize: 16),),
            SizedBox(height: 4),
            Text("Start adding products you love!",style: TextStyle(color: Colors.grey.shade400,fontSize: 14),)
          ],
        ),

      )
          : Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = favoriteProducts[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product, cartIds: widget.cartIds, favoriteIds: widget.favoriteIds)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          blurRadius: 5,
                          offset: Offset(0, 3)
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12)
                            ),
                            child: Image.network(
                              product.image ?? '',
                              width: double.infinity,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.favoriteIds.remove(product.id);
                                });
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
                              },
                              child: Container(
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name ?? "",
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 2),
                            Text(
                              product.tagline ?? "",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 4),
                            Text(
                                product.price ?? "",
                                style: TextStyle(
                                    color: Colors.blue.shade800,
                                    fontWeight: FontWeight.bold
                                )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
        ),
      )
      ),
    );
  }
}