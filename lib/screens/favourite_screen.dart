import 'package:flutter/material.dart';
import 'package:my_provider/provider/favourite_provider.dart';
import 'package:my_provider/provider/product_list_provider.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {


  @override
  Widget build(BuildContext context) {
    final favouriteProvider = context.watch<FavouriteProvider>();
    final productListProvider = context.watch<ProductListProvider>();
    final favouriteIds = favouriteProvider.favouriteList;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Screen'),
      ),
      body: favouriteIds.isEmpty
          ? const Center(
        child: Text("No Favourite Products"),
      ) :
      Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: favouriteIds.length,
            itemBuilder: (context, index) {
            final favouriteId = favouriteIds[index];
            final product = productListProvider.productList.firstWhere((e) => e.id == favouriteId);
            return Card(
              margin: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8
              ),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              ),
              child: ListTile(
                leading: Image.network(product.thumbnail, height: 80,width: 80,fit:BoxFit.contain),
                title: Text(product.title, maxLines: 1,),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.brand),
                    Text('\$${product.price}'),
                  ],
                ),
                trailing: IconButton(
                  onPressed: () {
                    context.read<ProductListProvider>().removeFromCart(product.id);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ),

            );
            }),
      ),
    );
  }
}
