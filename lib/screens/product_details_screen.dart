import 'package:flutter/material.dart';
import 'package:my_provider/provider/product_list_provider.dart';
import 'package:my_provider/screens/order_success_screen.dart';
import 'package:my_provider/widgets/add_to_cart.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  const ProductDetailsScreen({super.key, required this.productId});
  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask((){
      context.read<ProductListProvider>().getSingleProduct(widget.productId);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Consumer<ProductListProvider>
        (builder: (context, provider, _) {

          if(provider.getSingleProductsInProgress){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.singleProduct == null) {
            return const Center(
              child: Text('No Product Found'),
            );
          }


          final product = provider.singleProduct!;
          
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Image.network(product.thumbnail, height: 200,fit: BoxFit.contain)),
                  SizedBox(height: 20,),
                  Text(product.title,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),),
                  Text(product.description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$${product.price}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber,),
                          Text('⭐ ${product.rating}'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.business,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Brand: ${product.brand}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          const Divider(height: 20),

                          Row(
                            children: [
                              const Icon(
                                Icons.inventory_2,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Stock: ${product.stock}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),

                  Row(
                    children: [
                      Expanded(
                          child: AddToCart(product: product, showSnackBar: true, height: 40,)),
                      SizedBox(width: 12,),
                      Expanded(child: FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.orange.withOpacity(0.8),
                            foregroundColor: Colors.white
                          ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OrderSuccessScreen()));
                          }, child: Text('Buy Now', style: TextStyle(fontWeight: FontWeight.bold),)))
                    ],
                  )
                ],
              ),
            ),
          );

        }),


    );
  }
}
