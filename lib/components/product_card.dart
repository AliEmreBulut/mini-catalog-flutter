import 'package:flutter/material.dart';
import 'package:mini_catalog/models/product_model.dart';

class ProductCard extends StatefulWidget {
  final Data product;
  final Set<int> cartIds;
  final Set<int> favoriteIds;
  const ProductCard({super.key, required this.product,
    required this.cartIds, required this.favoriteIds});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    final isFavorite = widget.favoriteIds.contains(widget.product.id);

    return Container(
      decoration: BoxDecoration(
        color:Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(
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
              Hero(tag: widget.product.id!,
                child:
                ClipRRect(
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12)
                  ),
                  child: Image.network(widget.product.image ?? '',
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isFavorite) {
                        widget.favoriteIds.remove(widget.product.id);
                      } else {
                        widget.favoriteIds.add(widget.product.id!);
                      }
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        )
                      ],
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                      size: 18,
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
                Text(widget.product.name ?? "",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,),

                SizedBox(height: 2,),
                Text(widget.product.tagline ?? "",overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.grey),),

                SizedBox(height: 2),

                Text(widget.product.price ?? "",style: TextStyle(color: Colors.blue.shade800,fontWeight: FontWeight.bold)),
              ],
            ),
          ),



        ],
      ),
    );

  }
}