class Urls{
  static const String _baseUrl = 'https://dummyjson.com';

  static const String loginUrl  = '$_baseUrl/auth/login';

  static const String productsUrl  = '$_baseUrl/products';

  static String singleProductsUrl(int id) => '$_baseUrl/products/$id';
}