import 'package:e_triad/src/cart_product/presentation/cart_cubit.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  CartProvider._internal();

  static final instance = CartProvider._internal();

  // Store selected size per product
  final Map<String, String> _selectedSizes = {};

  final _subTotal = ValueNotifier<int>(0);

  int getTotalPrices({required CartState state}) {
    if (state is StateFetchedUserCart) {
      for (dynamic cartItem in state.cartProducts) {
        final productPrice =
            (cartItem.productPrice.toInt()) * (cartItem.quantity ?? 0);
        _subTotal.value += productPrice as int;
      }
      return _subTotal.value;
    }
    return 0;
  }

  int get subtotal => _subTotal.value;

  String getSelectedSize(String productId) {
    return _selectedSizes[productId] ?? 'S';
  }

  // Set selected size for a specific product
  void setSelectedSize(String productId, String size) {
    _selectedSizes[productId] = size;
    notifyListeners();
  }
}
