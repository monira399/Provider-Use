import 'package:flutter/material.dart';
import 'package:my_provider/provider/product_list_provider.dart';
import 'package:my_provider/screens/product_details_screen.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../provider/favourite_provider.dart';
import '../widgets/add_to_cart.dart';
import 'cart_list_screen.dart';
import 'favourite_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProductListProvider>().getProducts();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          children: [
            Icon(Icons.shopping_bag, color:Colors.white, size: 30),
            Text('EasyShop', style: TextStyle(fontWeight: FontWeight.bold),),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<FavouriteProvider>(
                    builder: (context, favouriteProvider, _) {
                      return Badge(
                        label: Text(favouriteProvider.favouriteCount.toString()),
                        child: IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteScreen()));
                        }, icon: Icon(Icons.favorite_outline, color: Colors.red.shade50)),
                      );
                    }
                ),
                Consumer<ProductListProvider>(
                  builder: (context, productListProvider, _) {
                    return Badge(
                      label: Text(productListProvider.cartItemCount.toString()),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => CartListScreen()),
                          );
                        },
                        icon: Icon(Icons.shopping_cart, color: Colors.white),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: Consumer<ProductListProvider>(
        builder: (context, productListProvider, _) {
          if(productListProvider.getProductsInProgress){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
            itemCount: productListProvider.productList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8
            ),
            itemBuilder: (context, index) {
              final ProductModel product = productListProvider.productList[index];
              final bool alreadyInCart = productListProvider.isAlreadyCarted(product.id);
              return Padding(
                padding: const EdgeInsets.all(8),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(productId:product.id)));
                  },
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Stack(
                        children: [
                          Positioned(
                              top: 0,
                              right: 0,
                              child: Consumer<FavouriteProvider>(
                                  builder: (context, favouriteProvider, _) {
                                    return IconButton(
                                      onPressed: (){
                                        context.read<FavouriteProvider>().toggleFavourite(product.id);

                                      },
                                      icon: Icon(
                                        favouriteProvider.isFavourite(product.id)
                                            ? Icons.favorite
                                            : Icons.favorite_outline,color: Colors.red,
                                      ),
                                    );
                                  }
                              ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Image.network(product.thumbnail, height: 90,
                                fit: BoxFit.contain),
                              ),
                              const SizedBox(height: 5),

                              Text('ID: ${product.id}', style: TextStyle(fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5),
                              Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),),
                              Text(product.description,
                              maxLines: 1, overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height:5),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('\$${product.price}'),
                                  Text('⭐ ${product.rating}'),
                                ],
                              ),
                              const SizedBox(height: 5),

                              SizedBox(
                                width: double.infinity,
                                child: AddToCart(product: product, showSnackBar: false),
                              ),

                            ],
                          ),

                        ]
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


