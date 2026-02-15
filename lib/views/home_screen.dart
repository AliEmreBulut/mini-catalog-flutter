import 'package:flutter/material.dart';
import 'package:mini_catalog/components/product_card.dart';
import 'package:mini_catalog/models/product_model.dart';
import 'package:mini_catalog/services/api_service.dart';
import 'package:mini_catalog/views/card_screen.dart';
import 'package:mini_catalog/views/favorites_screen.dart';
import 'package:mini_catalog/views/product_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  ApiService apiService = ApiService();
  bool isLoading = false;
  String errorMessage = "";
  List<Data> allProducts = [];
  Set<int> cartIds = {};
  Set<int> favoriteIds = {};

  Future<void> fetchProducts () async {
    try {
      setState(() {
        isLoading = true;
      });

      ProductsModel data = await apiService.fetchProducts();

      setState(() {
        allProducts = data.data ?? [];
      });


    } catch (e) {
      setState(() {
        errorMessage = "Failed to load products.";
      });

    }finally{
      setState(() {
        isLoading = false;
      });
    }

  }


  @override
  void initState() {
    fetchProducts();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: SafeArea(child: Padding(padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discover",
                  style: TextStyle(fontSize: 34,fontWeight: FontWeight.bold),),

                Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesScreen(
                            products: allProducts,
                            favoriteIds: favoriteIds,
                            cartIds: cartIds,
                          ))).then((_) {
                            setState(() {});
                          });
                          },
                        iconSize: 32,
                        icon: Icon(Icons.favorite_border)),

                    IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => CardScreen(
                            products: allProducts,
                            cardIds: cartIds,
                          )));
                        },
                        iconSize: 32,
                        icon: Icon(Icons.shopping_bag_outlined)),
                  ],
                ),
              ],
            ),

            SizedBox(height: 8),

            Text(
              "Find your perfect device.",
              style: TextStyle(color: Colors.grey),
            ),

            SizedBox(height: 14),

            Container(decoration: BoxDecoration(
                color: Color(0xfff5f5f7),
                borderRadius: BorderRadius.circular(12)
            ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search products",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search,color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 14),

                ),
              ),
            ),

            SizedBox(height: 16),

            Container(width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(image: NetworkImage("https://wantapi.com/assets/banner.png"
                  ),
                    fit: BoxFit.fitWidth,
                  )
              ),
            ),
            SizedBox(height: 16,),
            if(isLoading)
              Center(child: CircularProgressIndicator(),)
            else if (errorMessage != "")
              Center(child: Text(errorMessage),)
            else
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: allProducts.length,
                  itemBuilder: (context, index){
                    final product = allProducts[index];

                    return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: product,
                                cartIds: cartIds,
                                favoriteIds: favoriteIds,
                              ),
                            ),
                          ).then((_) {
                            setState(() {});
                          });
                        },
                        child: ProductCard(
                          product: product,
                          cartIds: cartIds,
                          favoriteIds: favoriteIds,
                        ));
                  },
                ),
              ),
          ],
        ),
      ),
      ),
    );
  }
}