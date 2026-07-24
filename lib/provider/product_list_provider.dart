import 'package:flutter/material.dart';
import 'package:my_provider/apiServices/api_caller.dart';
import 'package:my_provider/models/product_list_model.dart';
import '../data/utils/urls.dart';
import '../models/product_model.dart';

class ProductListProvider extends ChangeNotifier {

  bool _getProductsInProgress = false;

  bool _getSingleProductsInProgress = false;
  bool get getSingleProductsInProgress => _getSingleProductsInProgress;

  bool get getProductsInProgress => _getProductsInProgress;

  List<ProductModel> _productList = [];
  List<ProductModel> _filterProductsList =[];
  List<ProductModel> get productList => _filterProductsList;



  ProductModel? _singleProduct;
  ProductModel? get singleProduct => _singleProduct;

   List<ProductModel> _cartList = [];
  List<ProductModel> get cartList => _cartList;

  int get cartItemCount => _cartList.length;

  double get totalPrice {
    double total =0;
     for(ProductModel product in _cartList){
       total += product.price;
     }
     return total;
  }

  void searchProducts(String query) {
    if(query.isEmpty){
      _filterProductsList = List.from(_productList);
    }else {
      _filterProductsList = _productList.where((product) {
        return product.title
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

Future<void> getProducts() async {
  _getProductsInProgress = true;
  notifyListeners();

  try {
    final ApiResponse response = await ApiCaller.getRequest(
        url: Urls.productsUrl);

    if (response.isSuccess) {
      ProductListModel model = ProductListModel.fromJson(response.responseData);
      _productList = model.products;
      _filterProductsList = List.from(_productList);
    } else {
      _productList = [];
      _filterProductsList =[];
    }
  } on Exception catch (e) {
    _productList = [];
    _filterProductsList =[];
    print('Error: $e');
  }

       _getProductsInProgress = false;
       notifyListeners();

}

Future<void> getSingleProduct(int id)async {
  _getSingleProductsInProgress = true;
  notifyListeners();

  try {
    ApiResponse response =await ApiCaller.getRequest(url: Urls.singleProductsUrl(id));
    if(response.isSuccess){
      _singleProduct = ProductModel.fromJson(response.responseData);
    } else{
      _singleProduct = null;
    }
  } on Exception catch (e) {
    _singleProduct = null;
    print('Error: $e');
  }
  _getSingleProductsInProgress = false;
  notifyListeners();


}

void toggleCart(ProductModel product){
  if(isAlreadyCarted(product.id)){
    removeFromCart(product.id);
  }else {
    addToCart(product);
  }
}

  bool addToCart(ProductModel product){
  if(isAlreadyCarted(product.id)){
    return false;
  }else{
    _cartList.add(product);
    notifyListeners();
    return true;
  }
  }

  void removeFromCart(int id) {
    _cartList.removeWhere((e) => e.id == id);
    notifyListeners();
  }
  
  bool isAlreadyCarted(int id){
  return _cartList.any((e) => e.id == id);
  }
}