import 'package:flutter/material.dart';
import 'package:my_provider/provider/product_list_provider.dart';
import 'package:provider/provider.dart';

class CartListScreen extends StatefulWidget {
  const CartListScreen({super.key});

  @override
  State<CartListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<CartListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Carts')),
      body: Consumer<ProductListProvider>(
        builder: (context, productListProvider, child) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 90),
              itemCount: productListProvider.cartList.length,
              itemBuilder: (context, index) {
                final product = productListProvider.cartList[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 10),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Image.network(
                      product.thumbnail,
                      height: 80,
                      width: 80,
                      fit: BoxFit.contain,
                    ),
                    title: Text(product.title, maxLines: 1),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.brand),
                        Text('\$${product.price}'),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<ProductListProvider>().removeFromCart(
                          product.id,
                        );
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Consumer<ProductListProvider>(
        builder: (context, provider, _) {
          return Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black12)],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total: \$${provider.totalPrice.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("${provider.cartItemCount} Items"),
                    ],
                  ),
                ),
                FilledButton(
                    style: FilledButton.styleFrom(
                        backgroundColor: Colors.orange.withOpacity(0.8),
                        foregroundColor: Colors.white
                    ),
                    onPressed: () {}, child: const Text('CheckOut')),
              ],
            ),
          );
        },
      ),
    );
  }
}
