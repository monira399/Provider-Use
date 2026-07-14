class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final double rating;
  final String thumbnail;
  final String brand;
  final int stock;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.thumbnail,
    required this.brand,
    required this.stock,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: (json['price'] as num).toDouble(),
        rating: (json['rating'] as num).toDouble(),
      thumbnail: json['thumbnail'],
      brand: json['brand']?.toString() ?? '',
      stock: json['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'rating': rating,
      'thumbnail': thumbnail,
      'brand': brand,
      'stock': stock
    };
  }

}
