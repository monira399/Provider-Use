import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../provider/product_list_provider.dart';
import 'package:provider/provider.dart';

class AddToCart extends StatelessWidget {
  final ProductModel product;
  final bool showSnackBar;
  final double? height;


  const AddToCart({
    super.key,
    required this.product, this.showSnackBar = false, this.height,
  });



  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 30 ,
      width:double.infinity,
      child: FilledButton(
        onPressed: () {
          bool added = context.read<ProductListProvider>().addToCart(product);

          if(showSnackBar) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(
                  added ?
                  'Product added to cart successfully'
                      : 'Product is already in cart',style:
                TextStyle(color: Colors.white),),
                  backgroundColor: added ? Colors.teal : Colors.red,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(seconds: 1),)
            );

          }

        },
        child: Text('Add To Cart'),
      ),
    );
  }
}