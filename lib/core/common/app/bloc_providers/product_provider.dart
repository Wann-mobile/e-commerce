import 'package:e_triad/src/products/domain/entity/product.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider._internal();

  static final instance = ProductProvider._internal();

  Product? _selectedProduct;

  Product? get selectedProduct => _selectedProduct;

  

  void setSelectedProduct(Product product) {
    _selectedProduct = product;
  }
  
  

}
