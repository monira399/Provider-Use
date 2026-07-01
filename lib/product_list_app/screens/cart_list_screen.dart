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
      appBar: AppBar(
        title: Text('Carts'),
      ),
      body: Consumer<ProductListProvider>(
        builder: (context, productListProvider, child) {
          return ListView.builder(
            itemCount: productListProvider.cartList.length,
              itemBuilder: (context, index) {
              return ListTile(
                title: Text(productListProvider.cartList[index].name),
                trailing: IconButton(onPressed: (){}, icon: Icon(Icons.delete)),

              );
              });
        }
      ),
    );
  }
}
