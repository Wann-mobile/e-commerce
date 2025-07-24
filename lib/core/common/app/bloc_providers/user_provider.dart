
import 'package:e_triad/core/common/user_related_entities/user.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserProvider._internal() ;

  static final instance = UserProvider._internal();

  User? _currentUser;

  User? get currentUser => _currentUser;

  void setUser(User? user) {
    if (_currentUser != user) _currentUser =user;
  }

  void setUsernull() {
   _currentUser = null;
  }

  void updateUser(User user){
    if(_currentUser != user) _currentUser =user;
    notifyListeners();
  }

  bool isProductInWishlist(String productId) {
  return _currentUser?.wishlist
      .any((item) => item.productId == productId) ?? false;
}
}
