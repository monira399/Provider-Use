import 'package:flutter/material.dart';
import 'package:my_provider/product_list_app/screens/cart_list_screen.dart';
import 'package:my_provider/provider/product_list_provider.dart';
import 'package:provider/provider.dart';

import '../../models/product_model.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
        actions: [
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
                  icon: Icon(Icons.shopping_cart),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<ProductListProvider>(
        builder: (context, productListProvider, _) {
          return GridView.builder(
            itemCount: productListProvider.productList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final Product product = productListProvider.productList[index];
              final bool alreadyInCart = productListProvider.isAlreadyCarted(product.id);;
              return Card(
                child: Column(
                  children: [
                    Image.network(product.imageUrl, height: 80),
                    Text(product.name),
                    Text("\$${product.price}"),
                    FilledButton(
                      onPressed: () {
                        if (alreadyInCart) {
                          context.read<ProductListProvider>().removeFromCart(
                            product.id,
                          );
                        } else {
                          context.read<ProductListProvider>().addToCart(
                            product
                          );
                        }
                      },
                      child: Text(alreadyInCart ? 'Remove' : 'Add To Cart'),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
