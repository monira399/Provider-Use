import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductListProvider extends ChangeNotifier {
  final List<Product> _productList = [
    Product(
        id: 1,
        name: 'iphone',
        price: 120000,
        imageUrl: 'https://plus.unsplash.com/premium_photo-1779753391100-6ed78213c5b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    Product(
        id: 2,
        name: 'iphone',
        price: 120000,
        imageUrl: 'https://plus.unsplash.com/premium_photo-1779753391100-6ed78213c5b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    Product(
        id: 3,
        name: 'iphone',
        price: 120000,
        imageUrl: 'https://plus.unsplash.com/premium_photo-1779753391100-6ed78213c5b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    Product(
        id: 4,
        name: 'iphone',
        price: 120000,
        imageUrl: 'https://plus.unsplash.com/premium_photo-1779753391100-6ed78213c5b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    Product(
        id: 5,
        name: 'iphone',
        price: 120000,
        imageUrl: 'https://plus.unsplash.com/premium_photo-1779753391100-6ed78213c5b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
    Product(
        id: 6,
        name: 'iphone',
        price: 120000,
        imageUrl: 'https://plus.unsplash.com/premium_photo-1779753391100-6ed78213c5b4?q=80&w=870&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),

  ];

  final List<Product> _cartList = [];

  List<Product> get productList => _productList;

  List<Product> get cartList => _cartList;

  int get cartItemCount => _cartList.length;


  void addToCart(Product p) {
    if (isAlreadyCarted(p.id)) {
      return;
    }
    _cartList.add(p);
    notifyListeners();
  }

  void removeFromCart(int id) {
    _cartList.removeWhere((e) => e.id == id);
    notifyListeners();
  }

  bool isAlreadyCarted(int id) {
    return _cartList.where((e) => e.id == id).isNotEmpty;
  }

}