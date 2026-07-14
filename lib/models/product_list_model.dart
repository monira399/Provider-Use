import 'package:my_provider/models/product_model.dart';

class ProductListModel {
  final List<ProductModel> products;
  final int total;
  final int skip;
  final int limit;

  ProductListModel({
    required this.products,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    return ProductListModel(
        products: (json['products'] as List)
            .map((e) => ProductModel.fromJson(e))
            .toList(),
        total: json['total'],
        skip: json['skip'],
        limit: json['limit'],
    );
  }

  Map<String, dynamic>  toJson(){
    return {
      'products': products.map((e) => e.toJson()).toList(),
      'total': total,
      'skip': skip,
      'limit': limit,

    };
  }
}